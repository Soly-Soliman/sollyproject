import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation_1/Components/animatios.dart';
import 'package:graduation_1/Utils/utils.dart';
import 'package:graduation_1/resourses/firestore_methods.dart';
import 'package:graduation_1/screens/eventcomments.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../Utils/colors.dart';
import '../models/user.dart';
import '../providers/user_provider.dart';
import '../screens/google_map_screen.dart';

class EventCard extends StatefulWidget {
  final snapshot;
  const EventCard({
    Key? key,
    required this.snapshot,
  }) : super(key: key);

  @override
  State<EventCard> createState() => _EventCardState();
}

class _EventCardState extends State<EventCard> {
  bool isLikeAnimating = false;
  int commentLenght =0 ;
  @override
  void initState() {
    super.initState();
    getComment();
  }

  void getComment() async{
    try {
      QuerySnapshot snap = await FirebaseFirestore.instance.collection('events')
          .doc(widget.snapshot['EventID']).collection('comments')
          .get();
      commentLenght = snap.docs.length;
    }catch(e){
      showSnackBar(e.toString(), context);
    }
    setState(() {

    });
  }


  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<UserProvider>(context).getUser;

    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadiusDirectional.circular(23),
        color: const Color(0xFFFFFFFF),
        
      ),
         margin: EdgeInsets.all(6),

  //    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 2),
      child: Column(
        children: [
          // that is the header to the post and it contains the username his photo  and function delete post
          Container(

         //   padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16).copyWith(right: 0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundImage: NetworkImage(
                    widget.snapshot['profileUrl'],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 8,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                      ],
                    ),
                  ),
                ),
                Text(
                  DateFormat.yMd().format(
                    widget.snapshot['dataPublished'].toDate(),
                  ),
                  // ' ${}',
                  style: const TextStyle(fontSize: 16, color: Colors.black),
                ),
                IconButton(
                  onPressed: () {
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
                                FireStoreMethods().deleteevent(widget.snapshot['EventID']) ;
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
                  icon: const Icon(
                    Icons.more_horiz_outlined,
                  ),
                ),
              ],
            ),
          ),

          GestureDetector(
            onDoubleTap: () async {
              await FireStoreMethods().likedPost(widget.snapshot['EventID'],
                  user.uid, widget.snapshot['likes']);
              setState(() {
                isLikeAnimating = true;
              });
            },
            child: Stack(
              
              alignment: Alignment.center,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.35,
                        width: 230,
              //          color: Colors.pink,
                        child: Image.network(
                          widget.snapshot['EventUrl'],
                          //    fit: BoxFit.scaleDown,
                        ),
                      ),
                    ),
                    const SizedBox(width: 5,),
                    Expanded(

                          child:
                              Container(
                             //   color: Colors.cyan.shade200,
                                child: Column(

                                  children:  [
                                    Container(
   //                                 color: Colors.purple,
                                      height: 40,
                                      width: 180,
                                      child: Row(
                                        children: [
                                        /*
                                          const Text("Event : " ,  style: const TextStyle(
                                            color: Colors.black,

                                            fontSize: 20,
                                          ),),
                                         */
                                          Text(
                                            widget.snapshot['name'],
                                            style: const TextStyle(

                                              fontSize: 20,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Divider(height: 2,color: Colors.black,),
                                    Container(
                                      decoration: BoxDecoration(borderRadius: BorderRadiusDirectional.circular(7),
                                     //   color: Colors.yellowAccent,
                                      ),

                                      height: 40,
                                      width: 180,
                                      child: Row(
                                        children:  [
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [

                                              Row(
                                                children: [
                                                  Icon(Icons.calendar_today_outlined ,size: 14,),
                                                  Text('Date : ' , style: const TextStyle(

                                                    fontSize: 18,
                                                  ),),
                                                ],
                                              ),
                                              Container(width: 70,height: 1,color: Colors.black,) ,
                                              Text(
                                                widget.snapshot['date'],
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                         SizedBox(width: 30,),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [

                                              Row(
                                                children: [
                                                  Icon(Icons.timer ,size: 14,),

                                                  Text('Time : ', style: const TextStyle(

                                                    fontSize: 18,
                                                  ),),
                                                ],
                                              ),
                                              Container(width: 70,height: 1,color: Colors.black,) ,
                                              Text(
                                                widget.snapshot['time'],
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),

                                        ],
                                      ),
                                    ),
                                    Divider(height: 2,color: Colors.black,) ,
                                    SizedBox(height: 5,),
                                    Row(
                                      children: [
                                        Text('Place : ' ,
                                          style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 18 ,
                                        ),),
                                        Container(
                                      //    color: Colors.yellow,
                                          width: 120,
                                          child: Text(
                                            widget.snapshot['place'],
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18
                                            ),
                                          ),
                                        ),

                                      ],
                                    ),

                                    Divider(height: 2,color: Colors.black,) ,
                                    SizedBox(height: 5,),
                                    Container(
                                      width: 170,
                                //      color: Colors.yellowAccent,
                                      child: Row(
                                        children:  [
                                          Container(
                                            width: 170,
                                            child: Text(
                                              widget.snapshot['description'],
                                              style: const TextStyle(
                                                color: Colors.black,

                                                fontSize: 18,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Divider(height: 2,color: Colors.black,) ,

                                  ],
                                ),
                              ),


                        ),

                  ],
                ),
                AnimatedOpacity(
                  duration: const Duration(milliseconds:100),
                  opacity: isLikeAnimating ? 1 : 0,
                  child: Like_Animation(
                    child: const Icon(
                      Icons.favorite,
                      color: Colors.pink,
                      size: 130,
                    ),
                    isAnimating: isLikeAnimating,
                    smallLike: true,
                    duration: const Duration(milliseconds: 200),
                    onEnd: () {
                      setState(() {
                        isLikeAnimating = false;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),

          //the next row is to the last part and it contains likes & comment
          Row(
            children: [
              Like_Animation(
                isAnimating: widget.snapshot['likes'].contains(user.uid),
                smallLike: true,
                child: IconButton(
                  onPressed: () async {
                    await FireStoreMethods().likedEvent(
                        widget.snapshot['EventID'],
                        user.uid,
                        widget.snapshot['likes']);
                  },
                  icon: widget.snapshot['likes'].contains(user.uid)
                      ? const Icon(
                    Icons.people,
                    color: Colors.red,
                  )
                      : const Icon(
                    Icons.person,
                    color: Colors.black,
                  ),
                ),
              ),
              IconButton(
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => eventCommentsScreen(
                      snapshot: widget.snapshot,
                    ),
                  ),
                ),
                icon: const Icon(
                  Icons.quickreply,
                  color: Colors.black,
                ),
              ),
              IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => Dialog(
                      child: ListView(
                          padding: const EdgeInsets.symmetric(
                            vertical: 16,
                          ),
                          shrinkWrap: true,
                          children: [
                            Column(
                              children: [
                                Row(
                                  children: [
                                    SimpleDialogOption(
                                      padding: const EdgeInsets.all(10),
                                      child: const Text('Send'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    const Icon(Icons.send),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Text(
                                      'Share',
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      icon: const Icon(Icons.repeat),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ]),
                    ),
                  );
                },
                icon: const Icon(
                  Icons.repeat,
                  color: Colors.black,
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomRight,

                  child: Stack(

                    children: [
                    CircleAvatar(
                      backgroundColor:selection2 ,
                      radius: 24,
                      child: IconButton(
                            color: Colors.white,
                        onPressed: () {Navigator.of(context).push(MaterialPageRoute(builder:(context) =>  GoogleMapPage(), ),);},
                        icon: const Icon(Icons.location_on ,size: 25)
                      ),
                    ),
                    //  Positioned(child: Text('MAP') ,left: 9,bottom: 35,)
                    ]
                  ),
                ),
              ),
            ],
          ),
          //Description
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(
                    top: 8.0,
                  ),
                /* child: RichText(
                    /*text: TextSpan(
                      style: const TextStyle(
                        color: mobileBackgroundColor,
                      ),
                      children: [
                        TextSpan(
                          text: widget.snapshot['description'],
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),*/
                  ),*/
                ),


              ],
            ),
          ),
        ],
      ),
    );
  }
}
