import 'package:flutter/material.dart';
import 'package:olx_clone/code/models/user.dart';

class Profile extends StatelessWidget {
  final UserDoc user;
  const Profile(this.user);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.blue,
                  radius: 50,
                  // backgroundImage: NetworkImage(user.photoUrl),
                  child: Text(
                    user.displayName.substring(0, 1) ?? 'null',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 44,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              Text(user.following?.length?.toString() ?? '0'),
                              Text('FOLLOWING'),
                            ],
                          ),
                          // Divider(),
                          VerticalDivider(
                            thickness: 10,
                          ),
                          Column(
                            children: [
                              Text(user.followers?.length?.toString() ?? '0'),
                              Text('FOLLOWING'),
                            ],
                          ),
                        ],
                      ),
                      OutlineButton(
                        onPressed: () {},
                        child: Text('Edit Profile'),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.displayName,
                  style: TextStyle(fontSize: 24),
                ),
                Text(
                  'View and edit profile',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                    decorationThickness: 3,
                    // height: 2,
                  ),
                ),
                Divider(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
