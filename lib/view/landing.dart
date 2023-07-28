import 'package:artisian/model/custombottom.dart';
import 'package:artisian/view/account.dart';
import 'package:artisian/view/carosalview.dart';
import 'package:artisian/view/chatscreen.dart';
import 'package:flutter/material.dart';
import 'package:artisian/model/appdrawer.dart';

class Carosal extends StatefulWidget {
  const Carosal({Key? key}) : super(key: key);

  @override
  State<Carosal> createState() => _CarosalState();
}

class _CarosalState extends State<Carosal> with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  final _inactiveColor = Colors.grey;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: App_Drawer(),
        appBar: AppBar(
          leading: Center(
            child: Text('swipe'),
          ),
          automaticallyImplyLeading: false,
          title: Center(
            child: Image.asset(
              "assets/icons/logo (2).png",
              height: 150,
            ),
          ),
          backgroundColor: Color(0xff101A30),
        ),
        body: getBody(),
        bottomNavigationBar: _buildBottomBar());
  }

  Widget _buildBottomBar() {
    return CustomAnimatedBottomBar(
      containerHeight: 70,
      backgroundColor: Color(0xff101A30),
      selectedIndex: _currentIndex,
      showElevation: true,
      itemCornerRadius: 24,
      curve: Curves.easeIn,
      onItemSelected: (index) => setState(() => _currentIndex = index),
      items: <BottomNavyBarItem>[
        BottomNavyBarItem(
          icon: Icon(Icons.apps),
          title: Text('Home'),
          activeColor: Color(0xffB0EB9F),
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
        ),
        BottomNavyBarItem(
          icon: Icon(Icons.message),
          title: Text(
            'Messages ',
          ),
          activeColor: Color(0xffB0EB9F),
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
        ),
        BottomNavyBarItem(
          icon: Icon(Icons.people),
          title: Text('Users'),
          activeColor: Color(0xffB0EB9F),
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
        // child: ChatScreen(),
      ),
      Container(
        alignment: Alignment.center,
        child: Account(),
      ),
    ];
    return IndexedStack(
      index: _currentIndex,
      children: pages,
    );
  }
}
