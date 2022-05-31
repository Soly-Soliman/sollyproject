import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation_1/Components/comment_card.dart';
import 'package:graduation_1/Utils/colors.dart';
import 'package:graduation_1/resourses/firestore_methods.dart';
import 'package:provider/provider.dart';

import '../Components/Massage_Card.dart';
import '../Components/text_field_input.dart';
import '../models/user.dart';
import '../providers/user_provider.dart';

class ChatFinalScreen extends StatefulWidget {
  final snapshot;
  //final String Comment ;
  const ChatFinalScreen({Key? key, required this.snapshot}) : super(key: key);

  @override
  _ChatFinalScreenState createState() => _ChatFinalScreenState();
}

class _ChatFinalScreenState extends State<ChatFinalScreen> {
  final TextEditingController _MassageController = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    _MassageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<UserProvider>(context).getUser;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text(
          'Massages',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: false,
      ),
      //////////////////////////////////////////////
      body:const SafeArea(
        child: Text(
          '555'
        ),
      )

      /*StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('Users')
                .doc(widget.uid)
              //.doc(widget.snapshot['uid'])
              .collection('Massages')
          //.orderBy('datePublished',descending: true)
              .snapshots(),
          builder: (context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) => Massage_Card(
                snap: snapshot.data!.docs[index].data(),
              ),
            );
          }),*/ ,
      //////////////////////////////////////////////
      bottomNavigationBar: SafeArea(
        child: Container(
          margin:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          padding: const EdgeInsets.only(left: 16, right: 8),
          child: Row(
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
                    /*TextFieldInput (
                   lapel: 'Comment',
                   hinttext: 'Comment...',
                   textEditingController: ,
                   isPass: false,
                   textInputType: TextInputType.text,*/
                  ),
                ),
              ),
              InkWell(
                onTap: () async

                {},

               /* {
                  FireStoreMethods().SendMassage(

                      MassageID, text, uid, Reciverid,

                      ProfilePicture)
                  setState(() {
                    _MassageController.text = '';
                  });
                },*/
                child: Container(
                  padding:
                  const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  child: const Icon(
                    Icons.ads_click_rounded,
                    color: Colors.teal,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
