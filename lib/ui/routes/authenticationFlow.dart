import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:olx_clone/code/auth.dart';
import 'package:olx_clone/code/ambience/objs.dart';
import 'package:olx_clone/code/models/userDocument.dart';
import 'package:olx_clone/code/utils.dart';
import 'package:olx_clone/ui/routes/login.dart';
import 'package:olx_clone/ui/routes/my_sign_in.dart';
import 'package:typicons_flutter/typicons_flutter.dart';

class AuthenticationFow extends StatelessWidget {
  final message;
  // FirebaseAuthService _authService = FirebaseAuthService();

  const AuthenticationFow({Key key, this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final data = MediaQuery.of(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Align(
                alignment: Alignment.topLeft,
                // child: Builder(
                //   builder: (context) => IconButton(
                //     icon: Icon(Icons.close),
                //     onPressed: () {
                //       // pop(context);
                //       Scaffold.of(context).showSnackBar(SnackBar(
                //         content: Text(
                //             'Did not felt the need to implement this functionality'),
                //         action: SnackBarAction(
                //           label: 'Okay Boomer',
                //           onPressed: () {},
                //         ),
                //       ));
                //     },
                //   ),
                // ),
                child: IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    pop(context);
                  },
                ),
              ),
              if (message != null)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Sign in to see $message'),
                ),
              SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.center,
                child: Text(
                  'O|X',
                  style: TextStyle(
                    fontSize: 146,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text(
                // 'PAKISTAN',
                'CLONE',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(
                height: 26,
              ),
              // Spacer(),
              // SliverFillRemaining(),
              ColoredBox(
                color: Colors.tealAccent[700],
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Column(
                    children: [
                      OlxButton(
                        icon: Icons.phone_iphone,
                        label: 'Continue with Phone',
                        onPress: () {},
                      ),
                      OlxButton(
                        icon: Typicons.social_google_plus,
                        label: 'Continue with Google',
                        onPress: () async {
                          final myAuth = Auth(context);
                          User user = await myAuth.googleSignIn();

                          if (user != null) {
                            UserDocument userDoc = UserDocument(
                              id: user.uid,
                              name: user.displayName,
                              displayName: user.displayName,
                              photoUrl: user.photoURL,
                              memberSince: user
                                  .metadata.creationTime.millisecondsSinceEpoch
                                  .toString(),
                            );
                            firestore.collection('users').doc(user.uid).set(
                                  userDoc.toDocument(),
                                );
                          }
                        },
                      ),
                      OlxButton(
                        icon: Typicons.social_facebook,
                        label: 'Continue with Facebook',
                        onPress: () {},
                      ),
                      OlxButton(
                        icon: Typicons.mail,
                        label: 'Continue with Email',
                        onPress: () {
                          // auth.signInWithEmailAndPassword(email, password);
                          // goto(context, SignIn());
                          goto(context, MySignIn());
                        },
                      ),
                      SizedBox(height: 10),
                      Text('If you cotinue, you are accepting'),
                      GestureDetector(
                        onTap: () {},
                        child: Text(
                          'OLX Terms and conditions and privacy Policy',
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OlxButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Function onPress;

  const OlxButton({
    Key key,
    this.icon,
    this.label,
    this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 26,
          vertical: 6,
        ),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Icon(icon),
                ),
                Expanded(
                  child: Text(
                    label,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
