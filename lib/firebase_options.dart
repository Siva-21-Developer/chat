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
    apiKey: 'api key',
    appId: '1:46497110885:web:9abff28dc6c9d499f8c',
    messagingSenderId: '46497110885',
    projectId: 'chart-app-22b2f',
    authDomain: 'chart-app-22b2f.firebaseapp.com',
    storageBucket: 'charapp-87b2f.appspot.com',
    measurementId: 'G-HS09ZVE3Q',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'api key',
    appId: '1:46497110885:android:470e508804f02499f8c',
    messagingSenderId: '499497110885',
    projectId: 'chart-app-b2f',
    storageBucket: 'chart-app-87b2f.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'api key',
    appId: '1:46497110885:ios:6c3e336c6c361499f8c',
    messagingSenderId: '647110885',
    projectId: 'chart-app-872f',
    storageBucket: 'chart-app87b2f.appspot.com',
    iosBundleId: 'com.example.chat',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'api key',
    appId: '1:46497110885:ios:317df2fbf408499f8c',
    messagingSenderId: '497110885',
    projectId: 'chart-app-872f',
    storageBucket: 'chart-app-87b2f.appspot.com',
    iosBundleId: 'com.example.chat.RunnerTests',
  );
}
