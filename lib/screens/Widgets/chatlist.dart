import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:koona/models/user.dart';
import 'package:provider/provider.dart';

import 'chatitem.dart';

class ChatList extends StatefulWidget {
  final User reciever;

  ChatList({this.reciever});

  @override
  _ChatListState createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    return StreamBuilder(
      stream: Firestore.instance.collection('messages').document(user.uid).collection(widget.reciever.uid).orderBy('timestamp',descending:true).snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
         if(snapshot == null){
           return Center(
             child:  SpinKitRing(
               color: Colors.red,
               size: 90.0,

             ),
           );
         }
         return ListView.builder(
           reverse: true,
           shrinkWrap: true,
             itemCount: snapshot.data.documents.length,itemBuilder:(context, index){
               return ChatItem(snapshot.data.documents[index]);
         });
      },

    );
  }
}
