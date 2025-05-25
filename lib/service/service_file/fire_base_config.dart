

import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

class DefaultFirebaseConfig {
  static FirebaseOptions get platformOptions {
    if (kIsWeb) {
      // Web
      return const FirebaseOptions(
        apiKey: 'AIzaSyA83NFqhtD-xqNEyrkvEu8O1Nwhy_OJ9y4',
        authDomain: 'gnb-project-72b87.firebaseapp.com',
        databaseURL: 'https://react-native-firebase-testing.firebaseio.com',
        projectId: 'gnb-project-72b87',
        storageBucket: 'gnb-project-72b87.firebasestorage.app',
        messagingSenderId: '477370392345',
        appId: '1:477370392345:web:8718d5ee3a752d2135ef88',
        measurementId: 'G-HT2C4EJYGM',
      );
    } else if (Platform.isIOS || Platform.isMacOS) {
      // iOS and MacOS
      return const FirebaseOptions(
        appId: '1:477370392345:ios:de8279aadc80d6bb35ef88',
        apiKey: 'AIzaSyAe3M4nlGCYRiAnOjSmmS6aFYMvjypdGxc',
        projectId: 'gnb-project-72b87',
        messagingSenderId: '477370392345',
        iosBundleId: 'io.flutter.plugins.firebase.firestore.example',
        iosClientId:
            '448618578101-ja1be10uicsa2dvss16gh4hkqks0vq61.apps.googleusercontent.com',
        androidClientId:
            '448618578101-2baveavh8bvs2famsa5r8t77fe1nrcn6.apps.googleusercontent.com',
        storageBucket: 'gnb-project-72b87.firebasestorage.app',
        databaseURL: 'https://react-native-firebase-testing.firebaseio.com',
      );
    } else {
      // Android
      return const FirebaseOptions(
        appId: '1:477370392345:android:043411cad62436c635ef88',
        apiKey: 'AIzaSyBtCHC8ZvICNxR1FyKCrCn6AFTCMA7A6EI',
        projectId: 'gnb-project-72b87',
        messagingSenderId: '477370392345',
      );
    }
  }
}
