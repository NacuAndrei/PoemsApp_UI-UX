import 'package:cloud_firestore/cloud_firestore.dart';

class PoemModel {
  PoemModel({
    this.id,
    required this.title,
    required this.content,
    this.photoURL,
    this.isPublished = false,
    this.likesCount = 0,
  });

  final String? id;
  final String title;
  final String content;
  String? photoURL;
  bool isPublished;
  int likesCount;

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'content': content,
      'photoURL': photoURL,
      'isPublished': isPublished,
      'likesCount': likesCount,
    };
  }

  PoemModel.fromDocumentSnapshot(
      QueryDocumentSnapshot<Map<String, dynamic>> doc)
      : id = doc.id,
        title = doc.data()["title"],
        content = doc.data()["content"] ?? "",
        photoURL = doc.data()["photoURL"],
        isPublished = doc.data()["isPublished"] ?? false,
        likesCount = doc.data()["likesCount"] ?? 0;

  PoemModel.fromMap(Map<String, dynamic> map)
      : id = map["id"],
        title = map["title"],
        content = map["content"] ?? "",
        photoURL = map["photoURL"],
        isPublished = map["isPublished"] ?? false,
        likesCount = map["likesCount"] ?? 0;
}
