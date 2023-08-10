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
    final theme = Theme.of(context);
    return Scaffold(
        
        drawer: App_Drawer(),
        // appBar: AppBar(
        //   backgroundColor: theme.disabledColor,
        //   leading: IconButton(
        //       icon: Icon(
        //         Icons.menu,
        //         color: theme.focusColor,
        //       ),
        //       onPressed: () => _key.currentState!.openDrawer()),
        //   automaticallyImplyLeading: false,
        //   title: Text("Home", style: TextStyle(color: theme.focusColor)),
        //   centerTitle: true,
        // ),
        body: getBody(),
        bottomNavigationBar: _buildBottomBar());
  }

  Widget _buildBottomBar() {
    Size size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    return CustomAnimatedBottomBar(
      containerHeight: size.height * 0.085, //70
      backgroundColor: theme.backgroundColor,
      selectedIndex: _currentIndex,
      showElevation: true,
      itemCornerRadius: size.width * 0.82, //24
      curve: Curves.easeIn,
      onItemSelected: (index) => setState(() => _currentIndex = index),
      items: <BottomNavyBarItem>[
        BottomNavyBarItem(
          icon: const Icon(Icons.apps),
          title: const Text('Home'),
          activeColor: theme.primaryColor,
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
        ),
        BottomNavyBarItem(
          icon: const Icon(Icons.message),
          title: const Text(
            'Chat',
          ),
          activeColor: theme.primaryColor,
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
        ),
        BottomNavyBarItem(
          icon: const Icon(Icons.people),
          title: const Text('User'),
          activeColor: theme.primaryColor,
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
