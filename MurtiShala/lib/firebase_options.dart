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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDrNrCFfm0XoYysLln-oqDXBdCbPfc_9hw',
    appId: '1:140062973464:android:9d1bad03ed6e584f8bed6d',
    messagingSenderId: '140062973464',
    projectId: 'murtishala-3d5c3',
    storageBucket: 'murtishala-3d5c3.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC2Ydf0wGK1GYkdeML9IiCCiUM5K-gnVgg',
    appId: '1:140062973464:ios:06845aff91e3ba0a8bed6d',
    messagingSenderId: '140062973464',
    projectId: 'murtishala-3d5c3',
    storageBucket: 'murtishala-3d5c3.appspot.com',
    iosBundleId: 'com.example.idolBooking',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyC2Ydf0wGK1GYkdeML9IiCCiUM5K-gnVgg',
    appId: '1:140062973464:ios:b99e6d04e780fad68bed6d',
    messagingSenderId: '140062973464',
    projectId: 'murtishala-3d5c3',
    storageBucket: 'murtishala-3d5c3.appspot.com',
    iosBundleId: 'com.example.idolBooking.RunnerTests',
  );
}