import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:poetry_app/Auth/Login.dart';
import 'package:poetry_app/Auth/Services/AuthService.dart';
import 'package:poetry_app/Auth/Signup.dart';
import 'package:poetry_app/Data/Services/DataService.dart';
import 'package:poetry_app/firebase_options.dart';
import 'package:poetry_app/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Register services
  GetIt.instance.registerSingleton<AuthService>(AuthService());
  GetIt.instance.registerSingleton<DataService>(DataService());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData.light().copyWith(
        appBarTheme: const AppBarTheme(centerTitle: true),
        colorScheme: const ColorScheme.light().copyWith(primary: Colors.black),
      ),
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.userChanges(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            Navigator.of(context).popUntil((route) => route.isFirst);
            return const HomePage();
          } else {
            return _guestHomePage(context);
          }
        },
      ),
    );
  }

  Widget _guestHomePage(context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: double.infinity,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
              child: OutlinedButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const Signup()));
                },
                child: const Padding(
                  padding: EdgeInsets.all(18.0),
                  child: Text("Sign up"),
                ),
              ),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
              child: OutlinedButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const Login()));
                },
                child: const Padding(
                  padding: EdgeInsets.all(18.0),
                  child: Text("Login"),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
