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
      appBar: width >webScreenSize ? null
          : AppBar(
        backgroundColor: Colors.blue,
        centerTitle: false,
        title:  const Text('EVENT' ,
          style: TextStyle(
            color: tealColor,
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
              Container(
                //     color: Colors.amber,
                margin: const EdgeInsets.only(top: 2,bottom: 2),
                padding: const EdgeInsets.only(top: 2),
                height: 20,
                child: Row(
                  children: [

                  ],
                ),
              ),
              Container(
                color: Colors.black,
                height: 2,
              ),


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

      /*  StreamBuilder(
          stream: FirebaseFirestore.instance.collection('posts').snapshots(),
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
                    child: PostCard(
                    snapshot: snapshot.data!.docs[index].data() ,

                    ),
                  ),
                );
          }
        ),*/
    );
  }

  isPost() {}
}