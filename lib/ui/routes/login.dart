import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:olx_clone/code/ambience/objs.dart';
import 'package:pin_input_text_field/pin_input_text_field.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  String email = '';
  String password;
  final _formKey = GlobalKey<FormState>();
  bool canResendCode = true;
  int _start = 60;
  int initialPage = 0;
  PageController pageViewController;

  String generatePassword() {
    var chars =
        "0123456789abcdefghijklmnopqrstuvwxyz-ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    var pass = "";

    for (int i = 0; i < 32; i++) {
      pass += chars[Random().nextInt(chars.length).floor()];
    }

    return pass;
  }

  @override
  void initState() {
    pageViewController = PageController(initialPage: initialPage);
    super.initState();
    // password = generatePassword();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: PageView(
          physics: NeverScrollableScrollPhysics(),
          controller: pageViewController,
          children: [
            Column(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(
                      'https://www.pngfind.com/pngs/m/610-6104451_image-placeholder-png-user-profile-placeholder-image-png.png'),
                ),
                Text(
                  'Enter your Email',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        // autofillHints: ,
                        onChanged: (input) {
                          print('email entered');
                          setState(() {
                            email = input;
                          });
                        },
                        validator: (input) {
                          if (input.contains('@') && input.contains('.'))
                            return null;

                          return 'Please insert a valid email';
                        },
                        decoration: InputDecoration(labelText: 'Email'),
                      ),
                      TextFormField(
                        // autofillHints: ,
                        onChanged: (input) {
                          // print('email entered');
                          setState(() {
                            password = input;
                          });
                        },
                        validator: (input) {
                          if (input.length > 5) return null;

                          return 'Password must be 8 charecters long';
                        },
                        decoration: InputDecoration(labelText: 'Password'),
                      ),
                    ],
                  ),
                ),
                Spacer(),
                MaterialButton(
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      // auth
                      //     .createUserWithEmailAndPassword(
                      //         email: email, password: password)
                      //     .then((userCredential) {
                      //   print('sending eamil verification code');
                      //   auth.applyActionCode('9834275098090');
                      // }).catchError((e) {
                      //   print('there was an error signing in $e');
                      // });

                      // Auth().signInWithEmailAndGeneratedPin(
                      //   email,
                      //   password,
                      // );
                      // Auth().signInWithEmailAndPassword(email, password);
                      auth
                          .createUserWithEmailAndPassword(
                              email: this.email, password: this.password)
                          .then((userCredential) {
                        // return null;
                        print('user registred');
                      });

                      // auth.authStateChanges().listen((user) {
                      //   print('user signed in succesful');
                      //   print(user);
                      //   if (user != null) pop(context);
                      // });

                      // pageViewController.nextPage(
                      //     duration: Duration(milliseconds: 200),
                      //     curve: Curves.bounceIn);
                      // initialPage = 1;
                    }
                  },
                  color: Colors.teal[900],
                  minWidth: double.infinity,
                  child: Text('Next'),
                ),
              ],
            ),
            Column(
              children: [
                Text(
                  'Enter your confirmation code',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          text: 'We sent a 4-digi code to ',
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 16,
                          ),
                          children: [
                            TextSpan(
                              text: email,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        pageViewController.previousPage(
                          duration: Duration(microseconds: 200),
                          curve: Curves.bounceIn,
                        );
                      },
                    ),
                  ],
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                  child: PinInputTextField(
                    pinLength: 4,
                    decoration: BoxLooseDecoration(
                        hintText: '----',
                        strokeColor: Colors.black,
                        enteredColor: Colors.teal[700],
                        radius: Radius.zero,
                        gapSpace: 10),
                    onSubmit: (pin) {
                      print('submitted pin is $pin');
                    },
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Builder(
                    builder: (BuildContext context) {
                      return GestureDetector(
                        onTap:
                            // canResendCode
                            //     ?
                            () {
                          print('resend code pressed');

                          startTimer();
                          Scaffold.of(context).showSnackBar(
                            SnackBar(
                              content: Text('We sent you a new PIN'),
                            ),
                          );
                        },
                        // : null,
                        child: Column(
                          children: [
                            Text(
                              'RESEND CODE BY EMAIL',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                                decorationThickness: 3,
                                // height: 2,
                              ),
                            ),
                            if (canResendCode == false)
                              Text(
                                '(try again in $_start)',
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    canResendCode = false;
    Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          if (_start < 1) {
            timer.cancel();
            canResendCode = true;
            _start = 60;
          } else {
            _start--;
            print('timer is running $_start');
          }
        },
      ),
    );
  }
}
