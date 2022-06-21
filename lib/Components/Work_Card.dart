import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation_1/Components/animatios.dart';
import 'package:graduation_1/Utils/colors.dart';
import 'package:graduation_1/Utils/utils.dart';
import 'package:graduation_1/resourses/firestore_methods.dart';
import 'package:graduation_1/screens/feed/comments_screen.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../models/user.dart';
import '../providers/user_provider.dart';
import '../screens/Chat/Chat_ID_screen.dart';
import '../screens/Experts/Expert_comment_screen.dart';
import '../screens/hobby/Hobby_comment_screen.dart';
import '../screens/profile/profile_screen.dart';

class work_Card extends StatefulWidget {
  final snapshot;
  const work_Card({
    Key? key,
    required this.snapshot,
  }) : super(key: key);

  @override
  State<work_Card> createState() => _work_CardState();
}

class _work_CardState extends State<work_Card> {
  bool isLikeAnimating = false;
  int commentLenght = 0;
  @override
  void initState() {
    super.initState();
    getComment();
  }

  void getComment() async {
    try {
      QuerySnapshot snap = await FirebaseFirestore.instance
          .collection('Work')
          .doc(widget.snapshot['HobbyID'])
          .collection('comments')
          .get();
      commentLenght = snap.docs.length;
    } catch (e) {
      showSnackBar(e.toString(), context);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<UserProvider>(context).getUser;

    return Container(
      width: 400,
      decoration: BoxDecoration(
        borderRadius: BorderRadiusDirectional.circular(20),
        color: Colors.white,
      ),
      margin: EdgeInsets.all(8),
      // padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 2),
      child: Column(
        children: [
          // that is the header to the post and it contains the username his photo  and function delete post
          Container(
            color: Colors.white,
            child: Row(
              children: [
                InkWell(
                  onTap: (){
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ProfileScreen(
                          uid: widget.snapshot['uid'],

                        ),
                      ),
                    );
                  },
                  child: CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage(
                      widget.snapshot['profileUrl'],
                    ),
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
                Container(
                  child: Text(
                    DateFormat.yMd().format(
                      widget.snapshot['dataPublished'].toDate(),
                    ),
                    // ' ${}',
                    style: const TextStyle(fontSize: 12, color: Colors.black),
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
                                  onTap: () async {
                                    FireStoreMethods()
                                        .deleteWork(widget.snapshot['HobbyID']);
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
                    size: 16,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onDoubleTap: () async {
              await FireStoreMethods().likedHobby(widget.snapshot['HobbyID'],
                  user.uid, widget.snapshot['likes']);
              setState(() {
                isLikeAnimating = true;
              });
            },
            child: Stack(
              alignment: Alignment.center,
              children: [
                InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => Dialog(
                        child: ListView(
                            shrinkWrap: true, children: [
                          Container(
                            decoration: BoxDecoration(color: selection3),
                            child: Column(

                              children: [
                                Row(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.all(15),
                                      width: 200,
                                      child: Text(
                                        widget.snapshot['description'],
                                        textAlign: TextAlign.center,
                                        maxLines: 2,
                                        style: const TextStyle(
                                          color: black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  margin: EdgeInsets.all(15),
                                  width: 300,
                                  child: Text(
                                    widget.snapshot['place'],
                                    textAlign: TextAlign.center,
                                    maxLines: 6,
                                    style: const TextStyle(
                                      color: black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(color: selection3),
                                  margin: EdgeInsets.all(15),
                                  width: 300,
                                  child: Text(
                                    widget.snapshot['age'],
                                    textAlign: TextAlign.center,
                                    maxLines: 6,
                                    style: const TextStyle(
                                      color: black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.40,
                                  width: 450,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(0),
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        widget.snapshot['HobbyUrl'],
                                      ),
                                      fit: BoxFit.fill,
                                      alignment: FractionalOffset.topCenter,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ]),
                      ),
                    );
                  },
                  child: Row(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.21,
                        width: 150,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: NetworkImage(
                              widget.snapshot['HobbyUrl'],
                            ),
                            fit: BoxFit.fill,
                            alignment: FractionalOffset.topCenter,
                          ),
                        ),
                      ),
                      SizedBox(width: 20,),
                      Expanded(
                        child: Column(
                          children: [

                            Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(left: 3),
                                  width: 150,
                                  height: 30,
                                  child: Text(
                                    widget.snapshot['name'],
                                    maxLines: 6,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 4,),
                            Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(left: 3),
                                  width: 150,
                                  height: 30,
                                  child: Text(
                                    widget.snapshot['description'],
                                    maxLines: 6,
                                    style: const TextStyle(
                                      fontFamily: 'Trocchi',
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            Row(
                              children: [
                                Expanded(
                                  child: Container(

                                    margin: EdgeInsets.only(left: 3),
                                    width: 130,
                                    decoration: BoxDecoration(
                                        color: Colors.green.shade100,
                                      borderRadius: BorderRadius.circular(15)
                                    ),
                                    child: Text(
                                      widget.snapshot['age'],
                                      maxLines: 1,
                                      style: const TextStyle(
                                        color: black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 5,),

                              ],
                            ),
                            SizedBox(height: 4,),

                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          //the next row is to the last part and it contains likes & comment
          Row(
            children: [
              SizedBox(
                width: 6,
              ),
              DefaultTextStyle(
                style: Theme.of(context).textTheme.bodyText2!.copyWith(),
                child: Text(
                  '${widget.snapshot['likes'].length}',
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ),
              Like_Animation(
                isAnimating: widget.snapshot['likes'].contains(user.uid),
                smallLike: true,
                child: IconButton(
                  onPressed: () async {
                    await FireStoreMethods().likedWork(
                        widget.snapshot['HobbyID'],
                        user.uid,
                        widget.snapshot['likes']);
                  },
                  icon: widget.snapshot['likes'].contains(user.uid)
                      ? Icon(
                          Icons.favorite,
                          color: Colors.red,
                        )
                      : Icon(
                          Icons.favorite,
                          color: Colors.black,
                          size: 16,
                        ),
                ),
              ),
              IconButton(
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => Expert_CommentsScreen(
                      snapshot: widget.snapshot,
                    ),
                  ),
                ),
                icon: Icon(
                  Icons.quickreply,
                  color: black,
                  size: 18,
                ),
              ),
              InkWell(
                onTap: () {},
                child: Container(
                  child: Text(
                    ' $commentLenght comments',
                    style: const TextStyle(fontSize: 16, color: secondaryColor),
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => CHAT_ID_Screen(
                        uid: widget.snapshot['uid'],

                      ),
                    ),
                  );
                }, child: Text('Massage'),
             
              ),
            ],
          ),
        ],
      ),
    );
  }
}
