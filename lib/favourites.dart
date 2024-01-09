import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:poetry_app/Compose/compose.dart';
import 'package:poetry_app/profile.dart';
import 'package:poetry_app/home.dart';

class PoemList extends StatefulWidget {
  const PoemList({super.key});
  @override
  State<PoemList> createState() => _PoemListState();
}

class _PoemListState extends State<PoemList> {
  List<String> _poems = [
    '''
    Roses are red,
    Violets are blue,
    Sugar is sweet,
    And so are you.
    ''',
    '''
    The world is full of magic things,
    Patiently waiting for our senses to grow sharper.
    ''',
    '''
    The road to success is long and winding,
    But with hard work and determination,
    You will surely reach your destination.
    ''',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Favourites'),
      ),
      body: ListView.builder(
        itemCount: _poems.length,
        itemBuilder: (context, index) {
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(_poems[index]),
                  const SizedBox(height: 8),
                  // RaisedButton(
                  //   onPressed: () {
                  //     Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //         builder: (context) => PoemView(poem: _poems[index]),
                  //       ),
                  //     );
                  //   },
                  //   child: Text('View Full Poem'),
                  // ),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: Container(
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: GNav(
              color: Colors.white,
              backgroundColor: Colors.black,
              tabBackgroundColor: Colors.grey.shade800,
              activeColor: Colors.white,
              padding: const EdgeInsets.all(16),
              tabs: [
                GButton(
                  gap: 10,
                  icon: Icons.home_outlined,
                  text: "Home",
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomePage()));
                  },
                ),
                GButton(
                  gap: 10,
                  icon: Icons.favorite_border,
                  text: "Favourites",
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const PoemList()));
                  },
                ),
                GButton(
                  gap: 10,
                  icon: Icons.edit_outlined,
                  text: "Compose",
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Compose()));
                  },
                ),
                GButton(
                  gap: 10,
                  icon: Icons.account_circle,
                  text: "Profile",
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ProfilePage()));
                  },
                ),
              ]),
        ),
      ),
    );
  }
}

class PoemView extends StatelessWidget {
  final String poem;

  const PoemView({super.key, required this.poem});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Poem View'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(poem),
          ],
        ),
      ),
    );
  }
}
