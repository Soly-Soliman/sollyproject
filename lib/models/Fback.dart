
import 'package:cloud_firestore/cloud_firestore.dart';

class fbmodel{
  final String name;
  final String description;
  final String description2;
  final String username;
  final String uid;
  final String fdID;
  final  dataPublished;


  final  String profileImageUrl;


  const fbmodel({
    required this.name,
    required this.username,
    required this.uid,
    required this.dataPublished,
    required this.description,
    required this.description2,
    required this.fdID,
    required this.profileImageUrl,
  });
  Map<String , dynamic>toJason() =>{
    'name' :name,
    'username' :username,
    'uid'   :uid,
    'fdID'   :fdID,
    'description' :description ,
    'description2' :description2,
    'dataPublished' :dataPublished ,
    'profileUrl':profileImageUrl,


  } ;


  static fbmodel fromSnap(DocumentSnapshot snap){
    var snapshot = snap.data()  as Map < String ,dynamic> ;
    return fbmodel(
        name: snapshot['name'],
        description: snapshot['description'],
        description2: snapshot['description2'],
        username: snapshot['username'],
        uid: snapshot['uid'],
        dataPublished: snapshot['dataPublished'],
        profileImageUrl: snapshot['profileImageUrl'],
        fdID:snapshot['fdID'] ,


    ) ;

  }

}