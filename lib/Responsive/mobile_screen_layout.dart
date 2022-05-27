
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation_1/Utils/colors.dart';
import '../Utils/Diamentions.dart';
import '../screens/add_post_screen.dart';
class MobileScreen extends StatefulWidget
{
  const MobileScreen({Key?key}) :super(key: key);
  @override
  State<MobileScreen> createState() => _MobileScreenState();
}
class _MobileScreenState extends State<MobileScreen> {
  int _page =0 ;
  late PageController pageController ;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose() ;
  }
 void navigationtapped (int page){
pageController.jumpToPage(page) ;
 }

 void onpagechanged(int page){
setState(() {
  _page =page ;
});
 }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: PageView(
        children: homeScreenItems,
        // لو احنا عايزين نقلب يمين وشمال من عالي البرنامج ممكن بالخاصيه دي
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        onPageChanged:onpagechanged,
      ) ,
      bottomNavigationBar: CupertinoTabBar(
         items: [
           BottomNavigationBarItem(
             icon: Icon(Icons.home ,
            color:_page==0?  tealColor :secondaryColor , ),
           label: 'Home',
           backgroundColor:  Colors.teal,) ,

           BottomNavigationBarItem(
             icon: Icon(Icons.add_circle_outlined,
               color:_page==1? tealColor:secondaryColor ,),
             label: 'Events',
             backgroundColor:  Colors.teal,) ,

           BottomNavigationBarItem(
             icon: Icon(Icons.chat,

               color:_page==2? tealColor:secondaryColor ,),
             label: 'Chat',
             backgroundColor:  Colors.teal,) ,
           BottomNavigationBarItem(
             icon: Icon(Icons.perm_identity,
               color:_page==3? tealColor:secondaryColor ,),
             label: 'Profile',
             backgroundColor:  Colors.teal,) ,
         ],
        onTap: navigationtapped,

      ),
    );
  }
}