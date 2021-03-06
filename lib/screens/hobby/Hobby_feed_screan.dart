import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:graduation_1/Components/Hobby_Card.dart';
import 'package:graduation_1/Components/event_card.dart';
import 'package:graduation_1/Utils/Diamentions.dart';
import 'package:graduation_1/Utils/colors.dart';
import 'package:graduation_1/screens/hobby/search_Hobby.dart';
import 'package:graduation_1/screens/search_screen.dart';

class HobbyFeed extends StatefulWidget {
  const HobbyFeed ({ Key? key }) : super(key: key);

  @override
  State<HobbyFeed> createState() => _HobbyFeedState();
}

class _HobbyFeedState extends State<HobbyFeed> {
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
        title:  const Text('Hobby' ,

          style: TextStyle(
            color: black,
            fontFamily: 'Sofiar'
          ),
        ),
        //هنا المفروض هيبقي اللوجو
        actions: [
          IconButton(onPressed: (){
            Navigator.push(context,MaterialPageRoute(builder: (context) =>const SearchHobbyScreen()));
          },
            icon: const Icon(Icons.search_outlined, color: primary),) ,

        ],
      ),
      body:  SafeArea
        (

          child: Column(
            children: [
               Expanded(
                child:
                StreamBuilder(
                  stream: FirebaseFirestore.instance.collection('Hobby').snapshots(),
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
                        child: Hobby_Card(
                          snapshot: snapshot.data!.docs[index].data() ,

                        ),
                      ),
                    );
                  }
              ),)
            ],
          )
      ),
    );
  }

  isPost() {}
}