import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:poetry_app/Compose/compose.dart';
import 'package:poetry_app/profile.dart';
import 'favourites.dart';
import 'Auth/Services/AuthService.dart';
import 'package:poetry_app/Feed/Feed.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  final screens = [
    const Center(child: Feed()),
    const Center(child: PoemList()),
    const Center(child: Compose()),
    const Center(child: ProfilePage()),
  ];
  final appBarTexts = [
    const Text('Home'),
    const Text('Favourites'),
    const Text('Compose'),
    const Text('Profile'),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[_selectedIndex],
      appBar: AppBar(
        title: appBarTexts[_selectedIndex],
        backgroundColor: Colors.black,
        shadowColor: Colors.transparent,
        actions: [
          TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
              ),
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
              tabs: const [
                GButton(gap: 10, icon: Icons.home_outlined, text: "Home"),
                GButton(
                    gap: 10, icon: Icons.favorite_border, text: "Favorites"),
                GButton(
                  gap: 10,
                  icon: Icons.edit_outlined,
                  text: "Compose",
                ),
                GButton(
                  gap: 10,
                  icon: Icons.account_circle,
                  text: "Profile",
                ),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              }),
        ),
      ),
    );
  }
}
