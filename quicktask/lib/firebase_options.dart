import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
      apiKey: "AIzaSyDoH4VEbHNZMTkUYw91PXBnKqMg_VJ6GTw",
      authDomain: "quicktask-feba8.firebaseapp.com",
      projectId: "quicktask-feba8",
      storageBucket: "quicktask-feba8.firebasestorage.app",
      messagingSenderId: "166849485277",
      appId: "1:166849485277:web:c328b4b99659889d0c3e34",
      measurementId: "G-RWJL4P1MGD"
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBfs8SnR5eG_-fp9ebgijmKubCbJg47hqw',
    appId: '1:166849485277:android:2180bfb31543d9300c3e34',
    messagingSenderId: '166849485277',
    projectId: 'quicktask-feba8',
    storageBucket: 'quicktask-feba8.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'YOUR_IOS_API_KEY',
    appId: 'YOUR_IOS_APP_ID',
    messagingSenderId: 'YOUR_IOS_MESSAGING_SENDER_ID',
    projectId: 'YOUR_PROJECT_ID',
    storageBucket: 'YOUR_IOS_STORAGE_BUCKET',
    iosClientId: 'YOUR_IOS_CLIENT_ID',
    iosBundleId: 'YOUR_IOS_BUNDLE_ID',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'YOUR_MACOS_API_KEY',
    appId: 'YOUR_MACOS_APP_ID',
    messagingSenderId: 'YOUR_MACOS_MESSAGING_SENDER_ID',
    projectId: 'YOUR_PROJECT_ID',
    storageBucket: 'YOUR_MACOS_STORAGE_BUCKET',
    iosClientId: 'YOUR_MACOS_CLIENT_ID',
    iosBundleId: 'YOUR_MACOS_BUNDLE_ID',
  );
}
