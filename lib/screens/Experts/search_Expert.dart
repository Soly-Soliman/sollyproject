import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:graduation_1/Components/Hobby_Card.dart';
import 'package:graduation_1/Components/event_card.dart';
import '../../Components/Work_Card.dart';
import '../../Utils/colors.dart';


class SearchExpertScreen extends StatefulWidget {
  const SearchExpertScreen({Key? key}) : super(key: key);

  @override
  State<SearchExpertScreen> createState() => _SearchExpertScreenState();
}

class _SearchExpertScreenState extends State<SearchExpertScreen> {
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
     backgroundColor:blue1 ,
      appBar: AppBar(
        backgroundColor:selection ,
        foregroundColor: black,
        title: Form(
          child: TextFormField(
            controller: searchController,
            style: TextStyle(color: black ,fontSize: 18),
            decoration:
            const InputDecoration(hintText: 'Search',hintStyle: TextStyle(color: black ,fontSize: 16)),

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
            .collection('Work')
            .where('name', isGreaterThanOrEqualTo: searchController.text,)
            .get(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
                return ListView.builder(
                  itemCount: (snapshot.data! as dynamic).docs.length,
                  itemBuilder:  (context, index) =>work_Card(
                      snapshot: (snapshot.data!as dynamic).docs[index].data(),

                  ),
                );


        },
      )
          : FutureBuilder(
                  future: FirebaseFirestore.instance
                   .collection('Work')
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
                    itemBuilder: (context, index) =>work_Card(
                      snapshot: snapshot.data!.docs[index].data(),
                    ),
                  );
          },),
    );
  }
}
