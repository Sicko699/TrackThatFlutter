import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart' show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for the current platform.
///
/// Replace the placeholder values with your Firebase project settings.
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
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAstFUkwp8s0j1o7XKdmHXK1ZqpWq1zVV4',
    authDomain: 'kotlin-95f5d.firebaseapp.com',
    projectId: 'kotlin-95f5d',
    storageBucket: 'kotlin-95f5d.firebasestorage.app',
    messagingSenderId: '475057435698',
    appId: '1:475057435698:web:example',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAstFUkwp8s0j1o7XKdmHXK1ZqpWq1zVV4',
    projectId: 'kotlin-95f5d',
    storageBucket: 'kotlin-95f5d.firebasestorage.app',
    messagingSenderId: '475057435698',
    appId: '1:475057435698:android:f97671d4a5781e1728782b',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCqonNyaM097p2998gSsxcaItPWvdybErE',
    projectId: 'kotlin-95f5d',
    storageBucket: 'kotlin-95f5d.firebasestorage.app',
    messagingSenderId: '475057435698',
    appId: '1:475057435698:ios:a0b988f1d06bb80328782b',
    iosBundleId: 'com.example.temp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCqonNyaM097p2998gSsxcaItPWvdybErE',
    projectId: 'kotlin-95f5d',
    storageBucket: 'kotlin-95f5d.firebasestorage.app',
    messagingSenderId: '475057435698',
    appId: '1:475057435698:ios:a0b988f1d06bb80328782b',
    iosBundleId: 'com.example.temp',
  );
}
