import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:poetry_app/Data/Models/PublishedPoemModel.dart';
import 'package:poetry_app/Data/Services/DataService.dart';
import 'package:poetry_app/Feed/PoemList.dart';
import 'package:poetry_app/Feed/PoemListTile.dart';

class Feed extends StatelessWidget {
  const Feed({super.key});

  @override
  Widget build(BuildContext context) {
    return PoemList(
      poemsStream: GetIt.instance<DataService>().getPublishedPoems(),
      published: true,
    );
  }
}
