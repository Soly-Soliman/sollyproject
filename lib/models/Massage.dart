import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  late final datatime;
  late String senderId;
  late String recevierId;
  late String MassageID;
  late String text;
  late  String profileImageUrl;
  MessageModel({

    required this.datatime ,
    required this.MassageID ,
    required this.senderId,
    required this.recevierId,
    required this.text,
    required this.profileImageUrl
  });

  MessageModel.fromjson(Map<String,dynamic>json, this.datatime){
    senderId = json['senderId'];
    datatime = json['datatime'];
    recevierId = json['recevierId'];
    text = json['text'];
    MassageID = json['MassageID'];
    MassageID = json['profileImageUrl'];

  }

  Map<String,dynamic> tomap(){
    return {
      'datatime':datatime,
      'senderId':senderId,
      'recevierId':recevierId,
      'MassageID':MassageID,
      'text':text,
      'profileImageUrl':profileImageUrl
    };
  }
  static MessageModel fromSnap(DocumentSnapshot snap){
    var snapshot = snap.data()  as Map < String ,dynamic> ;
    return MessageModel(
      recevierId: snapshot['recevierId'],
        text: snapshot['text'],
      datatime: snapshot['datatime'],
      senderId: snapshot['senderId'],
      MassageID: snapshot['MassageID'],
        profileImageUrl :snapshot['profileImageUrl']


    ) ;

  }
}