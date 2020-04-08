import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class CustomListtile extends StatelessWidget {
  final Widget leading;
  final Widget title;
  final Widget icon;
  final Widget subtitle;
  final Widget trailing;
  final EdgeInsets margin;
  final bool size;
  final GestureTapCallback onTap;
  final GestureLongPressCallback onLongPress;


  CustomListtile({
    @required this.leading,
    @required this.title,
    this.icon,
    @required this.subtitle,
    this.trailing,
    this.margin = const EdgeInsets.all(0),
    this.size = true,
    this.onTap,
    this.onLongPress});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,

      child: Container(
        padding: EdgeInsets.symmetric(horizontal: size ? 10 : 0),
        margin: margin,
        child: Row(
          children: <Widget>[
            leading,
            Expanded(child:Container(
              margin: EdgeInsets.only(left: size ? 10 : 15 ),
              padding: EdgeInsets.symmetric(vertical: size ? 3 : 20),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.green,
                    width: 0.5,

                  )
                )
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      title,
                      SizedBox(height: 10,),
                      Row(
                        children: <Widget>[
                          icon?? Container(),
                          subtitle
                        ],

                      )
                    ],
                  ),
                  trailing ?? Container()
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
