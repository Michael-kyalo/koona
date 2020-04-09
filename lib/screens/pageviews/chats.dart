import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:koona/models/user.dart';
import 'package:koona/res/firebase_repo.dart';
import 'package:koona/screens/chatScreen.dart';
import 'package:koona/utils/utils.dart';
import 'package:koona/widgets/custom_list_tile.dart';
import 'package:provider/provider.dart';
class Chats extends StatefulWidget {
  @override
  _ChatsState createState() => _ChatsState();
}


class _ChatsState extends State<Chats> {
  String uid;
  String code;
  FirebaseRepo _repo = FirebaseRepo();

  List<User> userlist;
  List<User> suggestionList;
  String query="";
  TextEditingController textEditingController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    textEditingController = TextEditingController();
    suggestionList = List<User>();

    
    _repo.getCurrentUser().then((FirebaseUser firebaseUser){
      _repo.fetchAllUsers(firebaseUser).then((List<User> list){
        setState(() {
          userlist = list;
        });

      });
    });

  }

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);
    var height = MediaQuery.of(context).size.height;

    //print(user.name);

    code = Utils.getCode(user.name);
    textEditingController = TextEditingController();

    uid = user.uid;

    void buildSuggestions(String query) {
      print(userlist.length);
      print(userlist[0]);
      suggestionList = query.isEmpty ? [] :
      userlist.where((User user){
        // print(user.name);
        String _getUsername = user.username.toLowerCase();
        print(_getUsername);
        String _getName = user.name.toLowerCase();
        String _query = query.toLowerCase();
        bool matchesUsername = _getUsername.contains(_query);
        bool matchesName = _getName.contains(_query);

        return (matchesName||matchesUsername);

      }).toList();
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: <Widget>[
              Container(
                child: Padding(
                  padding: const EdgeInsets.all(30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                     Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: <Widget>[
                         Stack(
                           children: <Widget>[
                             Container(
                               child: Text(code, style: TextStyle(
                                   fontSize: 15,
                                   fontFamily: 'Gotu',
                                   fontWeight: FontWeight.bold,
                                 color: Colors.white
                               ),),
                               padding: EdgeInsets.all(20),
                               decoration: BoxDecoration(
                                   shape: BoxShape.circle,
                                   color: Colors.green
                               ),),
                             Positioned(
                                 top: 45,
                                 left: 55
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


                         Icon(Icons.notifications, color: Colors.green,),
                       ],

                     ),
                      SizedBox(height: 20,),
                      Row(
                        children: <Widget>[
                          Expanded(child:Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(topLeft:Radius.circular(20),bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20) ),
                              color: Colors.white,
                              border: Border.all(
                                color: Colors.green,
                                width: 2
                              )
                            ),
                           child: TextFormField(

                             onChanged: (val){
                               setState(() {
                                 query = val;
                               });
                             },
                            // controller: textEditingController,
                             cursorColor: Colors.green,
                             decoration: InputDecoration(
                               suffixIcon: InkWell(
                                 onTap:(){
                                   suggestionList.clear();
                                 },
                                 child: Container(
                                   decoration: BoxDecoration(
                                     shape: BoxShape.circle,
                                     border: Border.all(
                                       width: 1,
                                       color: Colors.red
                                     )
                                   ),
                                   child: IconButton(icon: Icon(Icons.close, color: Colors.red,), onPressed:(){
                                     setState(() {
                                       suggestionList.clear();
                                     });


                                      //WidgetsBinding.instance.addPostFrameCallback((_)=> textEditingController.clear());
                                    }),
                                 ),
                               ),
                              prefixIcon: InkWell(
                                onTap:(){
                                  setState(() {
                                    buildSuggestions(query);
                                  });

                                },

                                child: Container(
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          width: 1,
                                          color: Colors.white,
                                      )
                                  ),
                                  child: IconButton(icon: Icon(Icons.search, color: Colors.green,), onPressed:(){
                                    setState(() {
                                      buildSuggestions(query);
                                    });

                                    }),
                                ),
                              ),
                               hintText: 'search',
                                hintStyle: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                ),
                                border: InputBorder.none

                             ),
                           )
                          ))
                        ],
                      ),
                      SizedBox(
                        height: height* 0.6,
                        child: suggestionList.isEmpty ? ListView.builder(
                            padding: EdgeInsets.all(8),
                            itemCount: 25,
                            itemBuilder: (context, index){
                              return CustomListtile(
                                size: false,
                                onTap: (){},
                                title: Text('mikonski', style: TextStyle(
                                    color: Colors.black87,
                                    fontFamily: 'Gotu',
                                    fontSize: 19
                                ),),
                                subtitle: Text('I got the last...', style: TextStyle(
                                    color: Colors.black38,
                                    fontFamily: 'Gotu',
                                    fontSize: 14
                                ),),
                                leading: Container(
                                  constraints: BoxConstraints(
                                    maxWidth: 60,
                                    maxHeight: 60,
                                  ),
                                  child:  Stack(
                                    children: <Widget>[
                                      CircleAvatar(
                                        maxRadius: 30,
                                        backgroundColor: Colors.lightGreen,
                                        backgroundImage: NetworkImage(user.displayPic),
                                      ),
                                      Positioned(
                                          top: 40,
                                          left: 50
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
                              );
                            }): ListView.builder(
                          itemCount: suggestionList.length,
                          itemBuilder: (context, index){
                              User searchedUser = User(
                                username: suggestionList[index].username,
                                name: suggestionList[index].name,
                                uid: suggestionList[index].uid,
                                displayPic: suggestionList[index].displayPic,

                              );
                              return CustomListtile(
                                size: false,
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder:(context)=>ChatScreen(
                                    reciever: suggestionList?.elementAt(index),
                                    name: suggestionList?.elementAt(index)?.name,
                                  )));
                                },
                                leading: CircleAvatar(
                                  backgroundImage: NetworkImage(searchedUser.displayPic),
                                  backgroundColor: Colors.green,
                                ),
                                title: Text(
                                  searchedUser.username,
                                  style: TextStyle(
                                      color: Colors.black87,
                                      fontFamily: 'Gotu',
                                      fontSize: 19
                                  ),
                                ),
                                subtitle: Text(
                                  searchedUser.name,
                                  style: TextStyle(
                                      color: Colors.black38,
                                      fontFamily: 'Gotu',
                                      fontSize: 14

                                  ),
                                ),
                              );
                        },
                        ),
                      )

                    ],
                  ),

                ),

              ),

            ],

          ),
        ),
      ),

    );
  }


}
