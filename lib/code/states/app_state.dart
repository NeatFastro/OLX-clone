import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppState extends ChangeNotifier {
  AppState() {
    initFirebaseMessagingConfiguration();
    print('firebase messaging initialized');
  }

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  initFirebaseMessagingConfiguration() {
    _firebaseMessaging.configure(
      onMessage: (message) {
        print('onMessage');
        print(message);
      },
      onResume: (message) {},
      onLaunch: (message) {
        print('on launch called');
        print(message);
      },
    );
  }
}
