import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:poetry_app/Data/Models/FirebaseUser.dart';
import 'package:poetry_app/Data/Models/PoemModel.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:poetry_app/Data/Models/PublishedPoemModel.dart';

@singleton
class DataService {
  // Instance of firestore database
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Instance of firebase storage (used to upload files)
  final _storage = FirebaseStorage.instance;

  Future<void> addPoemDraft(String userId, PoemModel poem, File? photo) async {
    if (userId.isNotEmpty) {
      // Create a draft with a random id
      CollectionReference collectionRef =
          _db.collection("Poems/$userId/Drafts");

      // Add poem without photo
      DocumentReference docRef = await collectionRef.add(poem.toMap());

      // If there is a photo add it to storage and set the url of the model
      if (photo != null) {
        log("Uploading photo to storage...");
        var photoRef = _storage.ref("Poems/$userId/${docRef.id}/picture.jpg");
        await photoRef
            .putFile(
                photo,
                SettableMetadata(
                  contentType: "image/jpeg",
                ))
            .catchError((error) => log('Failed setting photo URL: $error'));
        docRef.update({"photoURL": await photoRef.getDownloadURL()}).catchError(
            (error) => log('Failed setting photo URL: $error'));
      } else {
        log("No photo found");
      }
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getPoemDrafts(String userId) {
    return _db.collection("Poems/$userId/Drafts").snapshots();
  }

  void publishPoem(PoemModel poem, FirebaseUser user) async {
    PublishedPoemModel publishedPoem = PublishedPoemModel(poem.id, poem.title,
        poem.content, poem.photoURL, Timestamp.now(), user);
    Map<String, dynamic> poemData = publishedPoem.toMap();
    poemData.remove('isPublished');
    _db.collection('PublicPoems').doc(poem.id).set(poemData);
    _db
        .collection('Poems/${user.userId}/Drafts')
        .doc(poem.id)
        .update({"isPublished": true});
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getPublishedPoems() {
    return _db
        .collection("PublicPoems")
        .orderBy("publishedDate", descending: true)
        .snapshots();
  }

  Future<void> addPoemToFavourites(String userId, String poemId) async {
    try {
      // get the poem  from PublicPoems collection
      DocumentSnapshot poemToBeFavourited =
          await _db.collection('PublicPoems').doc(poemId).get();

      // get ref to the Favourites collection
      CollectionReference collectionRef =
          _db.collection('Poems/$userId/Favourites');

      // add it to the Favourites collection
      await collectionRef
          .doc(poemToBeFavourited.id)
          .set(poemToBeFavourited.data());
    } catch (e) {
      print(e);
    }
  }

  Future<void> removePoemFromFavourites(String userId, String poemId) async {
    try {
      // delete the poem  from favourites collection
      await _db.collection('Poems/$userId/Favourites').doc(poemId).delete();
    } catch (e) {
      print(e);
    }
  }

  Future<bool> isPoemFavourited(String userId, String poemId) async {
    return (await _db.collection('Poems/$userId/Favourites').doc(poemId).get())
        .exists;
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getFavouritedPoems(
      String userId) {
    return _db.collection("Poems/$userId/Favourites").snapshots();
  }

  Future<void> deleteDraft(String userId, String poemId) async {
    await _db.collection("Poems/$userId/Drafts").doc(poemId).delete();
  }

  Future<void> deletePublishedPoem(String userId, String poemId) async {
    await _db.runTransaction((transaction) async {
      DocumentReference draftRef =
          _db.collection("Poems/$userId/Drafts").doc(poemId);
      DocumentReference publicPoemRef =
          _db.collection("PublicPoems").doc(poemId);
      transaction.delete(draftRef);
      transaction.delete(publicPoemRef);
    });
  }

  // New methods for liking and unliking poems

  Future<void> likePoem(String userId, String poemId) async {
    DocumentReference poemRef = _db.collection('PublicPoems').doc(poemId);
    DocumentReference userLikeRef = poemRef.collection('likes').doc(userId);

    await _db.runTransaction((transaction) async {
      DocumentSnapshot userLikeSnapshot = await transaction.get(userLikeRef);
      if (!userLikeSnapshot.exists) {
        transaction.set(userLikeRef, {'likedAt': FieldValue.serverTimestamp()});
        transaction.update(poemRef, {'likesCount': FieldValue.increment(1)});
      }
    });
  }

  Future<void> unlikePoem(String userId, String poemId) async {
    DocumentReference poemRef = _db.collection('PublicPoems').doc(poemId);
    DocumentReference userLikeRef = poemRef.collection('likes').doc(userId);

    await _db.runTransaction((transaction) async {
      DocumentSnapshot userLikeSnapshot = await transaction.get(userLikeRef);
      if (userLikeSnapshot.exists) {
        transaction.delete(userLikeRef);
        transaction.update(poemRef, {'likesCount': FieldValue.increment(-1)});
      }
    });
  }

  Future<bool> isPoemLiked(String userId, String poemId) async {
    DocumentSnapshot userLikeSnapshot = await _db
        .collection('PublicPoems')
        .doc(poemId)
        .collection('likes')
        .doc(userId)
        .get();
    return userLikeSnapshot.exists;
  }
}
