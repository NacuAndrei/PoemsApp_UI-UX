import 'package:flutter/material.dart';

// void main() {
//   runApp(const ProfilePage());
// }

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const ClipOval(
                  child: Image(
                    image: NetworkImage(
                        "https://upload.wikimedia.org/wikipedia/commons/thumb/d/dc/Eminescu.jpg/330px-Eminescu.jpg"),
                    width: 100,
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(height: 24.0),
                Text(
                  "Unknown",
                  style: Theme.of(context).textTheme.headline5,
                ),
                const SizedBox(height: 8.0),
                Text(
                  "-Poet-",
                  style: Theme.of(context).textTheme.subtitle2,
                ),
                const SizedBox(height: 32.0),
                Text(
                  "Poems",
                  style: Theme.of(context).textTheme.headline6,
                ),
                const SizedBox(height: 8.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
