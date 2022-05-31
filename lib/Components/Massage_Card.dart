
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


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
      margin: const EdgeInsets.all(10.0),
      padding: const EdgeInsets.symmetric(vertical: 6 ,horizontal: 5) ,
      decoration: BoxDecoration(
        color: const Color(0xFFFFE306) ,
        border: Border.all(color: Colors.blueAccent,),
        borderRadius: const BorderRadius.all(Radius.circular(10.0) //                 <--- border radius here
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
      /*    InkWell(
            onTap: (){},
            child: CircleAvatar(
              radius: 10,
              backgroundImage: NetworkImage(
                widget.snap['profileUrl'],
              ),
            ),
          ),*/
          Padding(padding: const EdgeInsets.only(left:10 ) ,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
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
                  ],
                ),
                Container(
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
                ),

              ],
            ),
          ),
        ],
      ),

    );
  }
}