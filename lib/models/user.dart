
import 'package:cloud_firestore/cloud_firestore.dart';

class User{
  late  String email ;
  late   String username;
  late  String uid;
  late    String photoUrl;
  late  String bio;
  late   String phone;
  late  List followers ;
  late List following ;

   User({
    required this.email,
    required this.uid,
    required this.photoUrl ,
    required this.username,
    required this.phone,
    required this.bio,
    required this.followers ,
    required this.following,

      });
    User.fromjson(Map<String,dynamic>json ){
    email = json['email'];
    username = json['username'];
    phone = json['phone'];
    uid = json['uid'];
    photoUrl = json['photoUrl'];
    bio = json['bio'];
    followers = json['followers'];
    following = json['following'];

  }
  Map<String , dynamic>toJason() {
    return{
      'username' :username,
      'uid'   :uid,
      'email' :email ,
      'bio':bio,
      'photoUrl' :photoUrl ,
      'phone' : phone ,
      'followers' :followers,
      'following' :following ,
    } ;
  }
  static User fromSnap(DocumentSnapshot snap){
    var snapshot = snap.data()  as Map < String ,dynamic> ;
    return User(
        email: snapshot['email'],
        uid: snapshot['uid'],
        photoUrl: snapshot['photoUrl'],
        username: snapshot['username'],
        phone: snapshot['phone'],
        bio: snapshot['bio'],
        followers: snapshot['followers'],
        following: snapshot['following'],
    ) ;

  }


}