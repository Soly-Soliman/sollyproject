import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation_1/Components/comment_card.dart';
import 'package:graduation_1/Utils/colors.dart';
import 'package:graduation_1/resourses/firestore_methods.dart';
import 'package:provider/provider.dart';

import '../Components/text_field_input.dart';
import '../models/user.dart';
import '../providers/user_provider.dart';

class HobbyCommentsScreen extends StatefulWidget {
  final snapshot;
  //final String Comment ;
  const HobbyCommentsScreen({Key? key, required this.snapshot}) : super(key: key);

  @override
  _HobbyCommentsScreenState createState() => _HobbyCommentsScreenState();
}

class _HobbyCommentsScreenState extends State<HobbyCommentsScreen> {
  final TextEditingController _commentController = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    _commentController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<UserProvider>(context).getUser;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: selection,
        title: const Text(
          'Comments',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: false,
      ),
      //////////////////////////////////////////////
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('Hobby')
              .doc(widget.snapshot['HobbyID'])
              .collection('comments')
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
              itemBuilder: (context, index) => CommentCard(
                snap: snapshot.data!.docs[index].data(),
              ),
            );
          }),
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
                    controller: _commentController,
                    decoration: InputDecoration(
                      border: null,
                      hintText: 'Comment as ${user.username}',
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
                onTap: () async {
                  FireStoreMethods().Hobbycomment(
                      widget.snapshot['HobbyID'],
                      _commentController.text,
                      user.uid,
                      user.username,
                      user.photoUrl);
                  setState(() {
                    _commentController.text = '';
                  });
                },
                child: Container(
                  padding:
                  const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  child: const Icon(
                    Icons.ads_click_rounded,
                    color: Colors.blue,
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
