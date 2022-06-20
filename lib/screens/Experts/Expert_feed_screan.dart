import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:graduation_1/Components/Hobby_Card.dart';
import 'package:graduation_1/Components/event_card.dart';
import 'package:graduation_1/Utils/Diamentions.dart';
import 'package:graduation_1/Utils/colors.dart';
import 'package:graduation_1/screens/Experts/search_Expert.dart';
import 'package:graduation_1/screens/hobby/search_Hobby.dart';
import 'package:graduation_1/screens/search_screen.dart';

import '../../Components/Work_Card.dart';
import 'add_Expert_screen.dart';

class Expert_Feed extends StatefulWidget {
  const Expert_Feed ({ Key? key }) : super(key: key);

  @override
  State<Expert_Feed> createState() => _Expert_FeedState();
}

class _Expert_FeedState extends State<Expert_Feed> {
  @override
  Widget build(BuildContext context) {
    final width =MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: blue1,
      appBar: width >webScreenSize ? null
          : AppBar(
        backgroundColor: selection,
        foregroundColor: black,
        centerTitle: false,
        title:  const Text('Experts' ,

          style: TextStyle(
            color: black,
            fontFamily: 'Sofiar'
          ),
        ),
        //هنا المفروض هيبقي اللوجو
        actions: [
          IconButton(onPressed: (){
            Navigator.push(context,MaterialPageRoute(builder: (context) =>const SearchExpertScreen()));
          },
            icon: const Icon(Icons.search_outlined, color: primary),) ,

        ],
      ),
      body:
      SafeArea
        (

          child: Scaffold(
            floatingActionButton: FloatingActionButton(
              child: Icon(Icons.add_circle_outline),
              foregroundColor: black,
              focusColor:selection2 ,
              backgroundColor:selection ,
              onPressed: () {Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const Add_Expert()),
              );},
            ),
            body: Column(
              children: [

                 Expanded(
                  child:
                  StreamBuilder(
                    stream: FirebaseFirestore.instance.collection('Work').snapshots(),
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
                            horizontal: width >webScreenSize?width*0.3 :0 ,
                            vertical: width >webScreenSize?15 :0 ,
                          ),
                          child: work_Card(
                            snapshot: snapshot.data!.docs[index].data() ,

                          ),
                        ),
                      );
                    }
                ),)
              ],
            ),
          )
      ),
    );
  }

  isPost() {}
}