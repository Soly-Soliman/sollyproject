import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_1/block/massages/statesocial.dart';
import 'package:graduation_1/models/Massage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../../models/user.dart';

class SocialCubit extends Cubit<SocialState>

{
  String uId = "" ;
  SocialCubit() : super(SocialInitialState());
  static SocialCubit get(context) => BlocProvider.of(context);
  User ?model;
  void getUser(){
    emit(SocialLoadingStateGet());
    FirebaseFirestore.instance.collection('Users').doc("uid").get().then((value) {
      Map<String, dynamic>?name = value.data();
      model = User.fromjson(name!);
      print(value.data());
      emit(SocialGetUserSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(SocialGetUserErrorState(error.toString()));
    });

  }
  int currentIndex = 0;

  File ?profileimage;

  String profileUrl ='';
  Future getprofileimage(ImageSource imageSource)async {
    var pickerfile = await ImagePicker().pickImage(source: imageSource);
    if(pickerfile !=null){
      profileimage = File(pickerfile.path);
      emit(changeCoverImagesuccess());
    }
    else{
      emit(changeCoverImageerror());
    }
  }
  /////////////////////////////////////////////
  void uploadImage({
    required String name,
    required String phone,
    required String bio
  }){
    emit(loadingimage());
    firebase_storage.FirebaseStorage.instance.
    ref().
    child('Users/${Uri.file(profileimage!.path).pathSegments.last}').putFile(profileimage!).then((value) {
      value.ref.getDownloadURL()
          .then((value) {
        //emit(UploadImagesusses());
        print(value);
        updateUser(name: name, phone: phone, bio: bio,image: value);
      }).catchError((error){
        emit(UploadImageerror());
      });

    }).catchError((error){});
    emit(UploadImageerror());

  } // Function Upload Image

  void updateUser({
    required String name,
    required String phone,
    required String bio,
    String? cover,
    String? image
  }){
    User Usermodel = User(
      username: name,
      phone: phone,
      uid: model!.uid,

      bio: bio,

      photoUrl: image??model!.photoUrl,
      email: model!.email, following: [],  followers: [],
    );
    FirebaseFirestore.instance.collection('Users').doc(model!.uid).update(Usermodel.toJason()).
    then((value) {
      getUser();
    }).catchError((error){
      emit(updateusererror());
    });
  }
  //FUnction UpdateUser
///////////////////////////////
  File? postimage;
  Future getPostImage(ImageSource imageSource)async {
    var pickerfile = await ImagePicker().pickImage(source: imageSource);
    if(pickerfile !=null){
      postimage = File(pickerfile.path);
      emit(SocialGetImagePickerSuccess());
    }
    else{
      emit(SocialGetImagePickerError());
    }
  }

  List<User>users = [];
  void getAllUsers(){
    if (users.isEmpty) {
      FirebaseFirestore.instance
          .collection('Users')
          .get()
          .then((value) {

        for (var element in value.docs) {
          users.add(User.fromjson(element.data()));
        }
        emit(SocialGetAllUsersSuccess());
        print(users.length) ;
      }).catchError((error) {
        emit(SocialGetAllUsersError(error.toString()));
        print(error.toString()) ;
      });
    }

  }
  //Function get users
  //////////////////////////////////////////
  void sendMessage({
    required String receiverId,
    required String dataTime,
    required String text
  }){
    MessageModel messageModel = MessageModel(
        text: text,
        datatime: dataTime,
        recevierId: receiverId,
        senderId: model!.uid
    );
    FirebaseFirestore.instance.collection('Users')
        .doc(model!.uid)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .add(messageModel.tomap()).then((value) {
      emit(SocialSendMessageSuccess());
    }).catchError((error){
      emit(SocialSendMessageError(error.toString()));
    });
    FirebaseFirestore.instance.collection('Users')
        .doc(receiverId)
        .collection('chats')
        .doc(model!.uid)
        .collection('messages')
        .add(messageModel.tomap()).then((value) {
      emit(SocialSendMessageSuccess());
    }).catchError((error){
      emit(SocialSendMessageError(error.toString()));
    });
  }
// Function send message
  List<MessageModel>message = [];
  void getMessage({required String receiverId,}){
    FirebaseFirestore.instance.collection('Users')
        .doc(model!.uid)
        .collection('chats')
        .doc(receiverId)
        .collection('messages').orderBy('datatime')
        .snapshots()
        .listen((event) {
      message=[];
      event.docs.forEach((element) {
        message.add(MessageModel.fromjson(element.data()));
      });
      emit(SocialGetMessageSuccess());

    });
  }
// function get nessage


}