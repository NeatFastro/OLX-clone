import 'package:flutter/material.dart';
import 'package:olx_clone/code/ambience/vars.dart';
// import 'package:olx_clone/code/models/notification.dart' as model;

// final List<model.Notification> notifications = [];
class Notifications extends StatelessWidget {
  // final model.Notification notification;

  // Notifications([this.notification]) {
  //   notifications.add(this.notification);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
      ),
      body: ListView.builder(
        itemCount: cloudMessages.length,
        itemBuilder: (context, index) {
          // final model.Notification notification = notifications[index];

          return ListTile(
            leading: Icon(Icons.icecream),
            // title: Text(notifications[index]['notification']['title'] ?? 'null title'),
            title: Text(cloudMessages[index].notification.title ?? 'null body'),
            subtitle:
                Text(cloudMessages[index].notification.body ?? 'null body'),
          );
        },
      ),
      // body: Consumer(
      //   builder: (BuildContext context,
      //       T Function<T>(ProviderBase<Object, T>) watch, Widget child) {
      //     var appState = watch(appStateProvider);
      //     return ListView.builder(
      //         itemCount: appState.notifications.length,
      //         itemBuilder: (context, index) {
      //           return ListTile(
      //             title: Text(appState.notifications[index].title?? 'error'),
      //           );
      //         });
      //   },
      // ),
    );
  }
}
