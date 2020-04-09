import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:koona/models/messages.dart';
import 'package:koona/models/user.dart';
import 'package:koona/utils/utils.dart';

class FirebaseMethods{

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  static final Firestore firestore = Firestore.instance;

  User one = User(); 




  User _userFromFirebase(FirebaseUser user){
    return user!= null ? User(uid: user.uid, email: user.email, name: user.displayName, displayPic: user.photoUrl) : null;
  }
  Stream<User> get user {
    return _auth.onAuthStateChanged.map(_userFromFirebase);
  }

  Future<FirebaseUser> signinWithGoogle() async{
    try{
      GoogleSignInAccount _signinAccount = await _googleSignIn.signIn();
      GoogleSignInAuthentication _signinauth = await _signinAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.getCredential(idToken: _signinauth.idToken, accessToken: _signinauth.accessToken);
      AuthResult result = await _auth.signInWithCredential(credential);
      FirebaseUser user = result.user;
      _userFromFirebase(user);
      return user ;
    }catch(e){
      print(e);
      return null;

    }
  }
  Future<bool> checkUser(FirebaseUser user) async{
    QuerySnapshot result = await firestore.collection('users').where('email', isEqualTo: user.email).getDocuments();

    final List<DocumentSnapshot> docs = result.documents;

    return docs.length == 0 ? true : false;

  }

  Future<void> addToDb(FirebaseUser cuser) async {
    String username = Utils.getUsername(cuser.email);
    one = User(
      uid: cuser.uid,
      displayPic: cuser.photoUrl,
      email: cuser.email,
      name: cuser.displayName,
      username: username

    );
    try {

      await firestore.collection('users').document(cuser.uid).setData(
          one.toMap(one));
    }
    catch(e){
      print(e);
    }

    

  }
  Future<FirebaseUser> getUser() async{
    FirebaseUser current;
    current = await _auth.currentUser();
    return current;
  }
  Future<void> signOut () async{
    await _googleSignIn.disconnect();
    await _googleSignIn.signOut();
    return await _auth.signOut();
  }
  Future<List<User>> fetchAllUsers(FirebaseUser firebaseUser) async{

    List<User> usersList = List<User>();
    QuerySnapshot querySnapshot = await firestore.collection('users').getDocuments();
    for(var i=0; i <querySnapshot.documents.length; i++)
    {
     if(querySnapshot.documents[i].documentID!=firebaseUser.uid){
       usersList.add(User.fromMap(querySnapshot.documents[i].data));
     }  
    }
    return usersList;



  }
  Future<void> addMessageToDb(Message message, User sender, User recipient) async{

    var map = message.toMap();
      await firestore.collection('messages').document(message.senderId).collection(message.recieverId).add(map);
      await firestore.collection('messages').document(message.recieverId).collection(message.senderId).add(map);

  }


}