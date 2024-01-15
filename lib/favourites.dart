import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:poetry_app/Auth/Services/AuthService.dart';
import 'package:poetry_app/Feed/PoemList.dart';

import 'Data/Services/DataService.dart';

class Favourites extends StatelessWidget {
  const Favourites({super.key});

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
        poemsStream: GetIt.instance<DataService>().getFavouritedPoems(
            GetIt.instance<AuthService>().getUserId() as String),
        published: true,
      ),
    );
  }
}
