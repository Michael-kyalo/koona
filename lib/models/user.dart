

class User {
  String uid;
  String email;
  String displayPic;
  String status;
  int state;
  String name;
  String username;

  User({this.uid ,this.email, this.displayPic, this.name, this.state, this.status, this.username});

  Map toMap(User user) {
    var mapdata = Map<String, dynamic>();
    mapdata['uid'] = user.uid;
    mapdata['email'] = user.email;
    mapdata['displayPic'] = user.displayPic;
    mapdata['status'] = user.status;
    mapdata['name'] = user.name;
    mapdata['username'] = user.username;
    mapdata['state'] = user.state;

    return mapdata;
  }

  User.fromMap(Map<String, dynamic> map){
    this.uid = map['uid'];
    this.state = map['state'];
    this.username = map['username'];
    this.email = map['email'];
    this.displayPic = map['displayPic'];
    this.name = map['name'];
    this.status = map['status'];
  }
}