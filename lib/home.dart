import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:poetry_app/Compose/compose.dart';
import 'package:poetry_app/profile.dart';

import 'favourites.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  final screens = [
    const Center(child: Text('Home')),
    const Center(child: PoemList()),
    const Center(child: Compose()),
    const Center(child: ProfilePage()),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[_selectedIndex],
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
                  // onPressed: () {
                  //   Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //           builder: (context) => const HomePage()));
                  // },
                ),
                GButton(
                  gap: 10,
                  icon: Icons.favorite_border,
                  text: "Favourites",
                  // onPressed: () {
                  // Navigator.push(
                  // context,
                  // MaterialPageRoute(
                  // builder: (context) => const PoemList()));
                  // },
                ),
                GButton(
                  gap: 10,
                  icon: Icons.edit_outlined,
                  text: "Compose",
                  // onPressed: () {
                  //   Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //           builder: (context) => const Compose()));
                  // },
                ),
                GButton(
                  gap: 10,
                  icon: Icons.account_circle,
                  text: "Profile",
                  // onPressed: () {
                  //   Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //           builder: (context) => const ProfilePage()));
                  // },
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
