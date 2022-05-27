
import 'package:cloud_firestore/cloud_firestore.dart';

class Event{
  final String name;
  final String description;
  final String username;
  final String uid;
  final String EventID;
  final  dataPublished;
  final String time;
  final String date;
  final String EventUrl ;
  final  String profileImageUrl;
  //GPS LOCATION
  final  likes;
  final  follower;
  final String place ;

  const Event({
    required this.name,
    required this.place,
    required this.likes ,
    required this.username,
    required this.uid,
    required this.dataPublished,
    required this.time,
    required this.date,
    required this.description,
    required this.EventID,
    required this.EventUrl,
    required this.profileImageUrl,
    required this.follower,
    //GPS LOCATION

  });
  Map<String , dynamic>toJason() =>{
    'name' :name,
    'place' :place,
    'username' :username,
    'uid'   :uid,
    'dataPublished':dataPublished,
    'time':time,
    'date':date,
    'description' :description ,
    'likes':likes ,
    'followers':follower ,
    'EventID' :EventID,
    'EventUrl':EventUrl,
    'profileUrl':profileImageUrl,

  } ;


  static Event fromSnap(DocumentSnapshot snap){
    var snapshot = snap.data()  as Map < String ,dynamic> ;
    return Event(
        name: snapshot['name'],
        place: snapshot['place'],
        description: snapshot['description'],
        username: snapshot['username'],
        uid: snapshot['uid'],
        EventID: snapshot['EventID'],
        dataPublished: snapshot['dataPublished'],
        time: snapshot['time'],
        date: snapshot['date'],
        profileImageUrl: snapshot['profileImageUrl'],
        EventUrl: snapshot['EventUrl'],
        likes: snapshot['Likes'],
        follower: snapshot['followers']

    ) ;

  }

}