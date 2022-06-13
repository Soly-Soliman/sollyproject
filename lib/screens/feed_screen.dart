import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:graduation_1/Components/post_card.dart';
import 'package:graduation_1/Utils/Diamentions.dart';
import 'package:graduation_1/Utils/colors.dart';
import 'package:graduation_1/screens/events_feed_screan.dart';
import 'package:graduation_1/screens/feed_users_screen.dart';
import 'package:graduation_1/screens/search_screen.dart';

import 'Hoppey_feed_screan.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen ({ Key? key }) : super(key: key);

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  @override
  Widget build(BuildContext context) {
    final width =MediaQuery.of(context).size.width;
    bool _isevent = false;



    return Scaffold(
        appBar: width >webScreenSize ? null
            : AppBar(
          backgroundColor: Colors.lightBlue.shade600,
          centerTitle: false,
          title:  const Text('HOBBY APP' ,
          style: TextStyle(
            color: tealColor,
          ),
          ),
            //هنا المفروض هيبقي اللوجو
         actions: [
              IconButton(onPressed: (){
                  Navigator.push(context,MaterialPageRoute(builder: (context) =>const SearchScreen()));
             },
                       icon: Icon(Icons.search_outlined, color: Colors.white,),) ,
         //  IconButton(onPressed: (){
           //  Navigator.push(context,MaterialPageRoute(builder: (context) =>const FeedUsersScreen()));
        //   },
         //    icon: Icon(Icons.send, color: Colors.white,),) ,
         ],
        ),
        body:  SafeArea
           (

          child: Column(
            children: [

              Container(
           //     color: Colors.amber,
                margin: EdgeInsets.only(top: 0,bottom: 2),

                height: 37,
               child: Row(
                 children: [
                   Expanded(
                     child: MaterialButton(
                       color: Colors.lightBlue.shade500,
                       onPressed: () {Navigator.push(
                         context,
                         MaterialPageRoute(
                             builder: (context) => const EventsFeedScreen()),
                       );},
                       child: const Text(
                         'Events',
                         style: TextStyle(
                           color: Colors.black,
                         ),
                       ),
                     ),

                   ),
                   Expanded(
                     child: MaterialButton(
                       color: Colors.lightBlue.shade500,
                       onPressed: () {Navigator.push(
                         context,
                         MaterialPageRoute(
                             builder: (context) => const HoppyFeedScreen()),
                       );},
                       child: const Text(
                         'Hoppies',
                         style: TextStyle(
                           color: Colors.black,
                         ),
                       ),
                     ),

                   )
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
              ),)

            ],
          ),

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


}