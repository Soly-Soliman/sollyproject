

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:graduation_1/Components/Massage_Card.dart';
import 'package:graduation_1/Utils/utils.dart';
import 'package:graduation_1/block/massages/cubitsocial.dart';
import 'package:graduation_1/models/Massage.dart';
import 'package:graduation_1/providers/user_provider.dart';
import 'package:graduation_1/resourses/firestore_methods.dart';
import 'package:provider/provider.dart';
import '../../Components/post_card.dart';
import '../../Utils/colors.dart';
import '../../models/user.dart';



class CHAT_ID_Screen extends StatefulWidget {
  final String uid;



  const CHAT_ID_Screen({Key? key, required this.uid,}) : super(key: key);

  @override
  _CHAT_ID_ScreenState createState() => _CHAT_ID_ScreenState();
}

class _CHAT_ID_ScreenState extends State<CHAT_ID_Screen> {
  final TextEditingController _MassageController = TextEditingController();
  List<MessageModel>message = [];
  @override
  void dispose() {
    super.dispose();
    _MassageController.dispose();
  }

  var userdata = {};
  late String ReciverID ;
  int postlenght = 0;

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

     ReciverID = widget.uid;

      // var MassageSnap = await FirebaseFirestore.instance
      //
      //     .collection('Users')
      //     .doc(widget.uid)
      //     .collection('Massages')
      //     .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
      //     .get();




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



    final user = Provider.of<UserProvider>(context).getUser;
    if (isLoading) {
      return const Center(
            child: CircularProgressIndicator(),
          );
    } else {
      return SafeArea(
        child: Scaffold(
          backgroundColor: primary,
            appBar: AppBar(
              backgroundColor:selection ,
              foregroundColor: black,
              flexibleSpace:
            Row(
              children: [

                const SizedBox(width: 50,),
                CircleAvatar(
                  backgroundColor: Colors.grey,
                  radius: 25,
                  backgroundImage:
                  NetworkImage(userdata['photoUrl']),

                ),
                const SizedBox(width: 25,),
                Text(
                  userdata['username'],
                  style: const TextStyle(
                      color: black, fontSize: 25),
                ),
              ],
            ),
            )
          ,
              body:
              FirebaseAuth.instance.currentUser!.uid ==
                  widget.uid
                  ?Text(
                userdata['username'],
                style: const TextStyle(
                    color: Colors.black, fontSize: 25),
              ):
                          StreamBuilder(
                              stream:
                              FirebaseFirestore.instance
                                  .collection('Users').doc(user.uid)
                                  .collection('chats').doc(ReciverID)
                                  .collection('Massages')
                                  .snapshots(),
                              builder: (context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot)
                              {
                                if (snapshot.connectionState == ConnectionState.waiting) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                                return ListView.builder(
                                  itemCount: snapshot.data!.docs.length,
                                  itemBuilder: (context, index)=>Container(
                                    margin: EdgeInsets.symmetric(

                                    ),
                                    child: Massage_Card(
                                        snap:  snapshot.data!.docs[index].data(),

                                    ),
                                  ),
                                );
                              }


                ),

          bottomNavigationBar:
          SafeArea(

            child: Container(
              color: primary,
              margin:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
              padding: const EdgeInsets.only(left: 16, right: 8),
              child:
              FirebaseAuth.instance.currentUser!.uid ==
                  widget.uid
                  ? Text(
                userdata['username'],
                style: const TextStyle(
                    color: black, fontSize: 25),
              ):
              Row(
                children: [
                  InkWell(
                    onTap: () {},
                    child: Container(
                      padding: EdgeInsets.all(5),
                      margin: EdgeInsets.all(5),
                      // color: Colors.white,
                      child: CircleAvatar(
                        radius: 20,
                        backgroundImage: NetworkImage(user.photoUrl),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                      child: TextField(
                        controller: _MassageController,
                        decoration: InputDecoration(
                          border: null,
                          hintText: 'Massages as ${user.username}',
                        ),

                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () async
                    {
                     FireStoreMethods().SendMassage(_MassageController.text, user.uid, ReciverID ,user.photoUrl);
                      setState(() {
                        _MassageController.text= '';
                      });
                    },
                    child: Container(
                      
                      decoration: BoxDecoration(
                        color: selection3,
                        borderRadius: BorderRadius.circular(7),
                      ),
                      padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                      child: const Icon(
                        Icons.ads_click_rounded,
                        color :black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
            ),
      );
    }
  }
}

