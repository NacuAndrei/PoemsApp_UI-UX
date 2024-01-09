import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:poetry_app/Compose/compose.dart';
import 'package:poetry_app/profile.dart';

import 'Auth/Services/AuthService.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        actions: [
          TextButton(
              onPressed: () {
                GetIt.instance<AuthService>().logOut();
              },
              child: const Text("Sign out"))
        ],
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
                const GButton(gap: 10, icon: Icons.home_outlined, text: "Home"),
                const GButton(
                    gap: 10, icon: Icons.favorite_border, text: "Favorites"),
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
