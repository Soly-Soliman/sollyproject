import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:graduation_1/models/user.dart' as model ;
import 'package:graduation_1/resourses/storage_methods.dart';

class AuthMethod {
  final FirebaseAuth _auth =FirebaseAuth.instance;
  final FirebaseFirestore _firestore =FirebaseFirestore.instance ;


  Future<model.User> getUserDetails() async{
    User currentUser = _auth.currentUser! ;
    DocumentSnapshot snap =await _firestore.collection('Users').doc(currentUser.uid).get();

    return
              model.User.fromSnap(snap) ;

  }

  // function for sign up for th user
  Future<String> signUpUser({
    required String email ,
    required String  password ,
    required String username,
     required String bio ,
    required Uint8List file ,
     required String phone_number ,

   }) async {
      String res = "Some error occurred" ;
      try{
          if(email.isNotEmpty ||
              password.isNotEmpty ||
              username.isNotEmpty ||
              bio.isNotEmpty ||
               file != null ||
              phone_number.isNotEmpty
             ) {
     UserCredential  cred =  await   _auth.createUserWithEmailAndPassword(email: email, password: password) ;
     // add user to our data base
       print(cred.user!.uid);
       // استدعاؤ داله تخزين الصور ف فايل الصور الشخصيه
      String photoUrl = await StorageMethods().uploadImagetoStorage('ProfilePicture', file, false) ;

      // من صفحه ال model باخد منها object وبعدين اباصي ليها الinputs   دي بدال مكل شويه اكتبها
      model.User user= model.User (
       username: username ,
        email:  email ,
        uid: cred.user!.uid,
        photoUrl: photoUrl,
        phone: phone_number,
        bio: bio,
        followers: [],
        following: [],
      ) ;


         //add new user to the database
           await _firestore.collection('Users').doc(cred.user!.uid ).set(user.toJason(),);


           res = 'success' ;
          }
      }

      // هنا هنحط اشارات تحذيريه بقي عشاان الانفاليد ايميل او باسورد

      catch(error){
        res =error.toString() ;
      }
      return res ;
  }

/////////////////////////////////////////////////////////////////////////////////////////////////////////////
  // function for loging in the user
  Future<String> loginUser({
    required String email ,
    required String password ,

  }) async{
    String res ='Some Error occurred' ;
    try
    {
      if(email.isNotEmpty ||password.isNotEmpty){
       await  _auth.signInWithEmailAndPassword(email: email, password: password) ;
       res='success' ;
      } else {
        res ='please enter all fields ' ;
      }
    }  on FirebaseAuthException catch(ex){
      if(ex.code =='user-not-found' ||ex.code=='Wrong-Password'){

      }
    }
    catch (error)
    {
       res =error.toString() ;
    }
    return res ;
  }


  Future<void> SignOut() async{
     await _auth.signOut();
  }
}

