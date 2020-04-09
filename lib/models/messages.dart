import 'package:cloud_firestore/cloud_firestore.dart';

class Message{
  String senderId;
  String recieverId;
  String type;
  String message;
  FieldValue timestamp;
  String photoUrl;

  Message({this.senderId, this.recieverId, this.type, this.message,
      this.timestamp});

  Message.imageMessage({this.senderId, this.recieverId, this.type, this.message,
    this.timestamp, this.photoUrl});

  Map toMap(){
    var map = Map<String, dynamic>();
    map['senderId'] = this.senderId;
    map['recieverId'] = this.recieverId;
    map['message']= this.message;
    map['timestamp'] = this.timestamp;
    return map;
  }
  Message fromMap(Map<String, dynamic> map){
    Message _message = Message(
      senderId: map['senderId'],
      recieverId: map['recieverId'],
      message: map['message'],
      timestamp: map['timestamp'],
    );
    return _message;
  }


}