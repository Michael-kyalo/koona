import 'package:flutter/material.dart';
import 'package:koona/res/firebase_repo.dart';
import 'package:koona/screens/homescreen.dart';
import 'package:koona/screens/loginScreen.dart';
import 'package:provider/provider.dart';

import 'models/user.dart';
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);
    print(user);

    if(user== null){
      return LoginScreen();
    }
    else{
    return HomeScreen();}
  }
}
