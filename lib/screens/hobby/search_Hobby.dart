import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:graduation_1/Components/Hobby_Card.dart';
import 'package:graduation_1/Components/event_card.dart';
import '../../Utils/colors.dart';


class SearchHobbyScreen extends StatefulWidget {
  const SearchHobbyScreen({Key? key}) : super(key: key);

  @override
  State<SearchHobbyScreen> createState() => _SearchHobbyScreenState();
}

class _SearchHobbyScreenState extends State<SearchHobbyScreen> {
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
            .collection('Hobby')
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
                  itemBuilder:  (context, index) =>Hobby_Card(
                      snapshot: (snapshot.data!as dynamic).docs[index].data(),

                  ),
                );


        },
      )
          : FutureBuilder(
                  future: FirebaseFirestore.instance
                   .collection('Hobby')
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
                    itemBuilder: (context, index) =>Hobby_Card(
                      snapshot: snapshot.data!.docs[index].data(),
                    ),
                  );
          },),
    );
  }
}

/*
 ListView.builder(
            itemCount: (snapshot.data! as dynamic).docs.length,
            itemBuilder: (context, index) {
              return
                InkWell(
                  onTap: (){}
                ,
                  child: Card(
                   child: Row(
                     children: [
                       Container(

                       ),
                       CircleAvatar(

                          backgroundImage: NetworkImage(
                            (snapshot.data! as dynamic).docs[index]['EventUrl'],
                          ),
                          radius: 36,
                        ),
                          Text(
                            (snapshot.data! as dynamic).docs[index]['name'],)
                     ],
                   ),

                    ),

                );
            }


          );
 */