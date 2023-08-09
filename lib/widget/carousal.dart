// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'dart:async';

class AutoRotatingCarousel extends StatefulWidget {
  final List<Widget> widgetList;
  final List<String> photoUrls;

  const AutoRotatingCarousel(
      {Key? key, required this.widgetList, required this.photoUrls})
      : assert(widgetList.length == photoUrls.length),
        super(key: key);

  @override
  _AutoRotatingCarouselState createState() => _AutoRotatingCarouselState();
}

class _AutoRotatingCarouselState extends State<AutoRotatingCarousel> {
  late PageController _pageController;
  int currentIndex = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.94);
    startAutoRotate();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  void startAutoRotate() {
    const Duration duration = Duration(seconds: 5); // Set the rotation duration
    _timer = Timer.periodic(duration, (Timer timer) {
      if (currentIndex < widget.photoUrls.length - 1) {
        setState(() {
          currentIndex++;
        });
        _pageController.animateToPage(
          currentIndex,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeOut,
        );
      } else {
        // Reset to the first image when the last image is reached
        setState(() {
          currentIndex = 0;
        });
        _pageController.animateToPage(
          0,
          duration: const Duration(milliseconds: 500),
          curve: Curves.fastOutSlowIn,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.fromLTRB(size.width * 0.0, size.height * 0.039,
          size.width * 0.0, size.height * 0.039),
      child: SizedBox(
        width: double.infinity,
        height: size.height * 0.24,
        child: PageView.builder(
          itemCount: widget.photoUrls.length,
          controller: _pageController,
          onPageChanged: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(size.width * 0.022),
                child: widget.widgetList[index],
              ),
            );
          },
        ),
      ),
    );
  }
}
