import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:graduation_1/screens/add_post_screen.dart';
import 'package:graduation_1/screens/feed_screen.dart';
import 'package:graduation_1/screens/google_map_screen.dart';
import 'package:graduation_1/screens/profile_screen.dart';

const webScreenSize = 600; // عشان يبقي زي الويب كدا مثلا

List <Widget> homeScreenItems =[
  FeedScreen(),
  AddPostScreen(),
  Text('Chat'),
  //GoogleMapPage() ,
  ProfileScreen(uid:  FirebaseAuth.instance.currentUser!.uid,),



];