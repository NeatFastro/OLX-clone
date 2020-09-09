import 'package:flutter/material.dart';

class Privacy extends StatefulWidget {
  @override
  _PrivacyState createState() => _PrivacyState();
}

class _PrivacyState extends State<Privacy> {
  bool showPhoneNumberInAds = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Privacy'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: ListTile(
              title: Text('Recommendations'),
              subtitle: Text('Receive recommendations based on your activity'),
              trailing: Switch(
                value: showPhoneNumberInAds,
                onChanged: (value) {
                  setState(() {
                    showPhoneNumberInAds = value;
                  });
                },
              ),
            ),
          ),
          ListTile(
            title: Text('Create password'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
