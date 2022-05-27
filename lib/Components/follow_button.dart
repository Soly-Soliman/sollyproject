import 'package:flutter/material.dart';

class FollowButton extends StatelessWidget {
  final Function()? function;
  final String name;
  final Color backgrouncolor;
  final Color bordercolor;
  final Color textcolor;

  const FollowButton(
      {Key? key,
      this.function,
      required this.textcolor,
      required this.name,
      required this.backgrouncolor,
      required this.bordercolor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(

     padding: const EdgeInsets.all(5),
      child: InkWell(
          onTap: function,
          child: Container(
            decoration: BoxDecoration(
              color: backgrouncolor,
              border: Border.all(color: backgrouncolor),
            // borderRadius: BorderRadius.circular(5),
            ),
            alignment: Alignment.center,
            child: Text(
              name,
              style: TextStyle(
                color: textcolor,
                fontWeight: FontWeight.bold,
              ),
            ),


          )),
    );
  }
}
