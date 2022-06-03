import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:graduation_1/Components/event_card.dart';
import 'package:graduation_1/Utils/Diamentions.dart';
import 'package:graduation_1/Utils/colors.dart';
import 'package:graduation_1/screens/search_screen.dart';

class HoppyFeedScreen extends StatefulWidget {
  const HoppyFeedScreen ({ Key? key }) : super(key: key);

  @override
  State<HoppyFeedScreen> createState() => _HoppyFeedScreenState();
}

class _HoppyFeedScreenState extends State<HoppyFeedScreen> {
  @override
  Widget build(BuildContext context) {
    final width =MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: width >webScreenSize ? null
          : AppBar(
        backgroundColor: Colors.blue.shade200,
        centerTitle: false,
        title:  const Text('APP LOGO' ,
          style: TextStyle(
            color: tealColor,
          ),
        ),
        //هنا المفروض هيبقي اللوجو
        actions: [
          IconButton(onPressed: (){
            Navigator.push(context,MaterialPageRoute(builder: (context) =>const SearchScreen()));
          },
            icon: const Icon(Icons.search_outlined, color: Colors.red,),) ,

        ],
      ),
      body:  SafeArea
        (

        child: Center(child: Text("الهوايات ")),
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