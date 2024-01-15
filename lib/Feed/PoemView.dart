import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:poetry_app/Data/Models/PoemModel.dart';
import 'package:poetry_app/Data/Models/PublishedPoemModel.dart';
import 'package:intl/intl.dart';
import '../Auth/Services/AuthService.dart';
import '../Data/Services/DataService.dart';

class PoemView extends StatefulWidget {
  final PoemModel poem;
  late final bool isDraft;
  PoemView({super.key, required this.poem}) {
    isDraft = poem is! PublishedPoemModel;
  }

  @override
  State<PoemView> createState() => _PoemViewState();
}

class _PoemViewState extends State<PoemView> {
  bool showButton = false;

  @override
  void initState() {
    showButton = widget.poem.isPublished == false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [_getPublishButton()],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              _getTitleWidget(),
              _getAuthorWidget(),
              _getImageWidget(),
              _getContentWidget(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getTitleWidget() {
    return Padding(
      padding: const EdgeInsets.only(top: 24.0),
      child: Center(
        child: Text(
          widget.poem.title,
          textScaleFactor: 1.65,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _getAuthorWidget() {
    return widget.isDraft
        ? Container()
        : Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("by"),
                    const SizedBox(width: 5.0),
                    Text(
                      (widget.poem as PublishedPoemModel).user.userName,
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
                          (widget.poem as PublishedPoemModel)
                              .publishedDate
                              .toDate()),
                    ),
                  ],
                )
              ],
            ),
          );
  }

  Widget _getContentWidget() {
    return Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: Center(
          child: Text(
            widget.poem.content,
          ),
        ));
  }

  Widget _getImageWidget() {
    return widget.poem.photoURL != null
        ? Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              child: Image.network(widget.poem.photoURL as String),
            ),
          )
        : Container();
  }

  Widget _getPublishButton() {
    if (widget.isDraft && showButton) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 10.0)),
          onPressed: () => _showPublishDialog(context),
          child: const Text("Publish"),
        ),
      );
    } else {
      return Container();
    }
  }

  void _showPublishDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Are you sure you want to publish the poem?"),
          actions: [
            TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text("Cancel")),
            TextButton(
                onPressed: () async {
                  var user =
                      GetIt.instance.get<AuthService>().getCurrentUserData();
                  if (user != null) {
                    GetIt.instance
                        .get<DataService>()
                        .publishPoem(widget.poem, user);
                  }
                  setState(() {
                    showButton = false;
                  });

                  Navigator.of(context).pop();

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Poem published!'),
                    ),
                  );
                },
                child: const Text("Publish"))
          ],
        );
      },
    );
  }
}
