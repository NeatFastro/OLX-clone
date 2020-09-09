import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:olx_clone/code/models/user.dart';
import 'package:olx_clone/code/utils.dart';
import 'package:olx_clone/code/services/repository.dart';
import 'package:olx_clone/ui/routes/authenticationFlow.dart';

import 'package:olx_clone/ui/routes/invoices_and_billing.dart';
import 'package:olx_clone/ui/routes/profile.dart';
import 'package:olx_clone/ui/routes/settings.dart';
import 'package:olx_clone/ui/widgets/user_account_tile.dart';

class MyAccount extends StatelessWidget {
  final Repository repository = Repository();
  // User user;

  // fetchUserDetails(String id) async {
  //   user = (await repository.getUser(id)) as User;
  // }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (snapshot.data == null || snapshot.data.isAnonymous) {
          return AuthenticationFow(message: 'your account');
        } else {
          // return Text('user is null');
          // return AuthenticationFow();
          final User user = snapshot.data;
          // fetchUserDetails(user.uid);
          // repository.getUser(user.uid).then((user) =>  user);

          return FutureBuilder<UserDoc>(
              future: repository.getUser(user.uid),
              builder: (context, AsyncSnapshot<UserDoc> snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }
                UserDoc user = snapshot.data;
                return SafeArea(
                  child: Column(
                    children: [
                      UserAccountTile(
                        user: user,
                        onPress: () => Profile(user),
                      ),
                      ListTile(
                        leading: Icon(Icons.payment),
                        title: Text('Buy Packages & My Order'),
                        subtitle:
                            Text('Packages, orders, billing and invoices'),
                        trailing: Icon(Icons.arrow_forward_ios),
                        onTap: () {
                          goto(context, InvoicesAndBilling());
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.settings),
                        title: Text('Settings'),
                        subtitle: Text('Privacy and Logout'),
                        trailing: Icon(Icons.arrow_forward_ios),
                        onTap: () {
                          goto(context, Settings());
                        },
                      ),
                      ListTile(
                        // leading: Icon(Icons.payment),
                        leading: Text(
                          'O|x',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        title: Text('help & Support'),
                        subtitle: Text('Help center and legal terms'),
                        trailing: Icon(Icons.arrow_forward_ios),
                        onTap: () {},
                      ),
                    ],
                  ),
                );
              });
        }
      },
    );
  }
}
