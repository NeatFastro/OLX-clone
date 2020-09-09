import 'package:flutter/material.dart';

class Notifications extends StatefulWidget {
  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  bool recommendationsAllowed = true;
  bool specialCommunicationAndOffersAllowed = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: ListTile(
              title: Text('Recommendations'),
              subtitle: Text('Receive recommendations based on your activity'),
              trailing: Switch(
                value: recommendationsAllowed,
                onChanged: (value) {
                  setState(() {
                    recommendationsAllowed = value;
                  });
                },
              ),
            ),
          ),
          ListTile(
            title: Text('Special communications & offers'),
            subtitle: Text('Receive updates, offers, surveys and more'),
            trailing: Switch(
              value: specialCommunicationAndOffersAllowed,
              onChanged: (value) {
                setState(() {
                  specialCommunicationAndOffersAllowed = value;
                });
              },
            ),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
