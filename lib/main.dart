import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:olx_clone/ui/routes/explore.dart';
import 'package:olx_clone/ui/routes/root.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:ui';

import 'code/ambience/objs.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  if (auth.currentUser == null) {
    await FirebaseAuth.instance.signInAnonymously();
  }

  // .then((_) {
  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
  // });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // accentColor: Colors.redAccent,
        // primarySwatch: Color.fromRGBO(66, 165, 245, 1.0),
        primaryColor: const Color(0xffffffff),
        accentColor: Color(0xff003034),
        

        visualDensity: VisualDensity.adaptivePlatformDensity,
        // textTheme: GoogleFonts.pacificoTextTheme(),
      ),
      // home: Root(),
      initialRoute: Root.route,
      routes: {
        Root.route: (context) => Root(),
        Explore.route: (context) => Explore(),
      },
    );
  }
}
