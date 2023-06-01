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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBObLwFH_AUnEJQjQtlWYjNByTqmvolzRE',
    appId: '1:205806916918:android:71e749cacc0eb9b9ee8f97',
    messagingSenderId: '205806916918',
    projectId: 'shebafinancial',
    storageBucket: 'shebafinancial.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDXkSypYVjvKOfbLHmJ95gfL0caLo8Zy_M',
    appId: '1:205806916918:ios:395e4aeb897fec87ee8f97',
    messagingSenderId: '205806916918',
    projectId: 'shebafinancial',
    storageBucket: 'shebafinancial.appspot.com',
    androidClientId: '205806916918-dimk4n1bp13psvu2p8ci1vdhmacpl5dn.apps.googleusercontent.com',
    iosClientId: '205806916918-2254nqup013vvu77bqrv4acusjievhas.apps.googleusercontent.com',
    iosBundleId: 'com.example.shebaFinancial',
  );
}