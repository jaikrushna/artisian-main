import 'package:artisian/widget/custombottom.dart';
import 'package:artisian/view/carosalview.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:artisian/widget/appdrawer.dart';
import 'account.dart';
import 'chatscreen.dart';

class Landing extends StatefulWidget {
  const Landing({Key? key}) : super(key: key);

  @override
  State<Landing> createState() => _LandingState();
}

class _LandingState extends State<Landing> with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  final _inactiveColor = Colors.grey;
  late String? userEmail;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    User? user = FirebaseAuth.instance.currentUser;
    userEmail = user?.email;
    return Scaffold(
        drawer: App_Drawer(),
        appBar: AppBar(
          leading: const Center(
            child: Text('swipe'),
          ),
          automaticallyImplyLeading: false,
          title: Padding(
            padding: EdgeInsets.only(left: size.width * 0.130), //57
            child: Image.asset(
              "assets/icons/logo.png",
              height: size.height * 0.18, //140
            ),
          ),
          backgroundColor: const Color(0xff101A30),
        ),
        body: getBody(),
        bottomNavigationBar: _buildBottomBar());
  }

  Widget _buildBottomBar() {
    Size size = MediaQuery.of(context).size;
    return CustomAnimatedBottomBar(
      containerHeight: size.height * 0.085, //70
      backgroundColor: const Color(0xff101A30),
      selectedIndex: _currentIndex,
      showElevation: true,
      itemCornerRadius: size.width * 0.82, //24
      curve: Curves.easeIn,
      onItemSelected: (index) => setState(() => _currentIndex = index),
      items: <BottomNavyBarItem>[
        BottomNavyBarItem(
          icon: const Icon(Icons.apps),
          title: const Text('Home'),
          activeColor: const Color(0xffB0EB9F),
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
        ),
        BottomNavyBarItem(
          icon: const Icon(Icons.message),
          title: const Text(
            'Messages ',
          ),
          activeColor: const Color(0xffB0EB9F),
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
        ),
        BottomNavyBarItem(
          icon: const Icon(Icons.people),
          title: const Text('Users'),
          activeColor: const Color(0xffB0EB9F),
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
        ),
        BottomNavyBarItem(
          icon: const Icon(Icons.settings),
          title: const Text('Settings'),
          activeColor: const Color(0xffB0EB9F),
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget getBody() {
    List<Widget> pages = [
      Container(
        alignment: Alignment.center,
        child: Carosalview(),
      ),
      Container(
        alignment: Alignment.center,
        child: ChatScreen(),
      ),
      Container(
        alignment: Alignment.center,
        child: Account(email: userEmail),
      ),
      Container(
        alignment: Alignment.center,
        child: App_Drawer(),
      ),
    ];
    return IndexedStack(
      index: _currentIndex,
      children: pages,
    );
  }
}
