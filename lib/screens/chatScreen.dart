import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:koona/models/messages.dart';
import 'package:koona/models/user.dart';
import 'package:koona/res/firebase_repo.dart';
import 'package:koona/utils/utils.dart';
import 'package:koona/widgets/custom_list_tile.dart';
import 'package:provider/provider.dart';

import 'Widgets/chatlist.dart';

class ChatScreen extends StatefulWidget {
 final User reciever;
 final String name;
  ChatScreen({this.reciever, this.name});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  bool isTyping = false;
  var text;
 
   


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(

        leading: IconButton(icon: Icon(Icons.arrow_back_ios, color: Colors.green), onPressed:(){
         Navigator.pop(context);
        }),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title:  Stack(
          children: <Widget>[
            Container(
              child: Text(Utils.getCode(widget.name), style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Gotu',
                  fontWeight: FontWeight.bold,
                  color: Colors.white
              ),),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.green
              ),),
            Positioned(
                top: 30,right: 3
                ,child: Container(

              height: 12,
              width: 12,
              decoration: BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                  border: Border.all(
                      width: 3,
                      color: Colors.white
                  )
              ),

            ))
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            Flexible(child:
                ChatList(reciever: widget.reciever)
            ),
            ChatControls(),

          ],
        ),
      )
    );
  }

  sendMessage(){
    User user = Provider.of<User>(context, listen: false);

    Message _message = Message(
        recieverId: widget.reciever.uid,
        senderId: user.uid,
        message: text,
        timestamp: FieldValue.serverTimestamp(),
        type: 'text'

    );
    setState(() {
      isTyping = false;
    });
    FirebaseRepo().addMessageToDb(_message,user,widget.reciever);
  }
  Widget ChatControls(){
    isTypingToggle(bool isTyping1){
      setState(() {
        isTyping = isTyping1;
      });
    }

    return Container(
      padding: EdgeInsets.all(10),
      child: Row(
        children: <Widget>[
          Expanded(child: TextFormField(
            style: TextStyle(
              fontFamily: 'Gotu',
              fontSize: 16,
              color: Colors.grey[900]
            ),
            onChanged: (val){
              (val.length>0&& val.trim()!= "") ? isTypingToggle(true) : isTypingToggle(false);

              if(val.length>0&& val.trim()!= ""){
                setState(() {
                  text = val;

                });
              }
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(50)),
                borderSide: BorderSide.none,
              ),

              contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
              filled: true,
              fillColor: Colors.lightGreen[100],
              prefixIcon: Icon(Icons.face,color:Colors.grey[700]),
              hintText: ("Type your message..."),
              hintStyle: TextStyle(
                color: Colors.grey[500],
              ),
              suffixIcon: isTyping ? Container(
                height: 0,
                width: 0,
              ): Container(
                child:IconButton(icon: Icon(Icons.mic, color: Colors.grey[700],), onPressed:(){}),
              )
            ),
            cursorColor: Colors.green,

          )),
          SizedBox(width: 5,),
          isTyping ? Container() : Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: Colors.green,
                shape: BoxShape.circle
            ),
            child: Icon(Icons.camera, color: Colors.white,),
          ),
          SizedBox(width: 5,),
          isTyping ? Container() : GestureDetector(
            onTap: (){
              showModalBottomSheet(context: context, elevation: 0, backgroundColor: Colors.green, builder:(context){
                return Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                      child: Row(
                        children: <Widget>[
                          Expanded(child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Extras',
                              style: TextStyle(
                                  fontFamily: 'Gotu',
                                  fontSize: 20,
                                  color: Colors.white
                              ),
                            ),
                          )),
                          FlatButton(
                            onPressed: (){
                              print('tap');
                              Navigator.maybePop(context);
                            },

                            child: Icon(Icons.close, color: Colors.red,),
                          )
                        ],
                      ) ,
                    ),
                    Flexible(child: ListView(
                      children: <Widget>[
                        modaltile(
                          title: "Media",
                          subtitlte: "Share Photos and Video",
                          icon: Icons.image,
                        ),
                        modaltile(
                          title: "File",
                          subtitlte: "Share Files",
                          icon: Icons.tab,
                        ),modaltile(
                          title: "Contact",
                          subtitlte: "Share Contacts",
                          icon: Icons.contacts,)
                      ],
                    ))
                  ],
                );
              });

            },
            child: Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.green,
                shape: BoxShape.circle
              ),
              child: Icon(Icons.add, color: Colors.white,),
            ),
          ),
          isTyping ? Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.green,
                shape: BoxShape.circle
            ),
            child: IconButton(icon: Icon(Icons.send, color: Colors.white,),onPressed: (){
              sendMessage();
            },),
          ) : Container(),
        ],
      ),
    );
  }



}
class modaltile extends StatelessWidget {
  final String title;
  final String subtitlte;
  final IconData icon;


 const modaltile({
   @required this.title,
  @required this.subtitlte,
  @required this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.symmetric(horizontal: 15),
    child: CustomListtile(
        size: false,
      leading: Container(
        margin: EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.lightGreen[100],
        ),
        padding: EdgeInsets.all(10),
        child: Icon(icon,
          color: Colors.grey[700],
        ),
      ),
      subtitle: Text(
        subtitlte, style: TextStyle(
        color: Colors.grey[700],
        fontSize: 14,
        fontFamily: 'Gotu'
      ),
      ),
      title: Text(
        title, style: TextStyle(
        fontFamily: 'Gotu',
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 18
      ),
      ),
    ),);
  }
}
