import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:graduation_1/Components/User.dart';
import 'package:graduation_1/screens/profile_screen.dart';

import 'Chat_ID_screen.dart';


class SearchChatScreen extends StatefulWidget {
  const SearchChatScreen({Key? key}) : super(key: key);

  @override
  State<SearchChatScreen> createState() => _SearchChatScreenState();
}

class _SearchChatScreenState extends State<SearchChatScreen> {
  final TextEditingController searchController = TextEditingController();
  bool isShowUsers = false;

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Form(
          child: TextFormField(
            controller: searchController,
            decoration:
            const InputDecoration(hintText: 'Search'),

            onFieldSubmitted: (String _) {
              setState(() {
                isShowUsers = true;
              });
            //  print(_);
            },
          ),
        ),
      ),
      body:
      isShowUsers ?
      FutureBuilder(
        future: FirebaseFirestore.instance
            .collection('Users')
            .where(
          'username',
          isGreaterThanOrEqualTo: searchController.text,)
            .get(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            itemCount: (snapshot.data! as dynamic).docs.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: ()
                => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => CHAT_ID_Screen(
                      
                      uid: (snapshot.data! as dynamic).docs[index]['uid'],
                    ),
                  ),
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(
                      (snapshot.data! as dynamic).docs[index]['photoUrl'],
                    ),
                    radius: 16,
                  ),
                  title: Text(
                    (snapshot.data! as dynamic).docs[index]['username'],
                  ),
                ),
              );
            },
          );
        },
      )
          : FutureBuilder(
                  future: FirebaseFirestore.instance
              .collection('Users')
              //.orderBy('datePublished')
             .get(),
             builder: (context,
             AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot)
        {
              if (!snapshot.hasData) {
                  return const Center(
                       child: CircularProgressIndicator(),
                     );
          }
          return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) =>User_card(snapshot: snapshot.data!.docs[index].data(),
                ),
          );
        },),
    );
  }
}

