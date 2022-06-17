import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation_1/Components/text_field_input.dart';
import 'package:graduation_1/Responsive/Responsive_layout_Screen.dart';
import 'package:graduation_1/Responsive/mobile_screen_layout.dart';
import 'package:graduation_1/Responsive/web_screen_layout.dart';
import 'package:graduation_1/Utils/utils.dart';
import 'package:graduation_1/resourses/aut_methods.dart';
import 'package:graduation_1/screens/login_screen.dart';
import 'package:image_picker/image_picker.dart';

import '../Utils/colors.dart';
class SingupScreen extends StatefulWidget{
  const SingupScreen({Key?key}) :super(key: key) ;
  @override
  _SingupScreenState createState() => _SingupScreenState();

}
class _SingupScreenState extends State<SingupScreen>{
  final TextEditingController _emailControler =TextEditingController( );
  final TextEditingController  _passwordControler = TextEditingController();
  final TextEditingController _bioControler =TextEditingController( );
  final TextEditingController _usernameControler =TextEditingController( );
  final TextEditingController _phonenumberControler =TextEditingController( );
  final TextEditingController _genderControler =TextEditingController( );
  Uint8List ?  _imageControler ;
  bool _isLoading =false ;

  @override
  void dispose() {
    super.dispose() ;
    _emailControler.dispose() ;
    _passwordControler.dispose() ;
    _usernameControler.dispose() ;
    _bioControler.dispose();
    _phonenumberControler.dispose();
    _genderControler.dispose();

  }
  void selectImage () async{
  Uint8List imagee=  await pickImage(ImageSource.gallery);
  setState(() {
            _imageControler =imagee ;
  });
  }
  void signUpUser()async{
    setState(() {
      _isLoading =true ;
    });
    String res = await AuthMethod().signUpUser(
      email: _emailControler.text,
      password: _passwordControler.text,
      username: _usernameControler.text,
      bio: _bioControler.text,
      phone_number: _phonenumberControler.text,
      file: _imageControler!,
    );
    setState(() {
      _isLoading =false ;
    });
   if (res !='success'){
     // it will show a Snack par
     // هنلاقيها ف صفحه ال  utils
     showSnackBar(res, context) ;
   }
   else{
     Navigator.of(context).pushReplacement(
       MaterialPageRoute(
         builder:(context) =>  const responsive (
           mobileScreenLayout:MobileScreen() ,
          webScreenLayout:WebScreen (),
     ),  ),);

   }
  }

  // function to take the user to  log in  screen if he is already have an account

  void navigateToLogin(){
    Navigator.of(context).push(MaterialPageRoute(builder:(context) => const LoginScreen(), ),);
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(

      backgroundColor: primary,
      appBar: AppBar(backgroundColor: selection,

        title: Text(
          'Sign Up In HobbyTopia ' ,
          style: TextStyle(
            color: black ,
            fontSize:24 ,
          ),     ),),
      body: SafeArea(
        child: Container(
          padding: const  EdgeInsets.symmetric(horizontal: 35),
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // row with 2 children 1 for logo & the other for the name of the app
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                  Hero(tag: 'logo',
                    child: Container(
                      child: Image.asset('images/hi1.jpg',),
                      height: 90 ,
                      width: 100,
                    ),),
                  const SizedBox(width: 10,height: 1,) ,

                ],),
                // circular widget to accept and show our selected file
                Stack(
                  children: [
                    _imageControler!= null
                    ?
                    CircleAvatar(
                      radius: 64,
                      backgroundImage: MemoryImage(_imageControler!),
                    )
                   :const CircleAvatar(
                      radius: 64,
                      backgroundImage: NetworkImage('https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png') ,

                    ),
                  Positioned(
                    bottom: -15,
                    left:  90.0,
                      child:IconButton(
                        onPressed: selectImage,
                        icon:  Icon(Icons.add_a_photo,
                        color: selection,),
                      ),
                  ),
                  ],
                ),
                const SizedBox(height: 10.0, width: 20, ),
                //text field for User name
                TextFieldInput(
                  textEditingController: _usernameControler,
                  hinttext:' Enter Your User name',
                  textInputType:  TextInputType.text,
                  lapel: 'User Name',
                ) ,
                const SizedBox(height: 10.0, width: 20, ),
                TextFieldInput(
                  textEditingController: _bioControler,
                  hinttext:' Enter Your User bio',
                  textInputType:  TextInputType.text,
                lapel: 'BIO',
                ) ,
                const SizedBox(height: 10.0, width: 20, ),
                //text filed for phone number
                TextFieldInput(
                  textEditingController: _phonenumberControler,
                  hinttext:' Enter Your User phone number ',
                  textInputType:  TextInputType.phone,
                  lapel: 'phone number',) ,
                const SizedBox(height: 10.0, width: 20, ),
                //text field for E-MAIL
                TextFieldInput(
                  textEditingController: _emailControler,
                  hinttext:' Enter Your E-mail',
                  textInputType:  TextInputType.emailAddress,
                  lapel: 'Email',
                ) ,
                //text field for password
                const SizedBox(height: 10.0, width: 20, ),

                TextFieldInput(
                  textEditingController: _passwordControler,
                  hinttext:' Enter Your password',
                  isPass: true,
                  textInputType:  TextInputType.text,
                  lapel: 'Password',
                ),

                const SizedBox(height: 10.0, width: 20, ),
                //text button for log in
                InkWell(
                  onTap: signUpUser,
                  child: Container(
                    child:
                    _isLoading ?
                    const Center(child: CircularProgressIndicator(
                      color: Colors.white,
                    ),)
                        :  Text('Sing up ' ,style: TextStyle(color: black ,fontSize: 28),  ),
                    width: double.infinity,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    decoration:  ShapeDecoration(
                        shape:RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),),
                        ),
                        color:selection2,
                    ),

                  ),
                ),
                SizedBox(height: 25,width: 10,),
                Row(children: [
                  Expanded(
                    child: Container(

                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(13),
                        image: DecorationImage(
                          image: AssetImage('images/face.png' ,),
                        ),
                      ),

                      height: 40 ,
                      width: 60,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(13),
                        image: DecorationImage(
                          image: AssetImage('images/lin.png' ,),
                        ),
                      ),

                      height: 40 ,
                      width: 60,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(13),
                        image: DecorationImage(
                          image: AssetImage('images/G.png',),
                        ),
                      ),

                      height: 40 ,
                      width: 60,
                    ),
                  ),

                ],) ,
                SizedBox(height: 25,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: const  Text('Do not have an account ?'),
                      padding: const EdgeInsets.symmetric(vertical: 8),
                    ),
                    const SizedBox(height: 5 ,width: 10,),
                    GestureDetector(
                      onTap: navigateToLogin,
                      child:  Container(
                        child:   Text('Log in ' ,
                          style: TextStyle(
                            color: selection,
                            fontSize: 20,
                            fontWeight:FontWeight.bold ,

                          ),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 8),
                      ),),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


}