

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:koona/models/messages.dart';
import 'package:koona/models/user.dart';
import 'package:koona/res/firebase_methods.dart';

class FirebaseRepo {

  FirebaseMethods firebaseMethods = FirebaseMethods();
  static final Firestore firestore = Firestore.instance;

  Future<FirebaseUser> getCurrentUser() => firebaseMethods.getUser();
  Future<List<User>> fetchAllUsers(FirebaseUser firebaseUser) => firebaseMethods.fetchAllUsers(firebaseUser);

 Future<FirebaseUser> signinWithGoogle() => firebaseMethods.signinWithGoogle();

 Future<void> addToDb(FirebaseUser user) => firebaseMethods.addToDb(user);
  Future<void> signOut() => firebaseMethods.signOut();

  Future<void>addMessageToDb(Message message, User sender, User recipient)=> firebaseMethods.addMessageToDb(message,sender,recipient);
}