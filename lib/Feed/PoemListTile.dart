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
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
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
    );
  }

  Widget _getListTileTitle() {
    final String poemTitle = poem.title;

    String? poemAuthor;
    if (showAuthor && poem is PublishedPoemModel) {
      poemAuthor = (poem as PublishedPoemModel).user.userName;
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Text(
            poemTitle,
            textScaleFactor: 1.2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          showAuthor && poemAuthor != null
              ? Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          DateFormat('dd/MM/yyyy').format(
                              (poem as PublishedPoemModel)
                                  .publishedDate
                                  .toDate()),
                          textScaleFactor: 0.75,
                          style: TextStyle(color: Colors.black45),
                        ),
                      ],
                    ),
                    Center(
                      child: Text(
                        "- $poemAuthor -",
                        style: const TextStyle(
                            fontStyle: FontStyle.italic, color: Colors.black54),
                      ),
                    ),
                  ],
                )
              : Container(),
        ],
      ),
    );
  }

  Widget _getListTileSubtitle() {
    return Text(
      poem.content,
      maxLines: 4,
      overflow: TextOverflow.fade,
      style: TextStyle(color: Colors.black87),
    );
  }
}
