import 'package:cloud_firestore/cloud_firestore.dart';

class PoemModel {
  PoemModel(
      {this.id,
      required this.title,
      required this.content,
      this.photoURL,
      this.isPublished = false});

  final String? id;
  final String title;
  final String content;
  String? photoURL;
  bool isPublished;

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'content': content,
      'photoURL': photoURL,
      'isPublished': isPublished
    };
  }

  PoemModel.fromDocumentSnapshot(
      QueryDocumentSnapshot<Map<String, dynamic>> doc)
      : id = doc.id,
        title = doc.data()["title"],
        content = doc.data()["content"] ?? "",
        photoURL = doc.data()["photoURL"],
        isPublished = doc.data()["isPublished"] ?? false;

  PoemModel.fromMap(Map<String, dynamic> map)
      : id = map["id"],
        title = map["title"],
        content = map["content"] ?? "",
        photoURL = map["photoURL"],
        isPublished = map["isPublished"] ?? false;
}
