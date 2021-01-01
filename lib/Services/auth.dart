import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:test_site/Services/user.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
//Create User Obj Based on UID
  Users _userFromFirebase(User usr) {
    return usr != null
        ? Users(uid: usr.uid, email: usr.email, name: usr.displayName)
        : null;
  }

//Auth Change Users Stream

  Stream<Users> get userStream {
    return _auth.authStateChanges().map(_userFromFirebase);
  }

//Sign In Google

  Future<Users> signInWithGoogle() async {
    final googleUser = await _googleSignIn.signIn();
    final googleAuth = await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    final authResult = await _auth.signInWithCredential(credential);
    return _userFromFirebase(authResult.user);
  }

//Sign Out Google
  void signOutGoogle() async {
    await googleSignIn.signOut();

    print("User Sign Out");
  }

//Register Email
  // Future registerWithEmailAndPass(String email, String password) async {
  //   try {
  //     AuthResult result = await _auth.createUserWithEmailAndPassword(
  //         email: email, password: password);
  //     FirebaseUser user = result.user;

  //     //Create New Doc With UID.
  //     // await DatabaseService(uid: user.uid)
  //     //     .updateUserData(null, null, null, null);
  //     return _userFromFirebase(user);
  //   } catch (e) {
  //     print(e.toString());
  //   }
  // }

//Sign Out
  Future signOut() async {
    try {
      await googleSignIn.signOut();
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }

  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<User> _handleSignIn() async {
    try {
      // hold the instance of the authenticated user
      User user;
      // flag to check whether we're signed in already
      bool isSignedIn = await _googleSignIn.isSignedIn();
      if (isSignedIn) {
        // if so, return the current user
        user = _auth.currentUser;
      } else {
        try {
          final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
          final GoogleSignInAuthentication googleAuth =
              await googleUser.authentication;
          // get the credentials to (access / id token)
          // to sign in via Firebase Authentication
          final AuthCredential credential = GoogleAuthProvider.credential(
              accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
          user = (await _auth.signInWithCredential(credential)).user;
        } catch (e) {
          print(e.toString());
        }
      }

      return user;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future onGoogleSignIn(BuildContext context) async {
    User user = await _handleSignIn();
    Users usr = _userFromFirebase(user);
    return usr;
  }
}
