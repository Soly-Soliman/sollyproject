import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation_1/Components/animatios.dart';
import 'package:graduation_1/Utils/colors.dart';
import 'package:graduation_1/Utils/utils.dart';
import 'package:graduation_1/resourses/firestore_methods.dart';
import 'package:graduation_1/screens/comments_screen.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../models/user.dart';
import '../providers/user_provider.dart';

class PostCard extends StatefulWidget {
  final snapshot;
  const PostCard({
    Key? key,
    required this.snapshot,
  }) : super(key: key);

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
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
          .collection('posts')
          .doc(widget.snapshot['PostID'])
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
                CircleAvatar(
                  radius: 20,
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
                                        .deletepost(widget.snapshot['PostID']);
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
          Container(
            margin: EdgeInsets.only(left: 3),
            width: 400,
            child: Text(
              widget.snapshot['description'],
              maxLines: 2,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          GestureDetector(
            onDoubleTap: () async {
              await FireStoreMethods().likedPost(widget.snapshot['PostID'],
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
                          Column(
                            children: [
                              Container(
                                width: 300,
                                color: Colors.white,
                                child: Text(
                                  widget.snapshot['description'],
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.70,
                                width: 450,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(0),
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      widget.snapshot['PostUrl'],
                                    ),
                                    fit: BoxFit.fill,
                                    alignment: FractionalOffset.topCenter,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ]),
                      ),
                    );
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.21,
                    width: 300,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: NetworkImage(
                          widget.snapshot['PostUrl'],
                        ),
                        fit: BoxFit.fill,
                        alignment: FractionalOffset.topCenter,
                      ),
                    ),
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
                    await FireStoreMethods().likedPost(
                        widget.snapshot['PostID'],
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
                    builder: (context) => CommentsScreen(
                      snapshot: widget.snapshot,
                    ),
                  ),
                ),
                icon: Icon(
                  Icons.quickreply,
                  color: Colors.black,
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
                                      child: const Text('Send '),
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
                  size: 19,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
