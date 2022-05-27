import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:graduation_1/Components/post_card.dart';
import 'package:graduation_1/models/Post.dart';
import 'package:graduation_1/screens/profile_screen.dart';
import '../Utils/Diamentions.dart';
import '../Utils/colors.dart';


class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
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
              print(_);
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
                    builder: (context) => ProfileScreen(
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
                   .collection('posts')
                 //  .orderBy('datePublished')
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
                    itemBuilder: (context, index) =>PostCard(
                      snapshot: snapshot.data!.docs[index].data(),
                    ),
                  );
          },),
    );
  }
}

