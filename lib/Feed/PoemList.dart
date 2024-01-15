import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get_it/get_it.dart';
import 'package:poetry_app/Data/Models/PoemModel.dart';

import '../Data/Models/PublishedPoemModel.dart';
import '../Data/Services/DataService.dart';
import 'PoemListTile.dart';

class PoemList extends StatefulWidget {
  const PoemList(
      {super.key, required this.poemsStream, required this.published});
  final Stream<QuerySnapshot<Map<String, dynamic>>> poemsStream;
  final bool published;
  @override
  State<PoemList> createState() => _PoemListState();
}

class _PoemListState extends State<PoemList> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: widget.poemsStream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(child: Text("Error"));
        }
        if (snapshot.hasData) {
          return ListView.separated(
            separatorBuilder: (context, index) => const Divider(
              color: Colors.black12,
              thickness: 1.2,
            ),
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              final QueryDocumentSnapshot<Map<String, dynamic>> poemSnapshot =
                  snapshot.data!.docs[index];
              PoemModel poemModel = widget.published
                  ? PublishedPoemModel.fromDocumentSnapshot(poemSnapshot)
                  : PoemModel.fromDocumentSnapshot(poemSnapshot);

              return PoemListTile(
                poem: poemModel,
                context: context,
                showAuthor: widget.published,
              );
            },
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
