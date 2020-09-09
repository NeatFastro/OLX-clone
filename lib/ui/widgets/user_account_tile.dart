import 'package:flutter/material.dart';

import 'package:olx_clone/code/ambience/vars.dart';
import 'package:olx_clone/code/models/user.dart';

class UserAccountTile extends StatelessWidget {
  final VoidCallback onPress;
  final UserDoc user;

  const UserAccountTile({
    Key key,
    this.onPress,
    this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FittedBox(
          child: Row(
            children: [
              CircleAvatar(
                // backgroundColor: Colors.blue,
                radius: 50,
                // child: Text(
                //   user.displayName.substring(0, 1) ?? 'null',
                //   style: TextStyle(
                //     color: Colors.white,
                //     fontSize: 44,
                //     fontWeight: FontWeight.w900,
                //   ),
                // ),
                // child: ClipRRect(
                //   borderRadius: BorderRadius.circular(50),
                //   child: Image.network(
                //       user.photoUrl ?? noPhotoUrl),
                // ),
                backgroundImage: NetworkImage(user.photoUrl ?? noPhotoUrl),
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
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
