// ignore_for_file: must_be_immutable

import 'package:artisian/widget/TickButton.dart';
import 'package:flutter/material.dart';
import 'package:artisian/viewmodel/email_view.dart';
import 'package:provider/provider.dart';
import 'package:artisian/widget/subsyllabus container.dart';

class CustomTile extends StatefulWidget {
  final String title;
  final String subtitle;
  late bool? isTicked;
  late String field;
  late String? level;
  CustomTile({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.isTicked,
    required this.field,
    required this.level,
  }) : super(key: key);

  @override
  State<CustomTile> createState() => _CustomTileState();
}

class _CustomTileState extends State<CustomTile>
    with SingleTickerProviderStateMixin {
  bool _isDropdownVisible = false;

  void _toggleDropdownVisibility() {
    setState(() {
      _isDropdownVisible = !_isDropdownVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    String? userEmail = Provider.of<EmailViewModel>(context).userEmail;
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.all(size.height * 0.011), //8
      child: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Colors.blue, Colors.purple],
          ),
          borderRadius: BorderRadius.circular(size.height * 0.011),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: _toggleDropdownVisibility,
            child: Padding(
              padding: EdgeInsets.all(size.height * 0.022), //16
              child: Column(
                children: [
                  Row(
                    children: [
                      TickButton(
                        isTicked: widget.isTicked,
                        userEmail: userEmail,
                        field: widget.field,
                        level: widget.level,
                        mapname: 'vid',
                      ),
                      SizedBox(width: size.width * 0.03),
                      Text(
                        widget.title,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: size.width * 0.042, //16
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 150.0),
                      _isDropdownVisible
                          ? Icon(
                              Icons.arrow_drop_up_outlined,
                              color: Colors.white,
                            )
                          : Icon(
                              Icons.arrow_drop_down_outlined,
                              color: Colors.white,
                            )
                    ],
                  ),
                  AnimatedSize(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    child: Visibility(
                      visible: _isDropdownVisible,
                      child: BulletTextButtonsContainer(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
