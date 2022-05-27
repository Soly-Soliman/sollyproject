import 'package:flutter/material.dart';
import 'package:graduation_1/Utils/Diamentions.dart';
import 'package:graduation_1/providers/user_provider.dart';
import 'package:provider/provider.dart';
class responsive extends StatefulWidget
{
  final Widget webScreenLayout ;
  final Widget mobileScreenLayout ;
  const responsive({
    Key? key ,
    required  this.webScreenLayout ,
    required this.mobileScreenLayout})
    : super(key :key) ;

  @override
  State<responsive> createState() => _responsiveState();
}

class _responsiveState extends State<responsive> {

  @override
  void initState() {
    super.initState();
    addData();
  }
  addData()async{
    UserProvider _userProvider = Provider.of<UserProvider>(context,listen: false) ;
    await _userProvider.refreshUser ();
  }



  @override
  Widget build(BuildContext context){
    return LayoutBuilder(
        builder: (context ,constraints) {
     if(constraints.maxWidth > webScreenSize) {
       // web screen   if   not we will path it to mobile screen
       return widget.webScreenLayout ;
     }
     // هنا هنبني الموبايل سكرين ي صاحبي
      return widget.mobileScreenLayout ;
    }
    ) ;
  }
}