import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<bool> isSignedIn() async {
    final currentUser = await _firebaseAuth.currentUser;

    return currentUser != null;
  }

  Future<bool> isFirstTime(String uid) async {
    bool exist;

    await _firestore.collection('users').doc(uid).get().then((user) {
      exist = user.exists;
    });

    return exist;
  }

  Future storeUser(user) async {
    await _firestore.collection('users').doc(user.uid).set({
      'uid': user.uid,
      'name': user.displayName,
      'email': user.email,
    });
  }

  Future getUserDetail(user) async {
    await _firestore.collection('users');
  }

  Future<User> getUser() async {
    final currentUser = await _firebaseAuth.currentUser;
    return currentUser;
  }

  Future<User> signInWithGoogle() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();


    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final UserCredential authResult =
        await _firebaseAuth.signInWithCredential(credential);

    final User user = authResult.user;

    return user;
  }

  Future<void> logOut() async {
    return Future.wait([
      _firebaseAuth.signOut(),
      _googleSignIn.signOut(),
    ]);
  }
}
