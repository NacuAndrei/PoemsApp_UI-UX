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
  final List<String> _poems = [    '''
    Roses are red,
    Violets are blue,
    Sugar is sweet,
    And so are you.
    ''',    '''
    The world is full of magic things,
    Patiently waiting for our senses to grow sharper.
    ''',    '''
    The road to success is long and winding,
    But with hard work and determination,
    You will surely reach your destination.
    ''',  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.builder(
        itemCount: _poems.length,
        itemBuilder: (context, index) {
          return  Card(
            child:
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black
                      ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PoemView(poem: _poems[index]),
                        ),
                      );
                    },
                    child: Column(
                        children: [
                        Text(_poems[index]),
                    const SizedBox(height: 8),
                  ]),
              ),
          );
        }, gridDelegate:  const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 5.0,
        mainAxisSpacing: 5.0,
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