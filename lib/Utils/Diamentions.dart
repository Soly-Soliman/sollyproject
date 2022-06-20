import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:graduation_1/screens/Chat/Chat_Screen_test.dart';
import 'package:graduation_1/screens/feed/add_post_screen.dart';
import 'package:graduation_1/screens/feed/feed_screen.dart';
import 'package:graduation_1/screens/Google/google_map_screen.dart';
import 'package:graduation_1/screens/profile/profile_screen.dart';



const webScreenSize = 600; // عشان يبقي زي الويب كدا مثلا

List <Widget> homeScreenItems =[
  FeedScreen(),
  AddPostScreen(),
  SearchChatScreen(),
 // ChatsScreen(),
  ProfileScreen(uid:  FirebaseAuth.instance.currentUser!.uid,
  ),



];