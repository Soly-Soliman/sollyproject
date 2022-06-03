import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:graduation_1/Utils/Diamentions.dart';

import '../Components/User.dart';
class FeedUsersScreen extends StatefulWidget {
  const FeedUsersScreen ({ Key? key }) : super(key: key);

  @override
  State<FeedUsersScreen> createState() => _FeedUsersScreenState();
}

class _FeedUsersScreenState extends State<FeedUsersScreen> {
  @override
  Widget build(BuildContext context) {
    final width =MediaQuery.of(context).size.width;

    return Scaffold(
        body:  SafeArea
           (
          child: Column(
            children: [
              Container(
                color: Colors.black,
                height: 2,
              ),

             Expanded(
                child:
                StreamBuilder(
                  stream: FirebaseFirestore.instance.collection('Users').snapshots(),
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
                        child: User_card(
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