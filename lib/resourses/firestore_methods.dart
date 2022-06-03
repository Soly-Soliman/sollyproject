
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:graduation_1/models/Post.dart';
import 'package:graduation_1/models/comment.dart';
import 'package:graduation_1/models/event.dart';
import 'package:graduation_1/resourses/storage_methods.dart';
import 'package:uuid/uuid.dart';

import '../models/Massage.dart';

class FireStoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //upload post
  Future<String> uploadPost(
    String description,
    Uint8List file,
    String uid,
    String username,
    String profileImageUrl,

  ) async {
    String res = ' some error occurred';

    try {
      String PhotoUrl =  await StorageMethods().uploadImagetoStorage('posts', file, true);
      String postID = const Uuid().v1();
      Post post = Post(
          likes: [],
          username: username,
          uid: uid,
          dataPublished: DateTime.now(),
          description: description,
          PostID: postID,
          PostUrl: PhotoUrl,
          profileImageUrl: profileImageUrl);
      _firestore.collection('posts').doc(postID).set(
            post.toJason(),
          );
      res ='success' ;
    } catch (error) {
      res =error.toString();
    }
    return res ;

  }

  Future<String> uploadevent(
      String description,
      String name,
      String place,
      String date,
      String time,
      Uint8List file,
      String uid,
      String username,
      String profileImageUrl,

      ) async {
    String res = ' some error occurred';

    try {
      String PhotoUrl =  await StorageMethods().uploadImagetoStorage('events', file, true);
      String EventID = const Uuid().v1();
      Event event = Event(
          likes: [],
          follower: [],
          username: username,
          uid: uid,
          dataPublished: DateTime.now(),
          description: description,
          EventID: EventID,
          EventUrl: PhotoUrl,
          profileImageUrl: profileImageUrl,
          time: time,
          name:name,
          date: date ,place:place );
      _firestore.collection('events').doc(EventID).set(
        event.toJason(),
      );
      res ='success' ;
    } catch (error) {
      res =error.toString();
    }
    return res ;

  }
  Future <void> likedPost(String postId, String uid,List likes) async{

try{
  if(likes.contains(uid)){
   await _firestore.collection('posts').doc(postId).update(
      {
        'likes' : FieldValue.arrayRemove([uid]),
      }
    );
  }else{
    await _firestore.collection('posts').doc(postId).update(
        {
          'likes' : FieldValue.arrayUnion([uid]),
        }
    );
  }


}catch(e){
  print(e.toString()) ;
}
  }

  Future <void> likedEvent(String eventId, String uid,List likes) async{

    try{
      if(likes.contains(uid)){
        await _firestore.collection('events').doc(eventId).update(
            {
              'likes' : FieldValue.arrayRemove([uid]),
            }
        );
      }else{
        await _firestore.collection('events').doc(eventId).update(
            {
              'likes' : FieldValue.arrayUnion([uid]),
            }
        );
      }


    }catch(e){
      print(e.toString()) ;
    }
  }


  Future<void> postcomment( String PostID,String text,String uid,String name ,String ProfilePicture ,) async{
    try{

      String commentID =const Uuid().v1();
      Comment comment = Comment(
          username: name,
          uid: uid,
          dataPublished: DateTime.now(),
          description: text,
          CommentID: commentID,
          profileImageUrl: ProfilePicture
      );
             if(text.isNotEmpty){
               await _firestore.collection('posts').doc(PostID).collection('comments').doc(commentID).set(

                 comment.toJason(),

               );
             }
             else{
               print('Text is empty') ;
             }
    }catch(e){
       print (e.toString()) ;
    }
  }
  
  
  
  Future<void> SendMassage( String text,String uid,String Reciverid ,  String profileImageUrl  ) async{
    try{

      String MassageID =const Uuid().v1();
      MessageModel messageModel = MessageModel(


        datatime: DateTime.now(),
        recevierId:Reciverid ,
        senderId: uid,
        text: text,
        MassageID: MassageID, profileImageUrl:profileImageUrl,
      
        
      );
      if(text.isNotEmpty){
 await _firestore..collection('Users').doc(uid) .collection('chats')
     .doc(Reciverid).collection('Massages').doc(MassageID).set(
      //  await _firestore.collection('Massages').doc(MassageID).set(
          messageModel.tomap(),
        );
 await _firestore..collection('Users').doc(Reciverid) .collection('chats')
     .doc(uid).collection('Massages').doc(MassageID).set(
   //  await _firestore.collection('Massages').doc(MassageID).set(
   messageModel.tomap(),
 );

      }
      else{
        print('Text is empty') ;
      }
    }catch(e){
      print (e.toString()) ;
    }
  }
  Future<void> eventcomment( String eventID,String text,String uid,String name ,String ProfilePicture ,) async{
    try{

      String commentID =const Uuid().v1();
      Comment comment = Comment(
          username: name,
          uid: uid,
          dataPublished: DateTime.now(),
          description: text,
          CommentID: commentID,
          profileImageUrl: ProfilePicture
      );
      if(text.isNotEmpty){
        await _firestore.collection('events').doc(eventID).collection('comments').doc(commentID).set(

          comment.toJason(),

        );
      }
      else{
        print('Text is empty') ;
      }
    }catch(e){
      print (e.toString()) ;
    }
  }

  Future<void> deletepost(String PostID) async{
    try{
        await _firestore.collection('posts').doc(PostID).delete();
    }catch(error){
      print(error.toString());

    }
  }
  Future<void> deleteMassage(String uid , String ReciverID ,String MassageID) async{
    try{
      _firestore..collection('Users').doc(uid) .collection('chats')
          .doc(ReciverID).collection('Massages').doc(MassageID).delete() ;

      await _firestore..collection('Users').doc(ReciverID) .collection('chats')
          .doc(uid).collection('Massages').doc(MassageID).delete() ;


    }catch(error){
      print(error.toString());

    }
  }
  Future<void> deleteevent(String eventID) async{
    try{
      await _firestore.collection('events').doc(eventID).delete();
    }catch(error){
      print(error.toString());

    }
  }

  Future<void> followuser(
      String UserID ,
      String followID ,
      )async{
    try{
     DocumentSnapshot  snapshot = await _firestore.collection('Users').doc(UserID).get();
      List following =( snapshot.data()! as dynamic)['following'] ;
      if(following.contains(followID)){
        await _firestore.collection('Users').doc(followID).update({
          'followers':FieldValue.arrayRemove([UserID])
        }) ;
        await _firestore.collection('Users').doc(UserID).update({
          'following':FieldValue.arrayRemove([followID])
        }) ;

      }
      else{

        await _firestore.collection('Users').doc(followID).update({
          'followers':FieldValue.arrayUnion([UserID])
        }) ;
        await _firestore.collection('Users').doc(UserID).update({
          'following':FieldValue.arrayUnion([followID])
        }) ;
      }
    }catch(e){
      print(e.toString());
    }

  }

  Future<void> followevent(
      String eventID ,
      String followID ,
      )async{
    try{
      DocumentSnapshot  snapshot = await _firestore.collection('events').doc(eventID).get();
      List following =( snapshot.data()! as dynamic)['following'] ;
      if(following.contains(followID)){
        await _firestore.collection('events').doc(followID).update({
          'followers':FieldValue.arrayRemove([eventID])
        }) ;
        await _firestore.collection('events').doc(eventID).update({
          'following':FieldValue.arrayRemove([followID])
        }) ;

      }
      else{

        await _firestore.collection('events').doc(followID).update({
          'followers':FieldValue.arrayUnion([eventID])
        }) ;
        await _firestore.collection('events').doc(eventID).update({
          'following':FieldValue.arrayUnion([followID])
        }) ;
      }
    }catch(e){
      print(e.toString());
    }

  }
}
