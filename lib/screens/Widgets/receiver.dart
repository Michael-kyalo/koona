import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class recieverSide extends StatefulWidget {
  DocumentSnapshot snapshot;

  recieverSide(this.snapshot);

  @override
  _recieverSideState createState() => _recieverSideState();
}

class _recieverSideState extends State<recieverSide> {
  Radius circleRadius = Radius.circular(10);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10),
      constraints: BoxConstraints(

        maxWidth: MediaQuery.of(context).size.width*0.65,

      ),
      decoration: BoxDecoration(
          color: Colors.lightGreen[100],
          borderRadius: BorderRadius.only(
              bottomRight: circleRadius,
              topRight: circleRadius,
              bottomLeft: circleRadius
          )
      ),
      child: Padding(padding: EdgeInsets.all(10),
        child: getMessage(widget.snapshot)
    ));
  }
  getMessage(DocumentSnapshot snapshot){
    return Text(
      snapshot['message'],
      style: TextStyle(fontSize: 14,
          color: Colors.grey[900],
          fontFamily: 'Gotu'
      ),
    );
  }
}
