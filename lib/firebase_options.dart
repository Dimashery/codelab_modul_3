// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        return windows;
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
    apiKey: 'AIzaSyDessxRGhT1ahPUkPThvtDbmyqR-ZMuW_Y',
    appId: '1:914156139269:web:4246fa16de6da6696b7d6c',
    messagingSenderId: '914156139269',
    projectId: 'modul-3-project',
    authDomain: 'modul-3-project.firebaseapp.com',
    storageBucket: 'modul-3-project.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAHsdLPXoHPzOxwUWEdkmMaBoQ3zIfOnvI',
    appId: '1:914156139269:android:00bb66a93e976e656b7d6c',
    messagingSenderId: '914156139269',
    projectId: 'modul-3-project',
    storageBucket: 'modul-3-project.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAtfc4SFqzKud6Sf0FXKHF2aithCrZD95k',
    appId: '1:914156139269:ios:f44afc463bcda68d6b7d6c',
    messagingSenderId: '914156139269',
    projectId: 'modul-3-project',
    storageBucket: 'modul-3-project.appspot.com',
    iosBundleId: 'com.example.codelab3',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAtfc4SFqzKud6Sf0FXKHF2aithCrZD95k',
    appId: '1:914156139269:ios:f44afc463bcda68d6b7d6c',
    messagingSenderId: '914156139269',
    projectId: 'modul-3-project',
    storageBucket: 'modul-3-project.appspot.com',
    iosBundleId: 'com.example.codelab3',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDessxRGhT1ahPUkPThvtDbmyqR-ZMuW_Y',
    appId: '1:914156139269:web:6d5f9d51ff0d8d6b6b7d6c',
    messagingSenderId: '914156139269',
    projectId: 'modul-3-project',
    authDomain: 'modul-3-project.firebaseapp.com',
    storageBucket: 'modul-3-project.appspot.com',
  );
}
