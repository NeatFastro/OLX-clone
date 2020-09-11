import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:olx_clone/code/models/userDocument.dart';

class Auth {
  final GoogleSignIn googleAuth = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // signInWithEmailAndGeneratedPin(String email, String password) async {
  //   try {
  //     // UserCredential userCredential = await
  //     _auth
  //         .createUserWithEmailAndPassword(email: email, password: password)
  //         .catchError((err) {
  //       print('error is $err');

  //     });

  //     // print('sending verification');
  //     _auth.currentUser.sendEmailVerification();
  //     // _auth.sendPasswordResetEmail(email: email);
  //   } on FirebaseAuthException catch (e) {
  //     if (e.message == 'email-already-in-use') {
  //       print('email-already-in-use');
  //       print('message $e');
  //       print('message ${e.code}');
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  signInWithEmailAndPassword(String email, String password) async {
    print('signing with email');
    try {
      print('in the try block');
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      print(e);
    } finally {
      print('i am finally block for sign in method');
    }
  }

  Future<User> googleSignIn() async {
    User user;
    try {
      googleAuth
          .signIn()
          .then((userGoogleAccount) => userGoogleAccount.authentication)
          .then((googleAuth) {
        AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleAuth.idToken,
          accessToken: googleAuth.accessToken,
        );

        _auth.signInWithCredential(credential).then((authResult) {
          updateUserData(authResult.user);
          user = authResult.user;
        });
      });

      return user;
    } catch (e) {
      print(e);
      return null;
    }
  }

  updateUserData(User user) async {
    if (user != null) {
      if (await (_db
          .collection('users')
          .doc(user.uid)
          .get()
          .then((doc) => doc.exists))) {
        print('user already exists');
      } else {
        DocumentReference userDocRef = _db.collection('users').doc(user.uid);
        UserDocument userDoc = UserDocument(
          id: user.uid,
          name: user.displayName,
          email: user.email,
          displayName: user.displayName,
          photoUrl: user.photoURL,
          memberSince: DateTime.now().toIso8601String(),
          // memberSince: user.metadata.creationTime,
          // memberSince: Timestamp.fromDate(user.metadata.creationTime),
          deletedAccount: false,
        );
        userDocRef.set(
          userDoc.toDocument(),
          SetOptions(merge: true),
        );
      }
    }
  }

  signOut() {
    googleAuth?.signOut();
    _auth?.signOut();
    _auth.signInAnonymously();
  }
}
