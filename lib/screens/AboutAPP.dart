import 'package:flutter/material.dart';

import '../Utils/colors.dart';



class About extends StatelessWidget{
  const About({Key?key}) : super (key: key);
  @override
  Widget build(BuildContext context) {
     return  SafeArea(child: Scaffold(
       appBar: AppBar(
         backgroundColor:selection ,
         foregroundColor: primary,

       ),
       backgroundColor: blue1,
       body:
       SingleChildScrollView(
               child:Column(children: [
                 const SizedBox(height: 30,width: 10,) ,
                 Row(
                   children: [
                     const SizedBox(height: 10,width: 10,) ,
                     CircleAvatar(backgroundColor:selection2 , radius: 25,),
                     const SizedBox(height: 10,width: 10,) ,
                     Container(

                         width: 180,
                         height: 45,
                         decoration: BoxDecoration(borderRadius: BorderRadiusDirectional.circular(20),

                         ),
                         child: const Center(child: Text('Login',style: TextStyle(color: primary,fontSize: 15),))),
                   ],
                 ) ,
                 const SizedBox(height: 30,width: 10,) ,
                 Row(
                   children: [
                     const SizedBox(height: 10,width: 10,) ,
                     CircleAvatar(backgroundColor:selection2 , radius: 25,),
                     const SizedBox(height: 10,width: 10,) ,
                     Container(

                         width: 180,
                         height: 45,
                         decoration: BoxDecoration(borderRadius: BorderRadiusDirectional.circular(20),

                         ),
                         child: const Center(child: Text('Login',style: TextStyle(color: primary,fontSize: 15),))),
                   ],
                 ) ,
                 const SizedBox(height: 30,width: 10,) ,
                 Row(
                   children: [
                     const SizedBox(height: 10,width: 10,) ,
                     CircleAvatar(backgroundColor:selection2 , radius: 25,),
                     const SizedBox(height: 10,width: 10,) ,
                     Container(

                         width: 180,
                         height: 45,
                         decoration: BoxDecoration(borderRadius: BorderRadiusDirectional.circular(20),

                         ),
                         child: const Center(child: Text('Login',style: TextStyle(color: primary,fontSize: 15),))),
                   ],
                 ) ,
                 const SizedBox(height: 30,width: 10,) ,
                 Row(
                   children: [
                     const SizedBox(height: 10,width: 10,) ,
                     CircleAvatar(backgroundColor:selection2 , radius: 25,),
                     const SizedBox(height: 10,width: 10,) ,
                     Container(

                         width: 180,
                         height: 45,
                         decoration: BoxDecoration(borderRadius: BorderRadiusDirectional.circular(20),

                         ),
                         child: const Center(child: Text('Login',style: TextStyle(color: primary,fontSize: 15),))),
                   ],
                 ) ,
                 const SizedBox(height: 30,width: 10,) ,
                 Row(
                   children: [
                     const SizedBox(height: 10,width: 10,) ,
                     CircleAvatar(backgroundColor:selection2 , radius: 25,),
                     const SizedBox(height: 10,width: 10,) ,
                     Container(

                         width: 180,
                         height: 45,
                         decoration: BoxDecoration(borderRadius: BorderRadiusDirectional.circular(20),

                         ),
                         child: const Center(child: Text('About The App',style: TextStyle(color: primary,fontSize: 15),))),
                   ],
                 ) ,
               ],),
             )


       ),



     ) ;


  }
}