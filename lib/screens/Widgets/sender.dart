import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class senderSide extends StatefulWidget {
  DocumentSnapshot snapshot;

  senderSide(this.snapshot);

  @override
  _senderSideState createState() => _senderSideState();
}

class _senderSideState extends State<senderSide> {
  Radius circleRadius = Radius.circular(10);
  @override
  Widget build(BuildContext context) {

    return Container(
      padding: EdgeInsets.only(top: 10),
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width*0.65,


      ),
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.only(
          topLeft: circleRadius,
          topRight: circleRadius,
          bottomLeft: circleRadius
        )
      ),
      child: Padding(padding: EdgeInsets.all(10),
      child: getMessage(widget.snapshot)),
    );
  }
  getMessage(DocumentSnapshot snapshot){
    return Text(
      snapshot['message'],
        style: TextStyle(fontSize: 14,
            color: Colors.white,
            fontFamily: 'Gotu'),


    );
  }
}
