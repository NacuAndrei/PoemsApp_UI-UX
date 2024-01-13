import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:poetry_app/Auth/Services/AuthService.dart';
import 'package:poetry_app/Data/Models/PoemModel.dart';
import 'package:poetry_app/Data/Services/DataService.dart';
import 'package:poetry_app/Feed/PoemList.dart';

class Feed extends StatefulWidget {
  const Feed({super.key});

  @override
  State<Feed> createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  List<PoemModel> _poems = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _getPoems(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              return PoemList(poems: _poems);
            }
            if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            }
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Future<bool> _getPoems() async {
    _poems = [
      PoemModel(title: "Amorul unei marmure", content: '''
Oştirile-i alungă în spaimă îngheţată,
Cu sufletu-n ruină, un rege-asirian,
Cum stâncelor aruncă durerea-i înspumată
Gemândul uragan.

De ce nu sunt un rege să sfarm cu-a mea durere,
De ce nu sunt Satana, de ce nu-s Dumnezeu,
Să fac să rump-o lume ce sfâşie-n tăcere
Zdrobit sufletul meu.

Un leu pustiei rage turbarea lui fugindă,
Un ocean se-mbată pe-al vânturilor joc,
Şi norii-şi spun în tunet durerea lor mugindă,
Gândirile de foc.

Eu singur n-am cui spune cumplita mea durere,
Eu singur n-am cui spune nebunul meu amor,
Căci mie mi-a dat soarta amara mângâiere
O piatră să ador.
''')
    ];
    for (int i = 0; i < 20; ++i) {
      _poems.add(_poems[0]);
    }
    return true;

    // final user = GetIt.instance<AuthService>().getUserId();
    // if (user == null) {
    //   throw Exception("User is invalid/null");
    // }
    // await GetIt.instance<DataService>().getPoemDrafts(user, _poems);
  }
}
