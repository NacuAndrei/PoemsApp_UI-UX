import 'package:cloud_firestore/cloud_firestore.dart';

class PoemModel {
  PoemModel(
      {this.id, required this.title, required this.content, this.photoURL});

  final String? id;
  final String title;
  final String content;
  String? photoURL;

  Map<String, dynamic> toMap() {
    return {'title': title, 'content': content};
  }

  PoemModel.fromDocumentSnapshot(
      QueryDocumentSnapshot<Map<String, dynamic>> doc)
      : id = doc.id,
        title = doc.data()["title"],
        content = doc.data()["content"] ?? "",
        photoURL = doc.data()["photoURL"];
}
