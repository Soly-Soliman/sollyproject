
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:graduation_1/Components/follow_button.dart';
import 'package:graduation_1/Components/post_card.dart';
import 'package:graduation_1/Utils/utils.dart';
import 'package:graduation_1/resourses/firestore_methods.dart';
import 'package:graduation_1/screens/Edit_Profile_Screen.dart';

class ProfileScreen extends StatefulWidget {
  final String uid;
  const ProfileScreen({Key? key, required this.uid}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var userdata = {};
  int postlenght = 0;
  int followers = 0;
  int following = 0;
  bool isFollowing = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    setState(() {
      isLoading = true;
    });
    try {
      var userSnap = await FirebaseFirestore.instance
          .collection('Users')
          .doc(widget.uid)
          .get();
      userdata = userSnap.data()!;

      var postSnap = await FirebaseFirestore.instance
          .collection('posts')
          .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .get();
      postlenght = postSnap.docs.length;
      followers = userSnap.data()!['followers'].length;
      following = userSnap.data()!['following'].length;

      isFollowing = userSnap.data()!['followers'].contains(FirebaseAuth.instance.currentUser!.uid);
      setState(() {});
    } catch (e) {
      showSnackBar(e.toString(), context);
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(
            child: CircularProgressIndicator(),
          );
    } else {
      return Scaffold(
            // appBar: AppBar(flexibleSpace: Text('LOGO'),),
            body: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      bottom: 1, left: 10, right: 10, top: 2),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [

                                  Container(
                                    padding: const EdgeInsets.all(7),
                                    decoration: BoxDecoration(
                                           color: Colors.teal,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    width: 200,
                                    height: 50,
                                    child: Text(
                                      userdata['username'],
                                      style: const TextStyle(
                                          color: Colors.black, fontSize: 25),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(top: 9),
                                //       color: Colors.red,
                                    child: SizedBox(
                                      height: 51,
                                      width: 80,
                                      child: Column(
                                        children: [
                                          Text(
                                            '$postlenght',
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 20.0,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          const Icon(Icons.star,color:Colors.amber ,)
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Container(
                                      padding: const EdgeInsets.all(7),
                                      margin: const EdgeInsets.only(left: 7, top: 7),
                                      decoration: BoxDecoration(
                                          color: Colors.grey,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      width: 200,
                                      height: 30,
                                      child: Text(
                                        userdata['bio'],
                                        style: const TextStyle(
                                            color: Colors.black, fontSize: 15),
                                      )),
                                  const SizedBox(
                                    height: 20,
                                    width: 80,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          CircleAvatar(
                            backgroundColor: Colors.grey,
                            radius: 41,
                            backgroundImage:
                                NetworkImage(userdata['photoUrl']),
                          ),
                        ],
                      ),

                      // const Divider(
                      //   color: Colors.grey,
                      // ),
                      Container(
                        //      color: Colors.lime,
                        height: 50,
                        width: 400,
                        padding: const EdgeInsets.all(2),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.all(3),
                                child: Column(
                                  children: [
                                    Text(
                                      '$followers',
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 17.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const Text(
                                      'Followers',
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.w700),
                                    )
                                  ],
                                ),
                                //    color: Colors.amber,
                                height: 100,
                              ),
                            ),
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.all(3),
                                child: Column(
                                  children: [
                                    Text(
                                      '$following',
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 17.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const Text(
                                      'Follwing',
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.w700),
                                    )
                                  ],
                                ),
                                height: 100,
                              ),
                            ),
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                margin: const EdgeInsets.all(2),
                                child: Column(
                                  children: [
                                    FirebaseAuth.instance.currentUser!.uid ==
                                            widget.uid
                                        ? InkWell(
                                            onTap: () =>
                                                Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        (const EditProfileScreen()),
                                                  ),
                                                ),
                                            child: const Text(
                                              'EDIT',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 20.0,
                                                  fontWeight: FontWeight.bold),
                                            ))
                                        : isFollowing ?
                                    FollowButton(
                                      name: 'Unfollow',
                                      backgrouncolor: Colors.teal,
                                      textcolor: Colors.black,
                                      bordercolor: Colors.grey,
                                      function: () async {
                                        await FireStoreMethods()
                                            .followuser(FirebaseAuth.instance.currentUser!.uid, userdata['uid'],
                                        );
                                        setState(() {
                                          isFollowing= false ;
                                          followers -- ;
                                        });
                                      },

                                    )
                                            : FollowButton(
                                                textcolor: Colors.black,
                                                name: 'Follow',
                                                backgrouncolor: Colors.teal,
                                                bordercolor: Colors.grey,
                                                function: () async {
                                                await FireStoreMethods()
                                                .followuser(
                                                 FirebaseAuth.instance
                                                .currentUser!.uid,
                                                   userdata['uid'],
                                                );
                                                setState(() {
                                                  isFollowing =true ;
                                                  following++;
                                                });

                                                }
                                                     )
                                  ],
                                ),
                                decoration: BoxDecoration(
                                    color: Colors.teal,
                                    borderRadius: BorderRadius.circular(10)),
                                height: 100,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Divider(
                        color: Colors.grey,
                      ),
                    ],
                  ),
                ),
                FutureBuilder(
                    future: FirebaseFirestore.instance
                        .collection('posts')
                        .where('uid', isEqualTo: widget.uid)
                        .get(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return GridView.builder(
                        shrinkWrap: true,
                        itemCount: (snapshot.data! as dynamic).docs.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1,
                          crossAxisSpacing: 1,
                          mainAxisSpacing: 1,
                          childAspectRatio: 1,
                        ),
                        itemBuilder: (context, index) {
                          DocumentSnapshot snap =
                              (snapshot.data! as dynamic).docs[index];

                          return PostCard(
                            snapshot: snap,
                          );
                        },
                      );
                    }),
              ],
            ),
          );
    }
  }
}
