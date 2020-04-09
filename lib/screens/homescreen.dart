import 'package:flutter/material.dart';
import 'package:koona/screens/pageviews/chats.dart';
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PageController _pageController;
  int currentpage = 0;

  @override
  void initState() {
    _pageController = PageController(initialPage:currentpage, keepPage: false);
  }
  void onpageChanged(int page){
    setState(() {
      currentpage = page;
    });
  }

  @override
  Widget build(BuildContext context) {

    _pageController = PageController(initialPage:currentpage, keepPage: false);

    return Scaffold(
      backgroundColor: Colors.white,
      body: PageView(
        children: <Widget>[
          Container(child: Chats(),),
          Center(child: Text("log"),),
          Center(child: Text("contacts"),),

        ],
        controller: _pageController,
        onPageChanged: onpageChanged,
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        margin: EdgeInsets.only(top: 10),
        padding: EdgeInsets.only(top: 10,bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            currentpage == 0 ? _selected(Icons.chat, 'Chats') : IconButton(
              icon: Icon(Icons.chat, color: Colors.green,), onPressed: () {
              setState(() {
                currentpage = 0;
              });
              _pageController.jumpToPage(0);
            },),
            currentpage == 1
                ? _selected(Icons.call, 'Call Log')
                : IconButton(icon: Icon(Icons.call, color: Colors.green),
              onPressed: () {
                setState(() {
                  currentpage = 1;
                });
                _pageController.jumpToPage(1);
              },),
            currentpage == 2
                ? _selected(Icons.contacts, 'Contacts')
                : IconButton(
              icon: Icon(Icons.contacts, color: Colors.green), onPressed: () {
              setState(() {
                currentpage = 3;
              });
              _pageController.jumpToPage(3);
            },),

          ],
        ),
      ),
    );

  }
}
Widget _selected(icon,String string) {
  return Container(
    padding: EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 5),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          bottomRight: Radius.circular(20.0),
          bottomLeft: Radius.circular(20.0),
        ),
        color: Colors.green

    ),
    child: Row(
      children: <Widget>[
        Icon(icon, color: Colors.white,),
        SizedBox(width: 4,),
        Text(string, style: TextStyle(color: Colors.white),)
      ],
    ),
  );
}
