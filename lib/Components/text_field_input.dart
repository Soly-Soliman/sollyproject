import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFieldInput extends StatelessWidget{
  final TextEditingController textEditingController;
  final bool isPass ;
  final  String hinttext ;
  final TextInputType textInputType ;
  final  String lapel ;

  const TextFieldInput({
  Key?key ,
  required this.textEditingController ,
  required this.hinttext ,
  required this.lapel ,
  required this.textInputType ,
   this.isPass = false,
  } ) : super (key: key);


 @override
  Widget build(BuildContext context){
   final inputBoreder = OutlineInputBorder(
     borderSide: Divider.createBorderSide(context),);
   return TextField(
     controller: textEditingController,
     decoration:  InputDecoration(
       hintText: hinttext,

       border:inputBoreder ,
       focusedBorder:inputBoreder ,
       enabledBorder: inputBoreder,
       filled: true ,
       contentPadding: const EdgeInsets.all(8) ,

     ),
     keyboardType:textInputType ,
     obscureText: isPass,
   );
 }
}