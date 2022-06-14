import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:graduation_1/Components/event_card.dart';
import 'package:graduation_1/Utils/Diamentions.dart';
import 'package:graduation_1/Utils/colors.dart';
import 'package:graduation_1/screens/search_screen.dart';

class EventsFeedScreen extends StatefulWidget {
  const EventsFeedScreen ({ Key? key }) : super(key: key);

  @override
  State<EventsFeedScreen> createState() => _EventsFeedScreenState();
}

class _EventsFeedScreenState extends State<EventsFeedScreen> {
  @override
  Widget build(BuildContext context) {
    final width =MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: blue1,
      appBar: width >webScreenSize ? null
          : AppBar(
        backgroundColor: selection,
        centerTitle: false,
        title:  const Text('Events' ,
          style: TextStyle(
            color: primary,
          ),
        ),
        //هنا المفروض هيبقي اللوجو
        actions: [
          IconButton(onPressed: (){
            Navigator.push(context,MaterialPageRoute(builder: (context) =>const SearchScreen()));
          },
            icon: const Icon(Icons.search_outlined, color: Colors.white),) ,

        ],
      ),
      body:  SafeArea
        (

          child: Column(
            children: [
               Expanded(
                child:
                StreamBuilder(
                  stream: FirebaseFirestore.instance.collection('events').snapshots(),
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
                        child: EventCard(
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