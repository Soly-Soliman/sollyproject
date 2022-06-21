import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation_1/Components/animatios.dart';
import 'package:graduation_1/Utils/utils.dart';
import 'package:graduation_1/resourses/firestore_methods.dart';
import 'package:graduation_1/screens/event/eventcomments.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../Utils/colors.dart';
import '../models/user.dart';
import '../providers/user_provider.dart';
import '../screens/Google/google_map_screen.dart';
import '../screens/profile/profile_screen.dart';

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
  int commentLenght = 0;
  @override
  void initState() {
    super.initState();
    getComment();
  }

  void getComment() async {
    try {
      QuerySnapshot snap = await FirebaseFirestore.instance
          .collection('events')
          .doc(widget.snapshot['EventID'])
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
      decoration: BoxDecoration(
        borderRadius: BorderRadiusDirectional.circular(20),
        color: primary,
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
                SizedBox(
                  width: 5,
                ),
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
                          style: const TextStyle(
                              fontSize: 14, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ),
                Text(
                  DateFormat.yMd().format(
                    widget.snapshot['dataPublished'].toDate(),
                  ),
                  // ' ${}',
                  style: const TextStyle(fontSize: 12, color: Colors.black),
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
                                    FireStoreMethods().deleteevent(
                                        widget.snapshot['EventID']);
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
                    size: 20,
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
                      child: InkWell(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) => Dialog(
                              child: ListView(shrinkWrap: true, children: [
                                Column(
                                  children: [
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.70,
                                      width: 450,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(0),
                                        image: DecorationImage(
                                          image: NetworkImage(
                                            widget.snapshot['EventUrl'],
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
                          height: MediaQuery.of(context).size.height * 0.32,
                          width: 230,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              image: DecorationImage(
                                image: NetworkImage(
                                  widget.snapshot['EventUrl'],
                                ),
                                fit: BoxFit.fill,
                                alignment: FractionalOffset.topCenter,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) => Dialog(
                              backgroundColor:  primary,
                              child: ListView(shrinkWrap: true, children: [
                                Column(
                                  children: [
                                    Container(
                                      width: 450,
                                      margin: EdgeInsets.all(15),
                                      padding: EdgeInsets.all(15),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(0),
                                      ),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [

                                              Container(width: 90,
                                                child: Text(
                                                  widget.snapshot['name'],
                                                  style: const TextStyle(
                                                    fontSize: 20,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Divider(color: Colors.grey,),
                                          SizedBox(height: 30,) ,
                                          Text(
                                            widget.snapshot['description'],
                                            style: const TextStyle(

                                              fontSize: 20,
                                            ),
                                          ),
                                          Divider(color: Colors.grey, ),
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.calendar_today_outlined,
                                                size: 18,
                                              ),
                                              SizedBox(width: 12,) ,
                                              Text(
                                                'Date : ',
                                                style: const TextStyle(
                                                  fontSize: 18,
                                                ),
                                              ),
                                              Text(
                                                widget.snapshot['date'],
                                                style: const TextStyle(
                                                  fontSize: 18,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(width: 12,height: 15,) ,
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.timer,
                                                size: 18,
                                              ),
                                              SizedBox(width: 12,) ,
                                              Text(
                                                'Time : ',
                                                style: const TextStyle(
                                                  fontSize: 18,
                                                ),
                                              ),
                                              Text(
                                                widget.snapshot['time'],
                                                style: const TextStyle(
                                                  fontSize: 18,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 15,) ,
                                          Row(
                                            children: [
                                              Icon(

                                                Icons.place ,
                                                size: 28,
                                                color: selection2,
                                              ),
                                              SizedBox(width: 12,) ,

                                              Text(
                                                widget.snapshot['place'],
                                                style: const TextStyle(
                                                  fontSize: 18,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Divider(color: Colors.grey, ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.all(15),
                                      padding: EdgeInsets.all(15),
                                      child: SingleChildScrollView(

                                      physics: const ClampingScrollPhysics(),
                                      child:    Row(
                                        children: [
                                          Expanded(
                                            child: FutureBuilder(
                                                future: FirebaseFirestore.instance
                                                    .collection('events')
                                                    .get(),
                                                builder: (context, snapshot) {
                                                  if (snapshot.connectionState == ConnectionState.waiting) {
                                                    return const Center(
                                                      child: CircularProgressIndicator(),
                                                    );
                                                  }
                                                  return GridView.builder(
                                                    primary: false,
                                                    shrinkWrap: true,
                                                    padding: EdgeInsets.zero,

                                                    itemCount: (snapshot.data! as dynamic).docs.length,
                                                    gridDelegate:
                                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                                      crossAxisCount: 4,
                                                      crossAxisSpacing: 18,

                                                    ),
                                                    itemBuilder: (context, index) {
                                                      DocumentSnapshot snap =
                                                      (snapshot.data! as dynamic).docs[index];

                                                      return InkWell(
                                                        onTap: (){},

                                                        child: Container(
                                                          child: Image(
                                                            fit: BoxFit.fill,
                                                            image: NetworkImage(snap['EventUrl']),
                                                          ),

                                                        ),
                                                      ) ;
                                                    },
                                                  );
                                                }),

                                          ),


                                        ],
                                      ),



                                        ),
                                    )

                                  ],
                                ),
                              ]),
                            ),
                          );
                        },
                        child: Container(
                          //   color: Colors.cyan.shade200,
                          child: Column(
                            children: [
                              Container(
                                //                                 color: Colors.purple,
                                height: 60,
                                width: 140,
                                child:
                                    Text(
                                      widget.snapshot['name'],
                                      style: const TextStyle(
                                        fontSize: 20,
                                      ),
                                    ),

                              ) ,

                              Divider(
                                height: 2,
                                color: Colors.black,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadiusDirectional.circular(7),
                                  //   color: Colors.yellowAccent,
                                ),
                                height: 40,
                                width: 180,
                                child: Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.calendar_today_outlined,
                                              size: 14,
                                            ),
                                            Text(
                                              'Date : ',
                                              style: const TextStyle(
                                                fontSize: 18,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          width: 0,
                                          height: 3,
                                        ),
                                        Text(
                                          widget.snapshot['date'],
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      width: 30,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.timer,
                                              size: 14,
                                            ),
                                            Text(
                                              'Time : ',
                                              style: const TextStyle(
                                                fontSize: 18,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          width: 0,
                                          height: 3,
                                        ),
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
                              Divider(
                                height: 2,
                                color: Colors.black,
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Place : ',
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                    ),
                                  ),
                                  Container(
                                    //    color: Colors.yellow,
                                    width: 120,
                                    child: Text(
                                      widget.snapshot['place'],
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                  ),
                                ],
                              ),
                              Divider(
                                height: 2,
                                color: Colors.black,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Container(
                                width: 170,
                                //      color: Colors.yellowAccent,
                                child: Row(
                                  children: [
                                    Container(
                                      width: 170,
                                      child: Text(
                                        widget.snapshot['description'],
                                        maxLines: 4,
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Divider(
                                height: 2,
                                color: Colors.black,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 100),
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
                          size: 28,
                        )
                      : const Icon(
                          Icons.person,
                          color: Colors.black,
                          size: 19,
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
                  size: 19,
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
                  size: 18,
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Stack(children: [
                    CircleAvatar(
                      backgroundColor: selection2,
                      radius: 24,
                      child: IconButton(
                          color: Colors.white,
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => GoogleMapPage(),
                              ),
                            );
                          },
                          icon: const Icon(Icons.location_on, size: 25)),
                    ),
                    //  Positioned(child: Text('MAP') ,left: 9,bottom: 35,)
                  ]),
                ),
              ),
            ],
          ),
          //Description
        ],
      ),
    );
  }
}
