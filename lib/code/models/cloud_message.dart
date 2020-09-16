import 'dart:convert';

import 'package:olx_clone/code/models/notification.dart';

class CloudMessage {
  final Notification notification;
  final Map data;
  
  CloudMessage({
    this.notification,
    this.data,
  });

  Map<String, dynamic> toMap() {
    return {
      'notification': notification?.toMap(),
      'data': data,
    };
  }

  factory CloudMessage.fromMap(Map map) {
    // if (map == null) return null;
    print('serializing message');
  
    return CloudMessage(
      notification: Notification.fromMap(map['notification']),
      data: Map.from(map['data']),
    );
  }

  String toJson() => json.encode(toMap());

  factory CloudMessage.fromJson(String source) => CloudMessage.fromMap(json.decode(source));
}
