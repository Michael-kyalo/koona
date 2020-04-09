import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:koona/res/firebase_methods.dart';
import 'package:koona/res/firebase_repo.dart';
import 'package:koona/screens/homescreen.dart';
import 'package:koona/screens/loading.dart';
class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  FirebaseRepo _repo = FirebaseRepo();
  bool isloading = false;
  @override
  Widget build(BuildContext context) {


   return isloading==true ? Loading(): Scaffold(
      backgroundColor: Colors.green,
      body: SingleChildScrollView(
        child: Container(
            child: Padding(
              padding: const EdgeInsets.only(top:100,right: 50, left: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: <Widget>[
                  Text("Koona", style: TextStyle(
                    fontSize: 70,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Gotu'
                  ),),
                  SizedBox(height: 20,),
                  Text("Calls made Easier" , style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    fontStyle: FontStyle.italic,
                    fontFamily: 'Gotu'
                  ),),
                  SizedBox(height: 200,),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: InkWell(
                      onTap: (){

                        setState(() {
                          isloading = true;
                        });

                        googleSignin();

                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          gradient:LinearGradient(colors: [Colors.pink[800], Colors.pink[300]],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        ),),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0) ,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text('Signin with google', style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white
                              ),),
                              SizedBox(width: 20,),
                              Icon(Icons.arrow_forward_ios, color: Colors.white ,),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )

                ],
              ),
            ),
          ),
      ),


    );
  }
  void googleSignin(){

   _repo.signinWithGoogle().then((FirebaseUser user){
     if(user!= null){
       checkUser(user);

     }
     else{
       print("no user");
     }
   });

  }
  void checkUser(FirebaseUser user){

    FirebaseMethods().checkUser(user).then((isnew){

      if(isnew){
        _repo.addToDb(user).then((value){

          Navigator.pushReplacement(context, MaterialPageRoute(builder:(context){
            return HomeScreen();
          }));
        });

        setState(() {
          isloading = false;

        });


      }
      else{
        Navigator.pushReplacement(context, MaterialPageRoute(builder:(context){
          return HomeScreen();
        }));

      }
    });



  }
}

