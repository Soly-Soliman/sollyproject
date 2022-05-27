
import 'package:cloud_firestore/cloud_firestore.dart';

class User{
  final String email ;
  final String username;
  final String uid;
  final String photoUrl;
  final String bio;
  final String phone;
  final List followers ;
  final List following ;

  const User({
    required this.email,
    required this.uid,
    required this.photoUrl ,
    required this.username,
    required this.phone,
    required this.bio,
    required this.followers ,
    required this.following,

      });
  Map<String , dynamic>toJason() =>{
    'username' :username,
    'uid'   :uid,
    'email' :email ,
    'bio':bio,
    'photoUrl' :photoUrl ,
    'phone' : phone ,
    'followers' :followers,
    'following' :following ,


  } ;

  // we gonna build a Function to convert  document snap shot to user model
//  that function we use it  in the dart file that could auth_methods in the get user details to use it in deferant places in the app
//we will go to the data base and match the userId and then get the information to use it here with the function snapshot
  // and we get that one time so we call it snap shot like camera it take photo at once by snap shot
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