import 'package:flutter/material.dart';


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

      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 2),
      child: Column(
        children: [
          Container(
            color: Colors.white70,
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
                    radius: 23,
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
