import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
// ignore: camel_case_types
class Loading extends StatefulWidget {
  @override
  _loadingState createState() => _loadingState();
}

// ignore: camel_case_types
class _loadingState extends State<Loading> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: Container(

        child: Center(
          child: Padding(padding:EdgeInsets.all(8.0),
          child:  Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SpinKitRing(
                color: Colors.white,
                size: 90.0,

              ),
              SizedBox(height: 30.0,),
              Text(
                'loading',
                style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.grey[100],
                    fontFamily: 'Gotu'
                ),
              )
            ],
          ),

          ),
        ),
      ),
    );
  }
}
