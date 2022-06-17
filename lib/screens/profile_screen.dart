
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:graduation_1/Components/follow_button.dart';
import 'package:graduation_1/Utils/utils.dart';
import 'package:graduation_1/resourses/firestore_methods.dart';
import 'package:graduation_1/screens/Edit_Profile_Screen.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../Utils/colors.dart';

class ProfileScreen extends StatefulWidget {
  final String uid;
  const ProfileScreen({Key? key, required this.uid}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  PanelController _panelController = PanelController();
  bool _isOpen = false;

  var userdata = {};
  int postlenght = 0;
  int eventlength = 0;
  int Hobbylength = 0;


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
      var EventSnap = await FirebaseFirestore.instance
          .collection('events')
          .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .get();
      var HobbySnap = await FirebaseFirestore.instance
          .collection('Hobby')
          .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .get();
      eventlength =EventSnap.docs.length;
      Hobbylength =HobbySnap.docs.length;
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
             appBar: PreferredSize(
               preferredSize: const Size.fromHeight(33,),
               child: AppBar(
                 backgroundColor:selection ,
                 foregroundColor: black,

                 title: Text(userdata['username'],),
                 centerTitle: true,
               ),
             ),
        backgroundColor:blue1 ,
            body:

            Stack(
              fit: StackFit.expand,
              children: [
                FractionallySizedBox(
                  alignment: Alignment.topCenter,
                  heightFactor: 0.7,
                  child: Container(
                    decoration:  BoxDecoration(
                      image: DecorationImage(
                        image:
                          NetworkImage(userdata['photoUrl']),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),

                FractionallySizedBox(
                  alignment: Alignment.bottomCenter,
                  heightFactor: 0.3,
                  child: Container(
                    color: Colors.white,
                  ),
                ),
                SlidingUpPanel(
                  controller: _panelController,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(32),
                    topLeft: Radius.circular(32),
                  ),
                  minHeight: MediaQuery.of(context).size.height * 0.35,
                  maxHeight: MediaQuery.of(context).size.height * 0.85,
                  body: GestureDetector(
                    onTap: () => _panelController.close(),
                    child: Container(
                      color: Colors.transparent,
                    ),
                  ),
                  panelBuilder: (ScrollController controller) =>
                      _panelBody(controller),
                  onPanelSlide: (value) {
                    if (value >= 0.2) {
                      if (!_isOpen) {
                        setState(() {
                          _isOpen = true;
                        });
                      }
                    }
                  },
                  onPanelClosed: () {
                    setState(() {
                      _isOpen = false;
                    });
                  },
                ),
              ],
            ),
            /*
                        ListView(
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
                                           color: Colors.blue,
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
                          CircleAvatar(  backgroundColor: Colors.grey,  radius: 41,
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
                                      backgrouncolor: Colors.blue,
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
                                                backgrouncolor: Colors.blue,
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
             */


          );


    }

  }
  SingleChildScrollView _panelBody(ScrollController controller) {
    double hPadding = 40;

    return SingleChildScrollView(
      controller: controller,
      physics: const ClampingScrollPhysics(),
      child: Column(
        children: <Widget>[
          Container(

            padding: EdgeInsets.symmetric(horizontal: 10),
            height: MediaQuery.of(context).size.height * 0.35,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _titleSection(),
                _infoSection(),
                _actionSection(hPadding: 10),

              ],
            ),
          ),
          Container(width: 100,height: 4,color: Colors.grey,) ,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(child: Text("Events")),
              Expanded(child: Text("Posts")),
              Expanded(child: Text("Hoppy")),
            ],
          ),
          Container(
            color: blue1,
            child: Row(
              children: [
                Expanded(
                  child: FutureBuilder(
                      future: FirebaseFirestore.instance
                          .collection('events')
                          .where('uid', isEqualTo: widget.uid)
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
                            crossAxisCount: 1,
                            crossAxisSpacing: 18,

                          ),
                          itemBuilder: (context, index) {
                            DocumentSnapshot snap =
                            (snapshot.data! as dynamic).docs[index];

                            return InkWell(
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
                                                  snap['EventUrl'],
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

                Expanded(
                  child: FutureBuilder(
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
                          primary: false,
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,

                          itemCount: (snapshot.data! as dynamic).docs.length,
                          gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1,
                            crossAxisSpacing: 18,

                          ),
                          itemBuilder: (context, index) {
                            DocumentSnapshot snap =
                            (snapshot.data! as dynamic).docs[index];

                            return InkWell(onTap: ()
                            {
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
                                                snap['PostUrl'],
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
                                child: Image(
                                  fit: BoxFit.fill,
                                  image: NetworkImage(snap['PostUrl']),
                                ),

                              ),
                            ) ;
                          },
                        );
                      }),

                ),
                Expanded(
                  child: FutureBuilder(
                      future: FirebaseFirestore.instance
                          .collection('Hobby')
                          .where('uid', isEqualTo: widget.uid)
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
                            crossAxisCount: 1,
                            crossAxisSpacing: 18,

                          ),
                          itemBuilder: (context, index) {
                            DocumentSnapshot snap =
                            (snapshot.data! as dynamic).docs[index];

                            return InkWell(
                              onTap: ()
                              {
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
                                                  snap['HobbyUrl'],
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
                                child: Image(
                                  fit: BoxFit.fill,
                                  image: NetworkImage(snap['HobbyUrl']),
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
         
        ],
      ),
    );
  }
  /// Action Section
  Row _actionSection({required double hPadding}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Visibility(
          visible: !_isOpen,
          child: Expanded(
            child: Container(
              height: 38,
              decoration: BoxDecoration(
                color: selection3,
                borderRadius: BorderRadius.circular(15)
              ),
            
              child: OutlineButton(
                onPressed: () => _panelController.open(),
                borderSide:  BorderSide(color: selection2),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                child: const Text(
                  'VIEW PROFILE',
                  style: TextStyle(
                    fontFamily: 'NimbusSanL',
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
        ),
        Visibility(
          visible: !_isOpen,
          child:SizedBox(
            width: 4,
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
                    child:  Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14) ,
                        color: selection3,
                      ),

                      height: 38,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.build ,size: 25,color: selection,),
                          SizedBox(width: 4,) ,
                          Text(
                            'EDIT',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20.0,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ))
                    : isFollowing ?
                Row(
                  children: [
                    Expanded(
                      child: FlatButton(
                        onPressed: (){},
                         minWidth: 35,
                        color: selection2,
                        textColor: Colors.black,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child:Text(
                          'Chat',
                          style: TextStyle(
                            fontFamily: 'NimbusSanL',
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    FlatButton(
                      minWidth: 45,
                      onPressed: () async {

                        await FireStoreMethods()
                            .followuser(FirebaseAuth.instance.currentUser!.uid, userdata['uid'],
                        );
                        setState(() {
                          isFollowing= false ;
                          followers =followers -1 ;
                        });
                      },
                      color: selection2,
                      textColor: Colors.black,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      child: const Text(
                        'Unfollow',
                        style: TextStyle(
                          fontFamily: 'NimbusSanL',
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                )
                :
                    FlatButton(
                          onPressed: () async {
                            await FireStoreMethods()
                                .followuser(
                              FirebaseAuth.instance
                                  .currentUser!.uid,
                              userdata['uid'],
                            );
                            setState(() {
                              isFollowing =true ;
                              following =following+1;
                            });

                          },
                          color: selection2,
                          textColor: Colors.black,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25)),
                          child: const Text(

                            'Follow',
                            style: TextStyle(
                              fontFamily: 'NimbusSanL',
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    )


            ),

          ),

      ],
    );
  }

  /// Info Section
  Row _infoSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        _infoCell(title: 'followers', value: '$followers'),
        Container(
          width: 1,
          height: 40,
          color: Colors.grey,
        ),
        _infoCell(title: 'H', value: "$Hobbylength"),
        _infoCell(title: 'P', value: '$postlenght'),
        _infoCell(title: 'E', value: '$eventlength'),
        Container(
          width: 1,
          height: 40,
          color: Colors.grey,
        ),
        _infoCell(title: 'following', value: '$following'),
      ],
    );
  }

  /// Info Cell
  Column _infoCell({required String title, required String value}) {
    return Column(
      children: <Widget>[
        Text(
          title,
          style: const TextStyle(
            fontFamily: 'OpenSans',
            fontWeight: FontWeight.w300,
            fontSize: 14,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          value,
          style: const TextStyle(
            fontFamily: 'OpenSans',
            fontWeight: FontWeight.w700,
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  /// Title Section
  Column _titleSection() {
    return Column(
      children:  <Widget>[

        Container(
          width: 400,
          child: Column(
            children: [
              Text(
                userdata['username'],
                style: TextStyle(
                  fontFamily: 'NimbusSanL',
                  fontWeight: FontWeight.w700,
                  fontSize: 30,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 8,
        ),
        Container(
          width: 400,
          child: Column(
            children: [
              Text(
                userdata['bio'],
                style: TextStyle(
                  fontFamily: 'NimbusSanL',
                  fontStyle: FontStyle.italic,
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 8,
        ),
        Row(
          children: [
            Container(
              width: 240,
              child: Text(
                userdata['email'],
                style: TextStyle(
                  fontFamily: 'NimbusSanL',
                  fontStyle: FontStyle.italic,
                  fontSize: 16,
                ),
              ),
            ),
            Container(
              width: 100,
              child: Text(
                userdata['phone'],
                style: TextStyle(
                  fontFamily: 'NimbusSanL',
                  fontStyle: FontStyle.italic,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
