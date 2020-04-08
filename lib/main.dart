import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:koona/res/firebase_methods.dart';
import 'package:koona/screens/searchscreen.dart';
import 'package:provider/provider.dart';

import 'home.dart';
import 'models/user.dart';

void main() => runApp(Myapp());


class Myapp extends StatefulWidget {
  @override
  _MyappState createState() => _MyappState();
}

class _MyappState extends State<Myapp> {
  @override
  Widget build(BuildContext context) {

    return StreamProvider<User>.value(

      value: FirebaseMethods().user,
      child: MaterialApp(
      
        debugShowCheckedModeBanner: false,
        home: Home(),
      ),
    );
  }
}





