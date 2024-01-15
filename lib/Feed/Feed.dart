import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'package:poetry_app/Data/Services/DataService.dart';
import 'package:poetry_app/Feed/PoemList.dart';

class Feed extends StatelessWidget {
  const Feed({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage('assets/images/home_background.png'),
        ),
      ),
      child: PoemList(
        poemsStream: GetIt.instance<DataService>().getPublishedPoems(),
        published: true,
      ),
    );
  }
}
