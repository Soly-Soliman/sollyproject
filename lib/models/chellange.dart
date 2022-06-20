
import 'package:cloud_firestore/cloud_firestore.dart';

class SetChell{
  final String name;
  final String username;
  final String uid;
  final String CH_ID;
  final  dataPublished;
  final String time;
  final String time2;
  final String date;
  final String date2;
  final String Ch_url ;
  final  String profileImageUrl;
  //GPS LOCATION
  final  likes;
  final  follower;


  const SetChell({
    required this.name,
    required this.likes ,
    required this.username,
    required this.uid,
    required this.dataPublished,
    required this.time,
    required this.time2,
    required this.date,
    required this.date2,
    required this.CH_ID,
    required this.Ch_url,
    required this.profileImageUrl,
    required this.follower,

  });
  Map<String , dynamic>toJason() =>{
    'name' :name,
    'username' :username,
    'uid'   :uid,
    'dataPublished':dataPublished,
    'time':time,
    'time2':time2,
    'date':date,
    'date2':date2,
    'likes':likes ,
    'followers':follower ,
    'CH_ID' :CH_ID,
    'Url':Ch_url,
    'profileUrl':profileImageUrl,

  } ;


  static SetChell fromSnap(DocumentSnapshot snap){
    var snapshot = snap.data()  as Map < String ,dynamic> ;
    return SetChell(
        name: snapshot['name'],
        username: snapshot['username'],
        uid: snapshot['uid'],
        CH_ID: snapshot['CH_ID'],
        dataPublished: snapshot['dataPublished'],
        time2: snapshot['time2'],
        time: snapshot['time'],
        date: snapshot['date'],
        date2: snapshot['date2'],
        profileImageUrl: snapshot['profileImageUrl'],
        Ch_url: snapshot['Url'],
        likes: snapshot['Likes'],
        follower: snapshot['followers']

    ) ;

  }

}