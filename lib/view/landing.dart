import 'package:artisian/widget/custombottom.dart';
import 'package:artisian/view/account2.dart';
import 'package:artisian/view/carosalview.dart';
import 'package:flutter/material.dart';
import 'package:artisian/widget/appdrawer.dart';
import 'package:provider/provider.dart';
import 'package:artisian/viewmodel/email_view.dart';

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
    userEmail = Provider.of<EmailViewModel>(context).userEmail;
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
        child: ChatScreen(),
      ),
      Container(
        alignment: Alignment.center,
        child: Account(email: userEmail),
      ),
    ];
    return IndexedStack(
      index: _currentIndex,
      children: pages,
    );
  }
}
