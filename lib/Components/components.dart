
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../Utils/colors.dart';
void navigatto(context,widget)=>Navigator.push(context,
  MaterialPageRoute(builder:
      (context)=>widget
  ),);

Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.blue,
  required Function function,
  required String text,

})=>  Container(
  width: width,
  height: 40.0,
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(15.0),
    color: background,

  ),
  child: MaterialButton(
    onPressed:() {

    } ,
    child: Text(
      text.toUpperCase(),
      style: TextStyle(fontSize: 20.0),
    ),
  ),
);

enum ToastState{SUCCESS,ERROR,Warning}
Color? choosetoast(ToastState state){
  Color color ;
  switch(state)
  {

    case ToastState.SUCCESS:
      {
        color =  Colors.green;
        break;
      }
    case ToastState.ERROR:
      color =  Colors.red;
      break;
    case ToastState.Warning:
      color =  Colors.yellow;
      break;
  }
  return color;
}
void navigatandfinsh(context,widget)=>Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder:
        (context)=>widget
    ),
        (Route<dynamic> route)=>false
);
Widget ?defalutAppBar({
  required BuildContext context,
  String ?title,
  List<Widget> ?actions,
}) =>AppBar(
  leading: IconButton(
    onPressed: (){
      Navigator.pop(context);
    },
    icon: const Icon(
        Icons.arrow_left
    ),
  ),
  title: Text(title!),
  actions: actions,
);

Widget lineavater()=>Padding(
  padding: const EdgeInsets.all(8.0),
  child: Container(
    width: double.infinity,
    height: 1.0,
    color: Colors.grey[300],
  ),
);
Widget ItemDrawer({
  required String title,
  required IconData iconData,
})=> Padding(
  padding: const EdgeInsets.all(15.0),
  child: Row(
    children:  [
      Expanded(
        child: Icon(
          iconData,
          size: 30,
          color:  primaryColor,
        ),
      ),
      Expanded(
        flex: 3,
        child: Container(
          height: 50,
          decoration: BoxDecoration(borderRadius: BorderRadiusDirectional.circular(20),  color: primaryColor,
          ),
          child: Center(
            child: Text(
              title,
              style:  const TextStyle(
                  color:  primary,
                  fontSize: 25,
                  fontWeight: FontWeight.bold
              ),
            ),
          ),
        ),
      ),
    ],
  ),
);


