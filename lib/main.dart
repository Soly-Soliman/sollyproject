import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:graduation_1/Responsive/Responsive_layout_Screen.dart';
import 'package:graduation_1/Responsive/web_screen_layout.dart';
import 'package:graduation_1/Utils/colors.dart';
import 'package:graduation_1/Responsive/web_screen_layout.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:graduation_1/providers/user_provider.dart';
import 'package:graduation_1/screens/login_screen.dart';
import 'package:graduation_1/screens/signup_screen.dart';
import 'package:provider/provider.dart';



import 'Responsive/mobile_screen_layout.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  if(kIsWeb)
  {
      await Firebase.initializeApp
      (
        options: FirebaseOptions
        (
            apiKey: 'AIzaSyBZruMxW_rJeBJ7mROLFQn_aXZy9DVEIfA',
            appId: '1:131765305088:web:c84d89e5d137a8ddbd3de5',
            messagingSenderId: '131765305088',
            projectId: 'gradproject1-323d9',
            storageBucket: 'gradproject1-323d9.appspot.com',
        ),
      );
  }
  else
  {
      await Firebase.initializeApp();
  }


  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {

  @override Widget build(BuildContext context) {

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) =>UserProvider(),),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false, // عشان اخفي علامه التكويد اللي ع اليمين فوق
        title: 'hoppy app',
        theme: ThemeData.light().copyWith(
          scaffoldBackgroundColor: mobileBackgroundColor ,
        ), // الابليكشن بتاعنا عن الهوايات ف بالتالي هنستخدم الوان فاتحه مؤقتا
        // ف ال home  page  هيودينا ع ال ريسبونسيف والصفحه دي بتحاج صفحتين تانيين
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context,snapshot){
            if(snapshot.connectionState==ConnectionState.active){
              //
                if(snapshot.hasData){
                return  const responsive (
                  mobileScreenLayout:MobileScreen() ,
                  webScreenLayout:WebScreen (),
                ) ;

              }
                //if we found an error we have to print it out on the screen
                // the snap shot does not have data
                else if(snapshot.hasError){
                  return Center(child: Text('${snapshot.error}'),) ;

                }
            }

            // if we found the connection is steal happening so we have to show the circular waiting progress to tell the user
            // that you have to wait some time until the log in is done
            if (snapshot.connectionState == ConnectionState.waiting){
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.black,
                ),
              );
            }
            return const LoginScreen();
          },
        ),

      ),
    );
  }
}
