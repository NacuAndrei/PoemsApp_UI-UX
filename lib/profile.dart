
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        backgroundColor: Colors.black,
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(
              child: Column(
                children: [
                  Container(
                    width: 150.0,
                    height: 150.0,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage(
                            "https://play-lh.googleusercontent.com/8ddL1kuoNUB5vUvgDVjYY3_6HwQcrg1K2fd_R8soD-e2QYj8fT9cfhfh3G0hnSruLKec"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    "Sussy Writer",
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    "writer.sussy@example.com",
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
            const SizedBox(height: 8.0),
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: const [
                Chip(
                  label: Text("Floare albastra"),
                ),
                Chip(
                  label: Text("Ce te legeni?..."),
                ),
                Chip(
                  label: Text("Glossa"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}