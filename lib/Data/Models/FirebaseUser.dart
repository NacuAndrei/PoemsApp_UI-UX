class FirebaseUser {
  final String userId;
  final String userEmail;
  final String userName;
  final String userPhotoURL;

  FirebaseUser(
      {required this.userId,
      required this.userEmail,
      required this.userName,
      required this.userPhotoURL});

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'userEmail': userEmail,
      'userName': userName,
      'userPhotoURL': userPhotoURL,
    };
  }

  FirebaseUser.fromMap(Map<String, dynamic> map)
      : userId = map['userId'],
        userEmail = map['userEmail'],
        userName = map['userName'],
        userPhotoURL = map['userPhotoURL'];
}
