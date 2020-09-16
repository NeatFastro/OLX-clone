import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class Notification {
  final String title;
  final String body;

  Notification({
    this.title,
    this.body,
  });


  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'body': body,
    };
  }

  factory Notification.fromMap(Map notification) {
    // if (map == null) return null;
  
    return Notification(
      title: notification['title'],
      body: notification['body'],
    );
  }

}
