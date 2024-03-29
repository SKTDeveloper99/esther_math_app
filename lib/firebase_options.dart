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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyBJXCjQuJ3kWL1GJxckxs9PUIJFubmhfyU',
    appId: '1:257978860729:web:54b2d426690dc3a5a38768',
    messagingSenderId: '257978860729',
    projectId: 'khoatrancodingminds',
    authDomain: 'khoatrancodingminds.firebaseapp.com',
    databaseURL: 'https://khoatrancodingminds-default-rtdb.firebaseio.com',
    storageBucket: 'khoatrancodingminds.appspot.com',
    measurementId: 'G-0X96B9Z7JQ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA4JirS3CzjGEx3rWOTXic5RFkO3Hqiv_U',
    appId: '1:257978860729:android:51e6281606d7e9aca38768',
    messagingSenderId: '257978860729',
    projectId: 'khoatrancodingminds',
    databaseURL: 'https://khoatrancodingminds-default-rtdb.firebaseio.com',
    storageBucket: 'khoatrancodingminds.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCGV-HQEgyBZxRilD-3IftsEUbQ72CWMt0',
    appId: '1:257978860729:ios:460febc2a52ae2baa38768',
    messagingSenderId: '257978860729',
    projectId: 'khoatrancodingminds',
    databaseURL: 'https://khoatrancodingminds-default-rtdb.firebaseio.com',
    storageBucket: 'khoatrancodingminds.appspot.com',
    androidClientId: '257978860729-h9i3ishb31gtmkh5fp8ckhdjss354435.apps.googleusercontent.com',
    iosClientId: '257978860729-tg727ku4n0r6obd1b0u93ofj22ml2120.apps.googleusercontent.com',
    iosBundleId: 'com.esthersoftware.estherMathApp',
  );
}
