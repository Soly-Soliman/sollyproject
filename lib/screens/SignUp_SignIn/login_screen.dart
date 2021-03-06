import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation_1/Components/text_field_input.dart';
import 'package:graduation_1/Utils/Diamentions.dart';
import 'package:graduation_1/Utils/utils.dart';
import 'package:graduation_1/resourses/aut_methods.dart';
import 'package:graduation_1/screens/hobby/Home_screen.dart';
import 'package:graduation_1/screens/SignUp_SignIn/signup_screen.dart';

import '../../Responsive/Responsive_layout_Screen.dart';
import '../../Responsive/mobile_screen_layout.dart';
import '../../Responsive/web_screen_layout.dart';
import '../../Utils/colors.dart';

class LoginScreen extends StatefulWidget{
  const LoginScreen({Key?key}) :super(key: key) ;
  @override
  _LoginScreenState createState() => _LoginScreenState();

}
class _LoginScreenState extends State<LoginScreen>{
  final TextEditingController _emailControler =TextEditingController( );
  final TextEditingController  _passwordControler = TextEditingController();
  bool _isloading = false ;

  @override
  void dispose() {
   super.dispose() ;
   _emailControler.dispose() ;
   _passwordControler.dispose() ;
  }

  void loginUser() async{
    setState(() {
      _isloading =true ;
    });
    String res = await AuthMethod().loginUser(
      email: _emailControler.text,
      password: _passwordControler.text,);

    if (res=='success'){
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder:(context) =>  const responsive (
            mobileScreenLayout:MobileScreen() ,
            webScreenLayout:WebScreen (),
          ),  ),);
    }
    else{
     showSnackBar(res, context) ;
    }
    setState(() {
      _isloading =false;
    });
  }
 // function to take the user to sign up screen if he did not have an account
  void navigateToSignUp(){
    Navigator.of(context).push(MaterialPageRoute(builder:(context) => const SingupScreen(), ),);
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      backgroundColor:primary ,
      appBar: AppBar(

        backgroundColor: selection,
        foregroundColor: black,

        centerTitle: true,
        title: Text(
          'Log In ' ,
          style: TextStyle(
            fontFamily: 'Sofiar',
            fontWeight: FontWeight.w800,
            color:black ,
            fontSize:24 ,
          ),     ),

        ),
      body: SafeArea(
        child: ListView(
          children: [
          Container(
            color: Colors.white,
            padding: MediaQuery.of(context).size.width> webScreenSize
                ? EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width/3)
                :  const  EdgeInsets.symmetric(horizontal: 35),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // row with 2 children 1 for logo & the other for the name of the app
                Row(children: [

                  Hero(tag: 'logo',
                    child: Container(
                      child: Image.asset('images/loo1.jpg',),
                      height: 60 ,
                      width: 100,
                    ),),
                  const SizedBox(width: 10,height: 2,) ,
                  Text(
                    ' Hobby',
                    style: TextStyle(
                      color: black,
                      fontSize: 45.0,
                     letterSpacing: 6,
                     fontFamily: 'Quintessential' ,

                    ),
                  ),
                ],),

                //text field for E-MAIL
                TextFieldInput(
                  textEditingController: _emailControler,
                  hinttext:' Enter Your E-mail',
                  textInputType:  TextInputType.emailAddress,
                  lapel: 'E mail',
                ) ,

                const SizedBox(height: 48.0, width: 20, ),
                //text field for password
                TextFieldInput(
                  textEditingController: _passwordControler,
                  hinttext:' Enter Your password',
                  isPass: true,
                  textInputType:  TextInputType.text,
                  lapel: 'Password',
                ),

                const SizedBox(height: 48.0, width: 20, ),
                //text button for log in
                InkWell(
                  onTap: loginUser,
                  child: Container(
                    child: _isloading ?
                    const Center(child: CircularProgressIndicator(
                     color: Colors.white,
                    ),) :  Text('Log IN',style: TextStyle(color: black,fontSize: 28),),
                    width: double.infinity,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    decoration:  ShapeDecoration(
                        shape:RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                        Radius.circular(10),),
                        ),
                      color: selection2 ,
                  ),

                  ),
                ),
                // transitioning to register or to forget password
                const SizedBox(height: 25,width: 10,),
                // WE need row to put them side by side

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
                          image: AssetImage('images/G.png' ,),
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
                      onTap: navigateToSignUp,
                      child:  Container(
                        child:   Text('Register' ,
                          style: TextStyle(
                            color: selection4,
                            fontFamily: 'Sofiar',
                            fontSize: 16,
                            fontWeight:FontWeight.bold ,

                          ),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 8),
                      ),),
                  ],
                ),

              ],
            ),
          ),],
        ),
      ),
    );
  }


}