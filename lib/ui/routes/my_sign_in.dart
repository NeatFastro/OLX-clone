import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:olx_clone/code/ambience/objs.dart';
import 'package:olx_clone/code/auth.dart';

class MySignIn extends StatefulWidget {
  @override
  _MySignInState createState() => _MySignInState();
}

class _MySignInState extends State<MySignIn> {
  String email, password;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Card(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      radius: 40,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      'Enter you Email',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
                    ),
                  ),
                  Expanded(
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.alternate_email),
                                labelText: 'Email',
                                border: OutlineInputBorder(),
                              ),
                              onChanged: (input) {
                                email = input;
                              },
                              validator: (input) {
                                if (input.contains('.') && input.contains('@'))
                                  return null;
                                else
                                  return 'Invalid Email';
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: TextFormField(
                              keyboardType: TextInputType.visiblePassword,
                              decoration: InputDecoration(
                                // icon: Icon(Icons.vpn_key_outlined),
                                prefixIcon: Icon(Icons.vpn_key_outlined),
                                labelText: 'Password',
                                border: OutlineInputBorder(),
                              ),
                              onChanged: (input) {
                                password = input;
                              },
                              validator: (input) {
                                if (input.length > 6 && input.isNotEmpty)
                                  return null;
                                else
                                  return 'Password should be longer';
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  ElevatedButton(
                    child: Text('Next'),
                    onPressed: () async {
                      if (formKey.currentState.validate()) {
                        // UserCredential userCredential =
                        await Auth(context).signInWithEmailAndPassword(
                          email: email,
                          password: password,
                        );
                      }
                    },
                  ),
                  // SizedBox(
                  //   height: 50,
                  // ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
