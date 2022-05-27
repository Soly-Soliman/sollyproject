import 'package:flutter/material.dart';
import 'package:graduation_1/Responsive/Responsive_layout_Screen.dart';
import 'package:flutter/material.dart';
import 'package:graduation_1/Utils/Diamentions.dart';
import 'package:graduation_1/screens/search_screen.dart';

import '../Utils/colors.dart';

class WebScreen extends StatefulWidget {
  const WebScreen({Key? key}) : super(key: key);

  @override
  State<WebScreen> createState() => _WebScreenState();
}

class _WebScreenState extends State<WebScreen> {
  int _page = 0;
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  void navigationtapped(int page) {
    pageController.jumpToPage(page);
    setState(() {
      _page = page;
    });
  }

  void onpagechanged(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        centerTitle: false,
        title: Text(
          'APP LOGO',
          style: TextStyle(
            color:webBackgroundColor ,
          ),
        ),
        //هنا المفروض هيبقي اللوجو
        actions: [
          IconButton(
            onPressed: () => navigationtapped(0),
            icon: Icon(
              Icons.home,
              color:_page==0? tealColor :webBackgroundColor ,
            ),
          ),
          IconButton(
            onPressed: () => navigationtapped(1),
            icon: Icon(
              Icons.mail_outline_outlined,
              color:_page==1? tealColor :webBackgroundColor ,
            ),
          ),
          IconButton(
            onPressed: ()  => navigationtapped(2),
            icon: Icon(
              Icons.save,
              color:_page==2? tealColor :webBackgroundColor ,
            ),
          ),
          IconButton(
            onPressed: () => navigationtapped(3),
            icon: Icon(
              Icons.person,
              color:_page==3? tealColor :webBackgroundColor ,
            ),
          ),
          IconButton(
            onPressed: () => navigationtapped(4),
            icon: Icon(
              Icons.search_outlined,
              color:_page==4? tealColor :webBackgroundColor,
            ),
          ),
        ],
      ),
      body: PageView(
        children:homeScreenItems,
        controller: pageController,
        onPageChanged: onpagechanged,
      ),
    );
  }
}
