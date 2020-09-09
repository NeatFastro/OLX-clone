import 'package:flutter/material.dart';
import 'package:olx_clone/code/ambience/objs.dart';
import 'package:olx_clone/code/utils.dart';
import 'package:olx_clone/ui/routes/notifications.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Column(
        children: [
          ListTile(
            title: Text('Privacy'),
            subtitle: Text('Phone number visibility'),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {},
          ),
          ListTile(
            title: Text('Notifications'),
            subtitle: Text('Recommendations & Special communications'),
            onTap: () {
              goto(context, Notifications());
            },
          ),
          ListTile(
            title: Text('Logout'),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text('Logout'),
                    content: Text(
                        'You won\'t receive messages and notification for your ads until you log in again. Are you sure you want to log out?'),
                    actions: [
                      MaterialButton(
                        // color: Colors.red,
                        onPressed: () => pop(context),
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                            decorationThickness: 3,
                          ),
                        ),
                      ),
                      MaterialButton(
                        // color: Colors.blue,
                        onPressed: () {
                          auth.signOut();
                          // pop(context);
                          Navigator.of(context).popUntil(
                              ModalRoute.withName(Navigator.defaultRouteName));

                          // Navigator.popUntil(context,
                          //     ModalRoute.withName(Navigator.defaultRouteName));

                          // goto(context, Root());
                        },
                        child: Text(
                          'Log Out',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                            decorationThickness: 3,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );
            },
          ),
          ListTile(
            title: Text('logout from all devices'),
            onTap: () {
              // FirebaseAuth.instance.signOut();
              auth.signOut();
            },
          ),
          ListTile(
            title: Text('Deactivate account and delete my data'),
            onTap: () async {
              // FirebaseAuth.instance.currentUser()?.then((user) => user.delete());
              auth.currentUser.delete();

              firestore
                  .collection('users')
                  .doc(auth.currentUser.uid)
                  .update({'deletedAccount': true});
                  // .update(UserDoc(deletedAccount: true).toDocument());

              Navigator.of(context)
                  .popUntil(ModalRoute.withName(Navigator.defaultRouteName));
            },
          ),
        ],
      ),
    );
  }
}
