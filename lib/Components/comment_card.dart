
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../Utils/colors.dart';


class CommentCard extends StatefulWidget {
  final snap;
  const CommentCard({ Key? key, required this.snap }) : super(key: key);

  @override
  _CommentCardState createState() => _CommentCardState();
}

class _CommentCardState extends State<CommentCard> {
  @override
  Widget build(BuildContext context) {
    return Container(

      margin: const EdgeInsets.all(2.0),
      padding: const EdgeInsets.symmetric(vertical: 6 ,horizontal: 5) ,
      decoration: BoxDecoration(
        color: blue1 ,
          border: Border.all(color: Colors.blue,),
        borderRadius: const BorderRadius.all(Radius.circular(8.0) //                 <--- border radius here
        ),
      ),
         child: Row(
           mainAxisAlignment: MainAxisAlignment.start,
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
             InkWell(
               onTap: (){},
               child: CircleAvatar(
                 radius: 22,
                 backgroundImage: NetworkImage(
                   widget.snap['profileUrl'],
                 ),
               ),
             ),
             Padding(padding: const EdgeInsets.only(left:2 ) ,
               child: Column(
                 mainAxisAlignment: MainAxisAlignment.start,
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   Row(
                     children: [
                       RichText(
                         text: TextSpan(
                           children: [
                             TextSpan(
                               text:widget.snap['username'] ,
                               style: const TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize:15),
                             ),
                           ],
                         ),
                       ),
                       Padding(
                         padding: const EdgeInsets.only(left: 10),
                         child: Text(
                              DateFormat.yMd().format(
                                 widget.snap['dataPublished'].toDate(),
                                   ),
                           style: const TextStyle(
                             color: Colors.black,
                             fontSize: 12
                           ),
                       ),),
                     ],
                   ),
                Container(
                  width: 258,

                    padding: const EdgeInsets.symmetric(vertical: 3 ,horizontal: 5) ,
                    decoration: BoxDecoration(
                      color: Colors.white ,
                      border: Border.all(color: Colors.blueAccent,),
                      borderRadius: const BorderRadius.all(Radius.circular(10.0) //                 <--- border radius here
                      ),
                    ),
                    child: RichText(
                     text:  TextSpan(
                           text: widget.snap ['description'] ,
                           style: const TextStyle(color: Colors.black,)
                       ),),
                  ),

                 ],
               ),
             ),
           /*
             Container(

             //  color: Colors.red,
               child: InkWell(
                 onTap: (){},

                 child:const Icon(Icons.favorite,color: Colors.white,size: 20,),
               ),
             ),
            */
           ],
         ),
    
    );
  }
}