// ignore_for_file: must_be_immutable, camel_case_types

import 'package:flutter/material.dart';
import 'account.dart';

class Account_View extends StatefulWidget {
  Account_View({Key? key, required this.email}) : super(key: key);
  late String? email;
  @override
  State<Account_View> createState() => _Account_ViewState();
}

class _Account_ViewState extends State<Account_View>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Account(email: widget.email),
    );
  }
}
