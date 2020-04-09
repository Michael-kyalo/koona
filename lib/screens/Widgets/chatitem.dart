import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:koona/models/user.dart';
import 'package:koona/screens/Widgets/receiver.dart';
import 'package:koona/screens/Widgets/sender.dart';
import 'package:provider/provider.dart';

class ChatItem extends StatefulWidget {
  DocumentSnapshot snapshot;


  ChatItem(this.snapshot);

  @override
  _ChatItemState createState() => _ChatItemState();
}

class _ChatItemState extends State<ChatItem> {
  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15),
      child: Container(
        alignment: widget.snapshot['senderId'] == user.uid ? Alignment.centerRight: Alignment.centerLeft,
        child: widget.snapshot['senderId'] == user.uid ?  senderSide(widget.snapshot) : recieverSide(widget.snapshot),
      ),
    );
  }
}
