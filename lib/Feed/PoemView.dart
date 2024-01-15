import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:poetry_app/Data/Models/PoemModel.dart';
import 'package:poetry_app/Data/Models/PublishedPoemModel.dart';
import 'package:intl/intl.dart';
import '../Auth/Services/AuthService.dart';
import '../Data/Services/DataService.dart';

class PoemView extends StatelessWidget {
  final PoemModel poem;
  late final bool isPublished;
  PoemView({super.key, required this.poem}) {
    isPublished = poem is PublishedPoemModel;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          _getTitleWidget(),
          _getAuthorWidget(),
          _getImageWidget(),
          _getContentWidget(),
          _getPublishButton(),
        ],
      ),
    );
  }

  Widget _getTitleWidget() {
    return Padding(
      padding: const EdgeInsets.only(top: 24.0),
      child: Center(
        child: Text(
          poem.title,
          textScaleFactor: 1.65,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _getAuthorWidget() {
    return isPublished
        ? Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("by"),
                    const SizedBox(width: 5.0),
                    Text(
                      (poem as PublishedPoemModel).user.userName,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                      textScaleFactor: 1.2,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("at"),
                    const SizedBox(width: 5.0),
                    Text(
                      DateFormat('dd/MM/yyyy hh:mm').format(
                          (poem as PublishedPoemModel).publishedDate.toDate()),
                    ),
                  ],
                )
              ],
            ),
          )
        : Container();
  }

  Widget _getContentWidget() {
    return Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: Center(
          child: Text(
            poem.content,
          ),
        ));
  }

  Widget _getImageWidget() {
    return poem.photoURL != null
        ? Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              child: Image.network(poem.photoURL as String),
            ),
          )
        : Container();
  }

  Widget _getPublishButton() {
    return isPublished
        ? Container()
        : ElevatedButton(
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
            ),
            onPressed: () async {
              var user = GetIt.instance.get<AuthService>().getCurrentUserData();
              if (user != null) {
                GetIt.instance.get<DataService>().publishPoem(poem, user);
              }
            },
            child: const Text("Publish"));
  }
}
