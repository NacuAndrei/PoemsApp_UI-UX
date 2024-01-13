import 'package:flutter/material.dart';
import 'package:poetry_app/Data/Models/PoemModel.dart';
import 'package:poetry_app/Feed/Poem.dart';

class PoemList extends StatelessWidget {
  final List<PoemModel> poems;
  final bool showAuthor;
  const PoemList({super.key, required this.poems, this.showAuthor = true});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        separatorBuilder: (context, index) => const Divider(),
        itemCount: poems.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: _getListTileTitle(index),
            subtitle: _getListTileSubtitle(index),
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (context) {
                return Scaffold(
                  appBar: AppBar(),
                  body: SingleChildScrollView(
                    child: Poem(poem: poems[index]),
                  ),
                );
              }),
            ),
          );
        });
  }

  Widget _getListTileTitle(int index) {
    final poemTitle = poems[index].title;
    final poemAuthor = "Mihai Eminescu";
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Text(poemTitle,
              textScaleFactor: 1.2, overflow: TextOverflow.ellipsis),
          showAuthor
              ? Center(
                  child: Text(
                    "- $poemAuthor -",
                    style: const TextStyle(fontStyle: FontStyle.italic),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }

  Widget _getListTileSubtitle(int index) {
    return Text(
      poems[index].content,
      maxLines: 4,
      overflow: TextOverflow.fade,
    );
  }
}
