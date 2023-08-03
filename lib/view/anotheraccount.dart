import 'package:flutter/material.dart';
import 'account.dart';

class Account_View extends StatefulWidget {
  Account_View({required this.email});
  late String? email;
  @override
  State<Account_View> createState() => _Account_ViewState();
}

class _Account_ViewState extends State<Account_View>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(
          child: Image.asset(
            "assets/icons/logo.png",
            height: 150,
          ),
        ),
        backgroundColor: Color(0xff101A30),
      ),
      body: Account(email: widget.email),
    );
  }
}
