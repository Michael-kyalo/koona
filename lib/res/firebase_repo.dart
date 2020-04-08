import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:koona/models/user.dart';
import 'package:koona/res/firebase_methods.dart';

class FirebaseRepo {

  FirebaseMethods firebaseMethods = FirebaseMethods();
  static final Firestore firestore = Firestore.instance;

  Future<FirebaseUser> getCurrentUser() => firebaseMethods.getUser();
  Future<List<User>> fetchAllUsers(FirebaseUser firebaseUser) => firebaseMethods.fetchAllUsers(firebaseUser);

 Future<User> signinWithGoogle() => firebaseMethods.signinWithGoogle();

 Future<void> addToDb(User user) => firebaseMethods.addToDb(user);
  Future<void> signOut() => firebaseMethods.signOut();
}