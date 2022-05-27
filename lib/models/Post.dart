
import 'package:cloud_firestore/cloud_firestore.dart';

class Post{
  final String description;
  final String username;
  final String uid;
  final String PostID;
  final  dataPublished;
  final String PostUrl ;
  final  String profileImageUrl;
  //GPS LOCATION
  final  likes;

  const Post({
    required this.likes ,
    required this.username,
    required this.uid,
    required this.dataPublished,
    required this.description,
    required this.PostID,
    required this.PostUrl,
    required this.profileImageUrl,
    //GPS LOCATION

  });
  Map<String , dynamic>toJason() =>{
    'username' :username,
    'uid'   :uid,
     'dataPublished':dataPublished,
    'description' :description ,
    'likes':likes ,
    'PostID' :PostID,
    'PostUrl':PostUrl,
    'profileUrl':profileImageUrl,

  } ;


  static Post fromSnap(DocumentSnapshot snap){
    var snapshot = snap.data()  as Map < String ,dynamic> ;
    return Post(
      description: snapshot['description'],
      username: snapshot['username'],
      uid: snapshot['uid'],
      PostID: snapshot['PostID'],
      dataPublished: snapshot['dataPublished'],
      profileImageUrl: snapshot['profileImageUrl'],
      PostUrl: snapshot['PostUrl'],
      likes: snapshot['Likes']


    ) ;

  }

}