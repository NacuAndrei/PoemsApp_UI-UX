import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:poetry_app/Auth/Login.dart';
import 'package:poetry_app/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          centerTitle: true,
        ),
      ),
      home: startScreen(),
    );
  }

  Widget startScreen() {
    var isAuthentificated = false;

    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        isAuthentificated = false;
      } else {
        isAuthentificated = true;
      }
    });

    if (!isAuthentificated) {
      return Login();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Poetry"),
      ),
      body: const Center(child: Text("Poetry app")),
    );
  }
}
