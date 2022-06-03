import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation_1/Components/animatios.dart';
import 'package:graduation_1/Utils/colors.dart';
import 'package:graduation_1/Utils/utils.dart';
import 'package:graduation_1/resourses/firestore_methods.dart';
import 'package:graduation_1/screens/comments_screen.dart';
import 'package:graduation_1/screens/eventcomments.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../models/user.dart';
import '../providers/user_provider.dart';

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
        color: Color(0xFFFFFFFF),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 2),
      child: Column(
        children: [
          // that is the header to the post and it contains the username his photo  and function delete post
          Container(
            color: Colors.yellowAccent,
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16)
                .copyWith(right: 0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 23,
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
                        Row(
                          children: [
                            Text("Event Name :"),
                            Text(
                              widget.snapshot['name'],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  child: Text(
                    DateFormat.yMd().format(
                      widget.snapshot['dataPublished'].toDate(),
                    ),
                    // ' ${}',
                    style: const TextStyle(fontSize: 16, color: Colors.black),
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
                          children: ['Delete']
                              .map(
                                (e) => InkWell(
                              onTap: () async{
                                FireStoreMethods().deletepost(widget.snapshot['EventID']) ;
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
          Container(
            child: Row(
              children: [
                SizedBox(width: 30,),
                Column(
                  children: [
                    Text('Date : '),
                    Text('Time : '),
                    Text('DES VV:  '),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      widget.snapshot['date'],
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      widget.snapshot['time'],
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      widget.snapshot['description'],
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 50,) ,
                Text('Place : '),
                Text(
                  widget.snapshot['description'],
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
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
                Container(
                  height: MediaQuery.of(context).size.height * 0.35,
                  width: double.infinity,
                  color: Colors.white,
                  child: Image.network(
                    widget.snapshot['EventUrl'],
                    //    fit: BoxFit.scaleDown,
                  ),
                ),
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 200),
                  opacity: isLikeAnimating ? 1 : 0,
                  child: Like_Animation(
                    child: const Icon(
                      Icons.favorite,
                      color: Colors.indigo,
                      size: 130,
                    ),
                    isAnimating: isLikeAnimating,
                    smallLike: true,
                    duration: const Duration(milliseconds: 400),
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
          const Divider(
            color: Colors.black,
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
                      ? Icon(
                    Icons.people,
                    color: Colors.red,
                  )
                      : Icon(
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
                icon: Icon(
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
                                    Icon(Icons.send),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'Share',
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      icon: Icon(Icons.repeat),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ]),
                    ),
                  );
                },
                icon: Icon(
                  Icons.repeat,
                  color: Colors.black,
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.bookmarks_outlined),
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
                  padding: EdgeInsets.only(
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
