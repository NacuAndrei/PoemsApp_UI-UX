import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:poetry_app/Auth/Login.dart';
import 'package:poetry_app/Auth/Services/AuthService.dart';
import 'package:poetry_app/Auth/Signup.dart';
import 'package:poetry_app/firebase_options.dart';
import 'package:poetry_app/home.dart';

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
      stream: FirebaseAuth.instance.userChanges(),
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasData) {
          Navigator.of(context).popUntil((route) => route.isFirst);

          return Scaffold(
            appBar: AppBar(
              title: const Text("Poetry"),
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Column(
                    children: [
                      Text("Poetry app"),
                      Text("Hello ${snapshot.data?.displayName}"),
                    ],
                  ),
                ),
                OutlinedButton(
                    onPressed: () {
                      GetIt.instance<AuthService>().logOut();
                    },
                    child: const Text("Sign out"))
              ],
            ),
          );
        } else {
          return Scaffold(
            appBar: AppBar(title: const Text("Poetry app")),
            body: Column(
              children: [
                OutlinedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const Signup()));
                  },
                  child: const Text("Sign up"),
                ),
                OutlinedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => const Login()));
                  },
                  child: const Text("Login"),
                ),
                OutlinedButton(
                  child: const Text("main page"),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomePage()));
                  },
                ),
              ],
            ),
          );
          // return const Signup();
        }
      },
    );
  }
}
