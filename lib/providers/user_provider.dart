import 'package:flutter/material.dart';
import 'package:graduation_1/models/user.dart';
import 'package:graduation_1/resourses/aut_methods.dart';

 class UserProvider with ChangeNotifier{
   User? _user ;
   final AuthMethod _authMethod =AuthMethod() ;


   User get getUser =>_user!;

   Future<void> refreshUser()async{
     User user = await  _authMethod.getUserDetails();
     _user = user ;
     notifyListeners();

   }
 }