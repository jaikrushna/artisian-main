// ignore_for_file: must_be_immutable

import 'package:artisian/widget/TickButton.dart';
import 'package:flutter/material.dart';
import 'package:artisian/viewmodel/email_view.dart';
import 'package:provider/provider.dart';
import 'package:artisian/widget/subsyllabus container.dart';
import 'package:artisian/provider/beginner.dart';
import 'package:artisian/provider/intermediate.dart';
import 'package:artisian/provider/advance.dart';

class CustomTile extends StatefulWidget {
  late bool? isTicked;
  late String field;
  late String? level;
  late int index;
  CustomTile({
    Key? key,
    required this.isTicked,
    required this.field,
    required this.level,
    required this.index,
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

  List<String> title = [];
  List<String> subtitle = [];
  List<String> Links = [];
  @override
  Widget build(BuildContext context) {
    String? userEmail = Provider.of<EmailViewModel>(context).userEmail;
    Size size = MediaQuery.of(context).size;
    if (widget.level == "Beginner") {
      title = BeginnerTopic;
      subtitle = Beginner[widget.index];
      Links = BeginnerLinks[widget.index];
    } else if (widget.level == "Intermediate") {
      title = IntermediateTopic;
      subtitle = Intermediate[widget.index];
      Links = IntermediateLinks[widget.index];
    } else if (widget.level == "Advance") {
      title = AdvanceTopic;
      subtitle = Advance[widget.index];
      Links = AdvanceLinks[widget.index];
    }
    return Padding(
      padding: EdgeInsets.all(size.height * 0.011), //8
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xff5D0B5F).withOpacity(0.30), // 50% transparent blue
              Colors.deepPurple.withOpacity(0.7), // 50% transparent green
            ],
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TickButton(
                        isTicked: widget.isTicked,
                        userEmail: userEmail,
                        field: widget.field,
                        level: widget.level,
                        mapname: 'vid',
                      ),
                      // SizedBox(width: size.width * 0.03),
                      Flexible(
                        child: Text(
                          title[widget.index],
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: size.width * 0.035, //16
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
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
                      child: BulletTextButtonsContainer(
                        index: widget.index,
                        links: Links,
                        L: subtitle,
                      ),
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
