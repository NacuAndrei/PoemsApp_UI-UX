import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  List<String> poems = ["Floare albastra", "Glossa"];
  List<String> poemsPreview = [
    "-Iar te-ai cufundat in stele\nSi in nori si-n ceruri nalte?",
    "-Ce te legeni, codrule,\nFara ploaie, fara vant,"
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(
              child: Column(
                children: [
                  Container(
                    width: 100.0,
                    height: 100.0,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage(
                            "https://upload.wikimedia.org/wikipedia/commons/thumb/d/dc/Eminescu.jpg/330px-Eminescu.jpg"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24.0),
                  Text(
                    "Mihai Eminescu",
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    "-Poet-",
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32.0),
            Text(
              "About me",
              style: Theme.of(context).textTheme.headline6,
            ),
            const SizedBox(height: 8.0),
            Text(
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. ",
              style: Theme.of(context).textTheme.bodyText2,
            ),
            const SizedBox(height: 32.0),
            Text(
              "Poems",
              style: Theme.of(context).textTheme.headline6,
            ),
            Expanded(
                child: ListView.builder(
                    itemCount: poems.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        children: [
                          ListTile(
                            title: Text(poems[index],
                                style: Theme.of(context).textTheme.subtitle2),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("${poemsPreview[index]}\n..."),
                          ),
                          const Divider(),
                        ],
                      );
                    }))
          ],
        ),
      ),
    );
  }
}
