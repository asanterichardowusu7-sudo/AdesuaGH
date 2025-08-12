// lib/firebase_options.dart
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      // Web platform
      return const FirebaseOptions(
        apiKey: "AIzaSyDHCHqpwg386XSEcx3b78EIpmNdBsMOD9I",
        authDomain: "adesua-gh.firebaseapp.com",
        projectId: "adesua-gh",
        storageBucket: "adesua-gh.firebasestorage.app",
        messagingSenderId: "956886557438",
        appId: "1:956886557438:web:3a62b535609d20de18bbaf",
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return const FirebaseOptions(
          apiKey: "AIzaSyDHCHqpwg386XSEcx3b78EIpmNdBsMOD9I",
          authDomain: "adesua-gh.firebaseapp.com",
          projectId: "adesua-gh",
          storageBucket: "adesua-gh.firebasestorage.app",
          messagingSenderId: "956886557438",
          appId: "1:956886557438:web:3a62b535609d20de18bbaf",
        );
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        return const FirebaseOptions(
          apiKey: "AIzaSyDHCHqpwg386XSEcx3b78EIpmNdBsMOD9I",
          authDomain: "adesua-gh.firebaseapp.com",
          projectId: "adesua-gh",
          storageBucket: "adesua-gh.firebasestorage.app",
          messagingSenderId: "956886557438",
          appId: "1:956886557438:web:3a62b535609d20de18bbaf",
          iosBundleId: "com.example.adesua_gh",
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not set up for this platform.',
        );
    }
  }
}
