import 'package:flutter/material.dart';
import 'package:olx_clone/code/ambience/objs.dart';
import 'package:olx_clone/code/models/userDocument.dart';
import 'package:olx_clone/code/services/data_store.dart';
import 'package:olx_clone/code/utils.dart';

class Notifications extends StatelessWidget {
  final DataStore _store = DataStore();

  final List notifications = [];

  fetchNotifications() {
    _store.getUser(auth.currentUser.uid).then((user) {
      // return null;
      // UserDocument.fromDocument(user.)
      notifications.addAll(user.noitfications);
    });
  }
//  repo.getUser();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
      ),
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final notification = notifications[index];
          return ListTile(
            leading: Icon(Icons.icecream),
            title: Text(notification.title),
            subtitle: Text(notification.timeStamp),
            // onTap: ()=> goto(context, notification.destination),
          );
        },
      ),
    );
  }
}
