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
  // instance of firestore database
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // instance of firebase storage (used to upload files)
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
    _db.collection('PublicPoems').doc(poem.id).set(publishedPoem.toMap());
    _db
        .collection('Poems/${user.userId}/Drafts')
        .doc(poem.id)
        .update({"isPublished": true});
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getPublishedPoems() {
    return _db.collection("PublicPoems").snapshots();
  }
}
