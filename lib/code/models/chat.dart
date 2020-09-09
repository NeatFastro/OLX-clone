import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:olx_clone/code/models/message.dart';

class Chat {
  final String id;
  final List between;
  final String crrespondingAd;
  // final String adOwner;
  final List<Message> messages;

  Chat({
    this.id,
    this.between,
    this.crrespondingAd,
    // this.adOwner,
    this.messages,
  });

  Map<String, dynamic> toDocument() {
    return {
      'id': id,
      'between': between,
      'crrespondingAd': crrespondingAd,
      // 'adOwner': adOwner,
      'messages': messages.map((message) => message.toMap()),
    };
  }

  factory Chat.fromDocument(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data();

    return Chat(
      id: document.id,
      between: data['between'],
      crrespondingAd: data['crrespondingAd'],
      // adOwner: data['adOwner'],
      // messages: List.from(data['messages']).map((message)=> Message.fromMap(message)),
      // messages: data['messages'],
      messages:
          List<Message>.from(data['messages']?.map((x) => Message.fromMap(x))) ?? [],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'between': between,
      'crrespondingAd': crrespondingAd,
      // 'adOwner': adOwner,
      'messages': messages?.map((x) => x?.toMap())?.toList(),
    };
  }

  factory Chat.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Chat(
      id: map['id'],
      between: List<String>.from(map['between']),
      crrespondingAd: map['crrespondingAd'],
      // adOwner: map['adOwner'],
      messages:
          List<Message>.from(map['messages']?.map((x) => Message.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory Chat.fromJson(String source) => Chat.fromMap(json.decode(source));
}
