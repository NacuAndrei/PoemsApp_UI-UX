import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:poetry_app/Data/Models/FirebaseUser.dart';
import 'package:poetry_app/Data/Models/PoemModel.dart';

class PublishedPoemModel extends PoemModel {
  final Timestamp publishedDate;
  final FirebaseUser user;

  PublishedPoemModel(String? id, String title, String content, String? photoURL,
      this.publishedDate, this.user)
      : super(id: id, title: title, content: content, photoURL: photoURL);

  @override
  Map<String, dynamic> toMap() {
    var map = super.toMap();
    map.addAll({
      'publishedDate': publishedDate,
      'user': user.toMap(),
    });
    return map;
  }

  PublishedPoemModel.fromDocumentSnapshot(
      QueryDocumentSnapshot<Map<String, dynamic>> doc)
      : publishedDate = doc.data()["publishedDate"],
        user = FirebaseUser.fromMap(doc.data()["user"]),
        super.fromDocumentSnapshot(doc);
}
