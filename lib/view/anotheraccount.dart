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
    final theme = Theme.of(context);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Account(email: widget.email),
    );
  }
}
