import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';

final FirebaseFirestore firestore = FirebaseFirestore.instance;

final FirebaseAuth auth = FirebaseAuth.instance;

final FirebaseStorage storage =
    FirebaseStorage(storageBucket: 'gs://olx-clone-796b9.appspot.com');

       final FirebaseMessaging firebaseMessaging = FirebaseMessaging();

