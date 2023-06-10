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
    apiKey: 'AIzaSyDY0o5wt22pwUjoc2l-E73OErfGfchWzE0',
    appId: '1:565691892767:web:f3b52001ce53cd460dc12a',
    messagingSenderId: '565691892767',
    projectId: 'ez-text-1a32c',
    authDomain: 'ez-text-1a32c.firebaseapp.com',
    storageBucket: 'ez-text-1a32c.appspot.com',
    measurementId: 'G-V7H7K1N20D',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBXeCeL_ZPDbb-KFBTzcwlAzgNDVGuIqb8',
    appId: '1:565691892767:android:c648ec25588862200dc12a',
    messagingSenderId: '565691892767',
    projectId: 'ez-text-1a32c',
    storageBucket: 'ez-text-1a32c.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCUnf4Xy87Cy5QMhV_XFIJ6iuHt3UmM3Zs',
    appId: '1:565691892767:ios:693f3e90a8d6413f0dc12a',
    messagingSenderId: '565691892767',
    projectId: 'ez-text-1a32c',
    storageBucket: 'ez-text-1a32c.appspot.com',
    iosClientId: '565691892767-ngtrbbs2d455ids0hmletsl7pn1d5rbb.apps.googleusercontent.com',
    iosBundleId: 'com.example.ezText',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCUnf4Xy87Cy5QMhV_XFIJ6iuHt3UmM3Zs',
    appId: '1:565691892767:ios:693f3e90a8d6413f0dc12a',
    messagingSenderId: '565691892767',
    projectId: 'ez-text-1a32c',
    storageBucket: 'ez-text-1a32c.appspot.com',
    iosClientId: '565691892767-ngtrbbs2d455ids0hmletsl7pn1d5rbb.apps.googleusercontent.com',
    iosBundleId: 'com.example.ezText',
  );
}
