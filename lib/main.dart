import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:olx_clone/code/ambience/vars.dart';
import 'package:olx_clone/code/models/cloud_message.dart';
import 'package:olx_clone/code/utils.dart';
import 'package:olx_clone/ui/routes/explore.dart';
import 'package:olx_clone/ui/routes/notifications.dart';
import 'package:olx_clone/ui/routes/root.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:olx_clone/code/ambience/objs.dart';
import 'dart:ui';
import 'package:olx_clone/code/models/notification.dart' as model;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Firebase.initializeApp();

  if (auth.currentUser == null) await FirebaseAuth.instance.signInAnonymously();
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  initFirebaseMessagingConfiguration() {
    _firebaseMessaging.configure(
      onMessage: (message) {
        print('onMessage');
        print(message);

        var cloudMessage = CloudMessage.fromMap(message);
        print('serialized message');
        print(cloudMessage);

        cloudMessages.add(cloudMessage);
        goto(context, Notifications());
        // print(notification);
      },
      onResume: (message) {
        // print('onResume');
        // print(message);
        // model.Notification notification = model.Notification.fromMap(message);
        // print('going to notifications screen');
        // goto(context, Notifications());
      },
      onLaunch: (message) {
        print('on launch called');
        print(message);
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    // initFirebaseMessagingConfiguration();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: const Color(0xffffffff),
        accentColor: Color(0xff003034),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: Root.route,
      routes: {
        Root.route: (context) => Root(),
        Explore.route: (context) => Explore(),
      },
    );
  }
}
