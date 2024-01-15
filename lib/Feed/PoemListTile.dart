import 'package:flutter/material.dart';
import 'package:poetry_app/Data/Models/PoemModel.dart';
import 'package:poetry_app/Data/Models/PublishedPoemModel.dart';
import 'package:poetry_app/Feed/PoemView.dart';
import 'package:intl/intl.dart';

class PoemListTile extends StatelessWidget {
  final PoemModel poem;
  final bool showAuthor;
  final BuildContext context;

  const PoemListTile({
    super.key,
    required this.context,
    required this.poem,
    this.showAuthor = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        clipBehavior: Clip.antiAlias,
        child: ListTile(
          contentPadding: const EdgeInsets.all(0),
          minVerticalPadding: 0,
          title: _getListTileTitle(),
          subtitle: _getListTileSubtitle(),
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => Scaffold(
                appBar: AppBar(),
                body: SingleChildScrollView(
                  child: PoemView(poem: poem),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _getListTileTitle() {
    final String poemTitle = poem.title;

    String? poemAuthor;
    if (showAuthor && poem is PublishedPoemModel) {
      poemAuthor = (poem as PublishedPoemModel).user.userName;
    }

    Widget getPoemTitle() {
      return Row(
        children: [
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(colors: [
                Color.fromRGBO(9, 79, 23, 0.94),
                Color.fromRGBO(47, 163, 160, 1),
              ])),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  poemTitle,
                  textAlign: TextAlign.center,
                  textScaleFactor: 1.2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    }

    Widget getDate() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            DateFormat('dd/MM/yyyy')
                .format((poem as PublishedPoemModel).publishedDate.toDate()),
            textScaleFactor: 0.75,
            style: const TextStyle(color: Colors.black45),
          ),
        ],
      );
    }

    Widget getAuthor() {
      return Center(
        child: Text(
          "- $poemAuthor -",
          style: const TextStyle(
              fontStyle: FontStyle.italic, color: Colors.black54),
        ),
      );
    }

    return Column(
      children: [
        getPoemTitle(),
        showAuthor && poemAuthor != null
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    getDate(),
                    getAuthor(),
                  ],
                ),
              )
            : Container(),
      ],
    );
  }

  Widget _getListTileSubtitle() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        poem.content,
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.center,
        style: const TextStyle(color: Colors.black87),
      ),
    );
  }
}
