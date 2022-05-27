
import 'package:cloud_firestore/cloud_firestore.dart';

class Comment{
  final  String profileImageUrl;
  final String username;
  final String uid;
  final  dataPublished;
  final String description;
  final String CommentID ;



  const Comment({
    required this.profileImageUrl,
    required this.username,
    required this.uid,
    required this.dataPublished,
    required this.description,
    required this.CommentID ,

    //GPS LOCATION

  });
  Map<String , dynamic>toJason() =>{
    'profileUrl':profileImageUrl,
    'username' :username,
    'uid'   :uid,
    'dataPublished':dataPublished,
    'description' :description ,
    'CommentID'   : CommentID ,

  } ;


  static Comment fromSnap(DocumentSnapshot snap){
    var snapshot = snap.data()  as Map < String ,dynamic> ;
    return Comment(
      profileImageUrl: snapshot['profileImageUrl'],
      username: snapshot['username'],
      uid: snapshot['uid'],
      dataPublished: snapshot['dataPublished'],
      description: snapshot['description'],
      CommentID: snapshot['CommentID'],


    ) ;

  }

}