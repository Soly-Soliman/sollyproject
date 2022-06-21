import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation_1/Components/post_card.dart';
import 'package:graduation_1/Utils/Diamentions.dart';
import 'package:graduation_1/Utils/colors.dart';
import 'package:graduation_1/screens/event/events_feed_screan.dart';
import 'package:graduation_1/screens/profile/profile_screen.dart';
import 'package:graduation_1/screens/search_screen.dart';
import '../../resourses/aut_methods.dart';
import '../AboutAPP.dart';
import '../Chalanges/ch_feed_screan.dart';
import '../Experts/Expert_feed_screan.dart';
import '../hobby/Hobby_feed_screan.dart';
import '../hobby/Hoppey_Data_feed_screan.dart';
import '../feedback/add_feedback_screen.dart';
import 'feed_users_screen.dart';
import '../Google/google_map_screen.dart';
import '../SignUp_SignIn/login_screen.dart';
class FeedScreen extends StatefulWidget {
  const FeedScreen ({ Key? key }) : super(key: key);
  @override
  State<FeedScreen> createState() => _FeedScreenState();
}
class _FeedScreenState extends State<FeedScreen> {
  @override
  Widget build(BuildContext context) {
    final width =MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
          appBar: width >webScreenSize ? null
              : AppBar(
                   backgroundColor:selection ,
                   foregroundColor: black,

                     flexibleSpace: Row(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 mainAxisAlignment: MainAxisAlignment.start,
                   children: [
                SizedBox(
                  width: 5,
                  height: 55,
                  child: Container(

                  ),
                ),
              ],
            ),

                  centerTitle: true,
                    title:  const Text('HOBBY' ,
                   style: TextStyle(
                     color: black,
                     fontFamily: 'Sofiar',
                     fontSize: 30,
                     fontWeight: FontWeight.bold,
                     ),
                ),
                       actions: [
                IconButton(onPressed: (){
                    Navigator.push(context,MaterialPageRoute(builder: (context) =>const SearchScreen()));
               },
                         icon: const Icon(Icons.search_outlined, color: black,),) ,
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
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 12),
                      width: double.infinity,
                      height: 110,
                      color: primary,
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.all(10),
                                child:  SizedBox(height: 30 ,width: 90,child:  Text(

                                  'Hobby',
                                  style: TextStyle(color: black ,fontFamily: 'Trocchi',fontSize: 25 ,),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  textAlign: TextAlign.justify,

                                ) ,),
                              ),
                              Container(
                                width: 100,
                                height: 60,
                                child: Image(
                                  image: AssetImage('images/logo3.png'),
                                ),
                                decoration: BoxDecoration(
                                  //  color: primary,
                                    image: DecorationImage(
                                      image: AssetImage(
                                          ''
                                      ),
                                    )
                                ),
                              ),
                              const SizedBox(height: 10 ,width: 10,),


                            ],
                          ),
                          const   SizedBox(height: 10,) ,
                          Row(
                            children: [
                              const SizedBox(height: 10 ,width: 10,),
                              Text(
                                'To be Happy,Find Your Hobby',
                                style: TextStyle(color: black ,fontFamily: 'Trocchi',fontSize: 16 ,),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                textAlign: TextAlign.justify,

                              ),
                            ],
                          ),
                        ],
                      ),

                    ),
                    SizedBox(height: 30,width: 10,) ,
                    Row(
                      children: [
                        SizedBox(height: 10,width: 10,) ,
                        InkWell(
                          onTap: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>  ProfileScreen(uid:  FirebaseAuth.instance.currentUser!.uid,)),
                            );
                          },
                          child: Container(

                              width: 180,
                              height: 45,
                              decoration: BoxDecoration(borderRadius: BorderRadiusDirectional.circular(20),
                                color: primary,
                              ),
                              child: const Center(child: Text('Profile',style: TextStyle(color: black,fontSize: 15,fontFamily: 'Trocchi'),))),
                        ),
                      ],
                    ) ,
                    SizedBox(height: 20,width: 10,) ,
                    Row(
                      children: [
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
                              child: const Center(child: Text('About The APP',style: TextStyle(color:black,fontSize: 15,fontFamily: 'Trocchi'),))),
                        ),
                      ],
                    ) ,
                    SizedBox(height: 20,width: 10,) ,
                    Container(
                      margin: EdgeInsets.only(left: 10),
                      width: 180,
                      height: 45,
                      decoration: BoxDecoration(borderRadius: BorderRadiusDirectional.circular(20),
                        color: primary,
                      ),
                      child: InkWell(
                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>  FeedUsers__Screen()),
                          );
                        },
                        child: Row(
                          children: [
                            Text('  All Users ' ,textAlign: TextAlign.center,style: TextStyle(color: black ,fontSize: 18 ,fontFamily: 'Trocchi'),),
                            SizedBox(width: 15,),
                            Icon(

                                Icons.people_outline)
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                     InkWell(
                      onTap: ()
                      {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=> const Add_feedback(),),) ;
                      }
                      ,
                      child: Container(
                        margin: EdgeInsets.only(left: 10),
                        width: 180,
                        height: 45,
                        decoration: BoxDecoration(borderRadius: BorderRadiusDirectional.circular(20),
                          color: primary,
                        ),
                        child: Row(
                          children: [
                            Text('    FeedBack ' ,style: TextStyle(color: black ,fontSize: 18 ,fontFamily: 'Trocchi'),),
                            SizedBox(width: 15,),
                            Icon(Icons.mail_sharp,size: 18,color: black,),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                    InkWell(
                      onTap: ()
                      {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>  GoogleMapPage(),),) ;
                      }
                      ,
                      child: Container(
                        margin: EdgeInsets.only(left: 10),
                        width: 180,
                        height: 45,
                        decoration: BoxDecoration(borderRadius: BorderRadiusDirectional.circular(20),
                          color: primary,
                        ),
                        child: Row(
                          children: [
                            Text('    Neerby Peoble ' ,style: TextStyle(color: black ,fontSize: 14,fontFamily: 'Trocchi'),),
                            SizedBox(width: 15,),
                            Icon(Icons.location_on,size: 18,color: black,),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                    InkWell(
                      onTap: (){
                        AuthMethod().SignOut();
                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> const LoginScreen(),),) ;
                      },
                      child: Container(
                        margin: EdgeInsets.only(left: 10),
                        width: 180,
                        height: 45,
                        decoration: BoxDecoration(borderRadius: BorderRadiusDirectional.circular(20),
                          color: primary,
                        ),
                        child: Row(
                          children: [
                            Text('    Sing out ' ,style: TextStyle(color: black ,fontSize: 18 ,fontFamily: 'Trocchi'),),
                            SizedBox(width: 15,),
                            IconButton(onPressed: () async{
                              await AuthMethod().SignOut();
                              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> const LoginScreen(),),) ;
                            }, icon: Icon(Icons.logout_outlined),),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

              ],
            ),

          ),

        ),
          body:  SafeArea(

            child: Scaffold(
              floatingActionButton: FloatingActionButton(
                child: Icon(Icons.start),
                foregroundColor: black,
                focusColor:selection2 ,
                backgroundColor:selection ,
               onPressed: () {Navigator.push(
                 context,
                 MaterialPageRoute(
                     builder: (context) => const Expert_Feed()),
               );},
              ),
              backgroundColor: blue1,
              body: Column(
                children: [

                  Container(
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
                                 color: black,
                                   fontFamily: 'Trocchi'
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
                                   builder: (context) => const HobbyFeed()),
                             );},
                             child: const Text(
                               'hobby',
                               style: TextStyle(
                                 fontSize: 13,
                                 color: black,
                                   fontFamily: 'Trocchi',
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
                                   builder: (context) => const Chs_FeedScreen()),
                             );},
                             child: const Text(
                               'Challange',
                               style: TextStyle(
                                 fontSize: 11,
                                 color: black,
                                 fontFamily: 'Trocchi' ,
                                 fontWeight: FontWeight.w500 ,

                               ),
                             ),
                           ),
                         ),

                       ),
                       Expanded(

                         child: Container(
                           padding: const EdgeInsets.all(4),
                           child: MaterialButton(

                             color: selection4,
                             onPressed: () {
                               Navigator.push(
                               context,
                               MaterialPageRoute(
                                   builder: (context) => const HoppyFeedScreen()),
                             );},
                             child: const Text(
                               'Custom ',
                               style: TextStyle(
                                 fontSize: 18,
                                 color: primary,
                                 fontFamily: 'Sofiar',
                               ),
                             ),
                           ),
                         ),

                       )
                     ],
                   ),
                  ),
                  Container(
                    color: black,
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

      ),
       ),
    );
  }


}