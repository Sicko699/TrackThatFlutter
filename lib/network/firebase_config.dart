

// Firebase configuration helper
import 'package:firebase_core/firebase_core.dart';
import 'package:track_that_flutter/firebase_options.dart';

class FirebaseConfig {
  /// Initializes Firebase using the generated [DefaultFirebaseOptions].
  static Future<void> init() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }
}
