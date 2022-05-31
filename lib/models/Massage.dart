import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  late final datatime;
  late String senderId;
  late String recevierId;
  late String MassageID;
  late String text;

  MessageModel({

    required this.datatime ,
    required this.MassageID ,
    required this.senderId,
    required this.recevierId,
    required this.text,
  });

  MessageModel.fromjson(Map<String,dynamic>json, this.datatime){
    senderId = json['senderId'];
    datatime = json['datatime'];
    recevierId = json['recevierId'];
    text = json['text'];
    MassageID = json['MassageID'];

  }

  Map<String,dynamic> tomap(){
    return {
      'datatime':datatime,
      'senderId':senderId,
      'recevierId':recevierId,
      'MassageID':MassageID,
      'text':text,

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


    ) ;

  }
}