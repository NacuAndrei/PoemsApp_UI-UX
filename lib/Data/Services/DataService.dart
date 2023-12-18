import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:poetry_app/Data/Models/PoemModel.dart';

@singleton
class DataService {
  // instance of firestore database
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> addPoemDraft(String userId, PoemModel poem) async {
    _db
        .collection("Poems/$userId/Drafts")
        .add(poem.toMap())
        .then((doc) => {log('Private poem added with ID: ${doc.id}')});
  }

  Future<void> getPoemDrafts(String userId, List<PoemModel> poemDrafts) async {
    _db.collection("Poems/$userId/Drafts").snapshots().listen((event) {
      poemDrafts.clear();
      for (var doc in event.docs) {
        poemDrafts.add(PoemModel.fromDocumentSnapshot(doc));
      }
      print("Loaded ${poemDrafts.length} poem drafts");
    });
  }
}
