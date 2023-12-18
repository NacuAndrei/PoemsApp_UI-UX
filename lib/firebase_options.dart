// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBwQIwatTEhuMkwwywnr-GUYzBR1m6MU0s',
    appId: '1:348915233852:web:d0de8cccc010a56e2d3f39',
    messagingSenderId: '348915233852',
    projectId: 'poetry-9df46',
    authDomain: 'poetry-9df46.firebaseapp.com',
    storageBucket: 'poetry-9df46.appspot.com',
    measurementId: 'G-4Z6C5LSY3H',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD9PsQgm215kznMFuEuEauNv9HvKi91-WI',
    appId: '1:348915233852:android:23785483b9288b252d3f39',
    messagingSenderId: '348915233852',
    projectId: 'poetry-9df46',
    storageBucket: 'poetry-9df46.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyByt3K_3Os1aIr3MOziZLHqbC8J7cDLwXE',
    appId: '1:348915233852:ios:9d1bfb10f2bbc7062d3f39',
    messagingSenderId: '348915233852',
    projectId: 'poetry-9df46',
    storageBucket: 'poetry-9df46.appspot.com',
    androidClientId: '348915233852-1knmgbn8evvqte4o1cauq6918rmmo71j.apps.googleusercontent.com',
    iosClientId: '348915233852-hhr0i8qsupgc7tr4229711h50uofbe0l.apps.googleusercontent.com',
    iosBundleId: 'com.example.poetryApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyByt3K_3Os1aIr3MOziZLHqbC8J7cDLwXE',
    appId: '1:348915233852:ios:9d1bfb10f2bbc7062d3f39',
    messagingSenderId: '348915233852',
    projectId: 'poetry-9df46',
    storageBucket: 'poetry-9df46.appspot.com',
    androidClientId: '348915233852-1knmgbn8evvqte4o1cauq6918rmmo71j.apps.googleusercontent.com',
    iosClientId: '348915233852-hhr0i8qsupgc7tr4229711h50uofbe0l.apps.googleusercontent.com',
    iosBundleId: 'com.example.poetryApp',
  );
}