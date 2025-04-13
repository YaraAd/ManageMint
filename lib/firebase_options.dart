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
    apiKey: 'AIzaSyAgHbn4Uo0xrr4K8LKs9tZPrAXvPuEl6Hw',
    appId: '1:850971368175:web:f754e94648f9e66bf1991a',
    messagingSenderId: '850971368175',
    projectId: 'mangemint-cf96d',
    authDomain: 'mangemint-cf96d.firebaseapp.com',
    storageBucket: 'mangemint-cf96d.firebasestorage.app',
    measurementId: 'G-D0BYKK4MJK',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC4OZ9vLmJe51D5Ed3vhi9r2ayW1MlECPg',
    appId: '1:850971368175:android:2c6c28adf8d1e628f1991a',
    messagingSenderId: '850971368175',
    projectId: 'mangemint-cf96d',
    storageBucket: 'mangemint-cf96d.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBrFn8O1N_MOdkYDghIc2ynEwundJtN8Qg',
    appId: '1:850971368175:ios:091f6af5f80adbabf1991a',
    messagingSenderId: '850971368175',
    projectId: 'mangemint-cf96d',
    storageBucket: 'mangemint-cf96d.firebasestorage.app',
    iosBundleId: 'com.example.managemint',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBrFn8O1N_MOdkYDghIc2ynEwundJtN8Qg',
    appId: '1:850971368175:ios:091f6af5f80adbabf1991a',
    messagingSenderId: '850971368175',
    projectId: 'mangemint-cf96d',
    storageBucket: 'mangemint-cf96d.firebasestorage.app',
    iosBundleId: 'com.example.managemint',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAgHbn4Uo0xrr4K8LKs9tZPrAXvPuEl6Hw',
    appId: '1:850971368175:web:f05bcb40b282340af1991a',
    messagingSenderId: '850971368175',
    projectId: 'mangemint-cf96d',
    authDomain: 'mangemint-cf96d.firebaseapp.com',
    storageBucket: 'mangemint-cf96d.firebasestorage.app',
    measurementId: 'G-B8QFZ3WH28',
  );

}