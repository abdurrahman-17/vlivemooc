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
    apiKey: 'AIzaSyB_Ph1FBymn1uAjucmf_rI9_GPNXegcxcw',
    appId: '1:503797194398:web:9b1ca164c4f710d984a58f',
    messagingSenderId: '503797194398',
    projectId: 'enrichtv-b0346',
    authDomain: 'enrichtv-b0346.firebaseapp.com',
    databaseURL: 'https://enrichtv-b0346-default-rtdb.firebaseio.com',
    storageBucket: 'enrichtv-b0346.appspot.com',
    measurementId: 'G-C1JPHJWE7V',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDQX0yesP_wcN96lHGUs1cE13CJZeU6OXQ',
    appId: '1:503797194398:android:39984216ede3fc9884a58f',
    messagingSenderId: '503797194398',
    projectId: 'enrichtv-b0346',
    databaseURL: 'https://enrichtv-b0346-default-rtdb.firebaseio.com',
    storageBucket: 'enrichtv-b0346.appspot.com',
      androidClientId:'503797194398-0jtka2qke33f1kaqhmrfv27pgiblbnqt.apps.googleusercontent.com'
  );


  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAezcZUaesFp7bh3vAJYknzUWv4NyHmOQM',
    appId: '1:503797194398:ios:f1899d421c7055e684a58f',
    messagingSenderId: '503797194398',
    projectId: 'enrichtv-b0346',
    databaseURL: 'https://enrichtv-b0346-default-rtdb.firebaseio.com',
    storageBucket: 'enrichtv-b0346.appspot.com',
    androidClientId: '503797194398-0jtka2qke33f1kaqhmrfv27pgiblbnqt.apps.googleusercontent.com',
    iosClientId: '503797194398-av4oicl3tsvdf8k2v0tb20714l6k5g8c.apps.googleusercontent.com',
    iosBundleId: 'com.mobiotics.vlivemooc',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAezcZUaesFp7bh3vAJYknzUWv4NyHmOQM',
    appId: '1:503797194398:ios:e6b20698f97d3f2684a58f',
    messagingSenderId: '503797194398',
    projectId: 'enrichtv-b0346',
    databaseURL: 'https://enrichtv-b0346-default-rtdb.firebaseio.com',
    storageBucket: 'enrichtv-b0346.appspot.com',
    androidClientId: '503797194398-0jtka2qke33f1kaqhmrfv27pgiblbnqt.apps.googleusercontent.com',
    iosClientId: '503797194398-clq3aend8koevm7vomnbs27cvm9mb03r.apps.googleusercontent.com',
    iosBundleId: 'com.mobiotics.vlivemooc.RunnerTests',
  );
}
