import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:koona/models/user.dart';
import 'package:koona/utils/utils.dart';

class FirebaseMethods{

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  static final Firestore firestore = Firestore.instance;






  User _userFromFirebase(FirebaseUser user){
    return user!= null ? User(uid: user.uid, email: user.email, name: user.displayName, displayPic: user.photoUrl) : null;
  }
  Stream<User> get user {
    return _auth.onAuthStateChanged.map(_userFromFirebase);
  }

  Future<User> signinWithGoogle() async{
    try{
      GoogleSignInAccount _signinAccount = await _googleSignIn.signIn();
      GoogleSignInAuthentication _signinauth = await _signinAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.getCredential(idToken: _signinauth.idToken, accessToken: _signinauth.accessToken);
      AuthResult result = await _auth.signInWithCredential(credential);
      FirebaseUser user = result.user;
      return _userFromFirebase(user);
    }catch(e){
      print(e);
      return null;

    }
  }
  Future<bool> checkUser(User user) async{
    QuerySnapshot result = await firestore.collection('users').where('email', isEqualTo: user.email).getDocuments();

    final List<DocumentSnapshot> docs = result.documents;

    return docs.length == 0 ? true : false;

  }

  Future<void> addToDb(User user) async{

    getUser();
    FirebaseUser current;
    current = await getUser();
    User user1 = User(
        uid: current.uid,
        name: current.displayName,
        displayPic: current.photoUrl,
        email: current.email,
        username: Utils.getUsername(current.email)
    );

    firestore.collection('users').document(current.uid).setData(user1.toMap(user1));

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


}