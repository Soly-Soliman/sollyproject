import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:graduation_1/Components/post_card.dart';
import 'package:graduation_1/Utils/Diamentions.dart';
import 'package:graduation_1/Utils/colors.dart';
import 'package:graduation_1/screens/events_feed_screan.dart';
import 'package:graduation_1/screens/search_screen.dart';
import 'package:graduation_1/screens/testing_profile.dart';
import 'AboutAPP.dart';
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



    return SafeArea(
      child: Scaffold(
          appBar: width >webScreenSize ? null
              : AppBar(
            backgroundColor:selection ,
            foregroundColor: primary,

            flexibleSpace: Row(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 mainAxisAlignment: MainAxisAlignment.start,
                   children: [
                   Container(
                  margin: const EdgeInsets.all(6),
                  padding: const EdgeInsets.only(left: 2),
                  //  color: Colors.amber,
                  child: IconButton(
                      onPressed:(){}

                  , icon: Icon(Icons.menu ,color: Colors.white,))
                  /*InkWell(
                    onTap: (){},
                    child: const CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.grey,
                     
                    ),
                  ),*/
                ),
                SizedBox(
                  width: 5,
                  height: 55,
                  child: Container(

                  ),
                ),
              ],
            ),

            centerTitle: true,
                    title:  const Text('HOBBY APP' ,
                   style: TextStyle(
                       color: mobileBackgroundColor,
                     ),
                ),
              //هنا المفروض هيبقي اللوجو
                       actions: [
                IconButton(onPressed: (){
                    Navigator.push(context,MaterialPageRoute(builder: (context) =>const SearchScreen()));
               },
                         icon: const Icon(Icons.search_outlined, color: Colors.white,),) ,
           //  IconButton(onPressed: (){
             //  Navigator.push(context,MaterialPageRoute(builder: (context) =>const FeedUsersScreen()));
          //   },
           //    icon: Icon(Icons.send, color: Colors.white,),) ,
           ],
          ),
        drawer: Drawer(
          backgroundColor: selection,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: double.infinity,
                  height: 5,
                  color: selection,

                ),

                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left:20.0),
                      child: CircleAvatar(
                        radius: 28,
                        backgroundColor: selection2,
                        child:  const CircleAvatar(
                          radius: 24.0,

                        ),
                      ),
                    ),
                    const SizedBox(height: 30 ,width: 10,),
                    Column(
                      children: const [
                        const SizedBox(height: 30 ,width: 10,),
                        Text(
                          'SUlly@gmail.com',
                          style: TextStyle(color: primary),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          textAlign: TextAlign.justify,
                        ),
                     const   SizedBox(height: 30,) ,


                      ],
                    ),

                  ],
                ),
                SizedBox(height: 30,width: 10,) ,
                Row(
                  children: [
                    SizedBox(height: 10,width: 10,) ,
                    CircleAvatar(backgroundColor:selection2 , radius: 25,),
                    SizedBox(height: 10,width: 10,) ,
                    InkWell(
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const About()),
                        );
                      },
                      child: Container(

                          width: 180,
                          height: 45,
                          decoration: BoxDecoration(borderRadius: BorderRadiusDirectional.circular(20),
                            color: primary,
                          ),
                          child: const Center(child: Text('About The APP',style: TextStyle(color: Colors.black,fontSize: 15),))),
                    ),
                  ],
                ) ,
                SizedBox(height: 30,width: 10,) ,
                        Row(
                          children: [
                            SizedBox(height: 10,width: 10,) ,
                            CircleAvatar(backgroundColor:selection2 , radius: 25,),
                            SizedBox(height: 10,width: 10,) ,
                            InkWell(
                              onTap: (){
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>  ProfilePage()),
                                );
                              },
                              child: Container(

                                width: 180,
                                height: 45,
                                decoration: BoxDecoration(borderRadius: BorderRadiusDirectional.circular(20),
                                  color: primary,
                                ),
                                child: const Center(child: Text('About The APP',style: TextStyle(color: Colors.black,fontSize: 15),))),
                            ),
                          ],
                        ) ,


              ],
            ),
          ),

        ),
          body:  SafeArea
             (

            child: Column(
              children: [

                Container(
             //     color: Colors.amber,
                  margin: const EdgeInsets.only(top: 0,bottom: 2),

                  height: 37,
                 child: Row(
                   children: [
                     Expanded(
                       child: Container(
                         height: 30,
                         width: 60,
                         padding: const EdgeInsets.all(3),
                         child: MaterialButton(
                         //  color: Colors.lightBlue.shade500,
                           color: selection2,
                           height: 10,
                           minWidth: 40,
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

                     ),
                     Expanded(
                       child: Container(
                         height: 30,
                         width: 60,
                         padding: const EdgeInsets.all(3),
                         child: MaterialButton(
                           //  color: Colors.lightBlue.shade500,
                           color: selection2,
                           height: 10,
                           minWidth: 40,
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

                     ),
                     Expanded(
                       child: Container(
                         height: 30,
                         width: 60,
                         padding: const EdgeInsets.all(3),
                         child: MaterialButton(
                           //  color: Colors.lightBlue.shade500,
                           color: selection2,
                           height: 10,
                           minWidth: 40,
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

                     ),
                     Expanded(
                       
                       child: MaterialButton(
                         padding: const EdgeInsets.all(10),
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
       ),
    );
  }


}