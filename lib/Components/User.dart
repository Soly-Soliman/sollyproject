import 'package:flutter/material.dart';


import '../Utils/colors.dart';
import '../screens/Chat_ID_screen.dart';
class User_card extends StatefulWidget {
  final snapshot;
  const User_card({
    Key? key,
    required this.snapshot,
  }) : super(key: key);
  @override
  State<User_card> createState() => _User_cardState();
}
class _User_cardState extends State<User_card> {
  @override
  Widget build(BuildContext context) {
    return Container(


      child: Column(
        children: [
          Container(
            width: 350,
            decoration: BoxDecoration(borderRadius: BorderRadiusDirectional.circular(6),
                color: blue1,

            ),

            child: InkWell(
              onTap:  () => Navigator.of(context).push(
              MaterialPageRoute(
               builder: (context) => CHAT_ID_Screen(
                  uid: widget.snapshot['uid'],
                ),
               ),
                ),
              child: Row(
                children: [
                  SizedBox(width: 10,),
                  CircleAvatar(
                    radius: 26,
                    backgroundImage: NetworkImage(
                      widget.snapshot['photoUrl'],
                    ),
                  ),
                       SizedBox(width: 30,),
                  Text(
                            widget.snapshot['username'],
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                ],
              ),
            ),
          ),
          const Divider(
            color: Colors.black,
          ),
          //the next row is to the last part and it contains likes & comment
        ],
      ),
    );
  }
}
