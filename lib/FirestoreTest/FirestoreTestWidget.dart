import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:poetry_app/Auth/Services/AuthService.dart';
import 'package:poetry_app/Data/Models/PoemModel.dart';
import 'package:poetry_app/Data/Services/DataService.dart';

class FirestoreTestWidget extends StatefulWidget {
  const FirestoreTestWidget({Key? key}) : super(key: key);

  @override
  State<FirestoreTestWidget> createState() => _FirestoreTestWidgetState();
}

class _FirestoreTestWidgetState extends State<FirestoreTestWidget> {
  AuthService auth = GetIt.instance<AuthService>();
  DataService db = GetIt.instance<DataService>();

  @override
  Widget build(BuildContext context) {
    List<PoemModel> poems = [];
    db.getPoemDrafts(auth.getUserId() ?? "", poems);

    return OutlinedButton.icon(
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
      ),
      onPressed: () {
        var userId = auth.getUserId();
        if (userId != null) {}
      },
      label: const Text("Add poem"),
      icon: const Icon(FontAwesomeIcons.plus),
    );
  }
}
