
import 'package:flutter/material.dart';
import 'package:graduation_1/Utils/colors.dart';
import 'package:intl/intl.dart';

import '../resourses/firestore_methods.dart';
import '../screens/profile/profile_screen.dart';


class Massage_Card extends StatefulWidget {
  final snap;
  const Massage_Card({ Key? key, required this.snap }) : super(key: key);

  @override
  _Massage_CardState createState() => _Massage_CardState();
}

class _Massage_CardState extends State<Massage_Card> {
  @override
  Widget build(BuildContext context) {
    return Container(

      margin: const EdgeInsets.all(8.0),
   //   padding: const EdgeInsets.symmetric(vertical: 6 ,horizontal: 5) ,
      decoration: BoxDecoration(
      color: blue1,

        borderRadius: const BorderRadius.all(Radius.circular(10.0) //                 <--- border radius here
        ),
      ),
      child: InkWell(
        onDoubleTap: (){
          showDialog(
            context: context,
            builder: (context) => Dialog(
              child: ListView(
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                ),
                shrinkWrap: true,
                children: ['Delete']
                    .map(
                      (e) => InkWell(
                    onTap: () async{
                      FireStoreMethods().deleteMassage(widget.snap['senderId'],widget.snap['recevierId'],widget.snap['MassageID']) ;
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16),
                      child: Text(e),
                    ),
                  ),
                )
                    .toList(),
              ),
            ),
          );
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Padding(padding: const EdgeInsets.only(left:5) ,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      InkWell(
                       onTap: (){
    Navigator.of(context).push(
    MaterialPageRoute(
    builder: (context) => ProfileScreen(
    uid: widget.snap['uid'],

    ),
    ),
    );
    },
                        child: Column(
                          children: [
                           //
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                DateFormat.yMd().format(
                                  widget.snap['datatime'].toDate(),
                                ),
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 12
                                ),
                              ),),
                            CircleAvatar(
                              radius: 18,
                              backgroundImage: NetworkImage(
                                widget.snap['profileImageUrl'],
                              ),
                            ),
                          ],
                        ),
                      ),

                      Container(
                        width: 280,
                        margin: const EdgeInsets.all(3.0),
                        padding: const EdgeInsets.symmetric(vertical: 6 ,horizontal: 5) ,
                        decoration: BoxDecoration(
                          color: primary,

                          borderRadius: const BorderRadius.all(Radius.circular(10.0) //                 <--- border radius here
                          ),
                        ),
                        child: RichText(
                          text:  TextSpan(
                              text: widget.snap ['text'] ,
                              style: const TextStyle(color: black,)
                          ),),
                      ),

                    ],
                  ),
                 /* Container(
                    margin: const EdgeInsets.all(3.0),
                    padding: const EdgeInsets.symmetric(vertical: 6 ,horizontal: 5) ,
                    decoration: BoxDecoration(
                      color: Colors.white ,
                      border: Border.all(color: Colors.blueAccent,),
                      borderRadius: const BorderRadius.all(Radius.circular(10.0) //                 <--- border radius here
                      ),
                    ),
                    child: RichText(
                      text:  TextSpan(
                          text: widget.snap ['text'] ,
                          style: const TextStyle(color: Colors.black,)
                      ),),
                  ),*/

                ],
              ),
            ),
          ],
        ),
      ),

    );
  }
}