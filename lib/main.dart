import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:poetry_app/Auth/Login.dart';
import 'package:poetry_app/Auth/Services/AuthService.dart';
import 'package:poetry_app/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Register services
  GetIt.instance.registerSingleton<AuthService>(AuthService());

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
      home: _getLandingPage(),
    );
  }

  // Listen to the auth state and display the appropriate screen
  Widget _getLandingPage() {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Poetry"),
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Center(child: Text("Poetry app")),
                OutlinedButton(
                    onPressed: () {
                      GetIt.instance<AuthService>().logOut();
                    },
                    child: const Text("Sign out"))
              ],
            ),
          );
        } else {
          return const Login();
        }
      },
    );
  }
}
