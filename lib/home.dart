import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                GButton(gap: 10, icon: Icons.edit_outlined, text: "Compose"),
                GButton(gap: 10, icon: Icons.account_circle, text: "Profile"),
              ]),
        ),
      ),
    );
  }
}
