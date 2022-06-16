
import 'package:cloud_firestore/cloud_firestore.dart';

class Hobby{
  final String name;
  final String description;
  final String username;
  final String uid;
  final String HobbyID;
  final  dataPublished;
  final String time;
  final String date;
  final String Age;
  final String HobbyUrl ;
  final  String profileImageUrl;
  final  likes;
  final  follower;
  final String place ;

  const Hobby({
    required this.name,
    required this.place,
    required this.likes ,
    required this.username,
    required this.uid,
    required this.dataPublished,
    required this.time,
    required this.date,
    required this.description,
    required this.Age,
    required this.HobbyID,
    required this.HobbyUrl ,
    required this.profileImageUrl,
    required this.follower,


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
    'HobbyID' :HobbyID,
    'HobbyUrl':HobbyUrl,
    'profileUrl':profileImageUrl,
    'age':Age,

  } ;


  static Hobby fromSnap(DocumentSnapshot snap){
    var snapshot = snap.data()  as Map < String ,dynamic> ;
    return Hobby(
        name: snapshot['name'],
        place: snapshot['place'],
        description: snapshot['description'],
        username: snapshot['username'],
        uid: snapshot['uid'],
        HobbyID: snapshot['HobbyID'],
        dataPublished: snapshot['dataPublished'],
        time: snapshot['time'],
        date: snapshot['date'],
        profileImageUrl: snapshot['profileImageUrl'],
        HobbyUrl: snapshot['HobbyUrl'],
        likes: snapshot['Likes'],
        follower: snapshot['followers'] ,
        Age: snapshot['Age'],

    ) ;

  }

}