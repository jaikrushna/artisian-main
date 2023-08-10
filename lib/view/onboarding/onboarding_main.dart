import 'package:artisian/auth/signup_screen_new.dart';
import 'package:artisian/view/onboarding/onboardingone.dart';
import 'package:artisian/view/onboarding/onboardingthree.dart';
import 'package:artisian/view/onboarding/onboardingtwo.dart';
import 'package:artisian/widget/buttoncustom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
    with SingleTickerProviderStateMixin {
  final _controller = PageController();
  final pages = [
    OnboardingOne(),
    OnboardingTwo(),
    OnboardingThree(),
  ];

  int currentIndex = 0;
  AnimationController? _animationController;
  Animation<double>? _animation;
  bool showButton = true;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController!);
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _controller,
            itemCount: pages.length,
            itemBuilder: (context, index) {
              return pages[index];
            },
            onPageChanged: (index) {
              setState(() {
                currentIndex = index;
                if (currentIndex == 2) {
                  _animationController?.forward();
                  showButton = false;
                } else {
                  _animationController?.reverse();
                  showButton = true;
                }
              });
            },
          ),
          if (currentIndex == 0)
            Container(
              alignment: Alignment(0, 0.55),
              child: SmoothPageIndicator(
                controller: _controller,
                count: pages.length,
                effect: SlideEffect(
                  dotColor: Color(0xffE0D4EC),
                  activeDotColor: Color(0xff6318AF),
                  dotHeight: screenHeight * 0.01,
                  dotWidth: screenWidth * 0.07,
                ),
              ),
            )
            else if(currentIndex==1)
            Container(
              alignment: Alignment(0, 0.6),
              child: SmoothPageIndicator(
                controller: _controller,
                count: pages.length,
                effect: SlideEffect(
                  dotColor: Color(0xffE0D4EC),
                  activeDotColor: Color(0xff6318AF),
                  dotHeight: screenHeight * 0.01,
                  dotWidth: screenWidth * 0.07,
                ),
              ),
            )
          else
            Container(
              alignment: Alignment(0, 0.58),
              child: SmoothPageIndicator(
                controller: _controller,
                count: pages.length,
                effect: SlideEffect(
                  dotColor: Color(0xffE0D4EC),
                  activeDotColor: Color(0xff6318AF),
                  dotHeight: screenHeight * 0.01,
                  dotWidth: screenWidth * 0.07,
                ),
              ),
            ),
          AnimatedBuilder(
            animation: _animationController!,
            builder: (context, child) {
              return Positioned(
                bottom: screenHeight * 0.09,
                right: showButton
                    ? screenWidth * 0.41
                    : screenWidth *
                        0.22, // Set different positions based on the condition
                child: Opacity(
                  opacity: showButton ? 1 : _animation!.value,
                  child: Transform.scale(
                    scale: showButton ? 1 : _animation!.value,
                    child: child,
                  ),
                ),
              );
            },
            child: currentIndex != 2
                ? CustomButton(
                    size: screenHeight * 0.09,
                    innerColor: Color(0xff6017AA),
                    outerColor: Color(0xffE0D4EC),
                    onPressed: () {
                      _controller.nextPage(
                        duration: Duration(milliseconds: 1),
                        curve: Curves.decelerate,
                      );
                    },
                  )
                : Container(
                    width: screenWidth * 0.57,
                    height: screenHeight * 0.08,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(screenHeight * 0.04),
                    ),
                    child: ElevatedButton(
                      child: Row(
                        
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: screenWidth * 0.03),
                            child: Text(
                              "Get Started",
                              style: GoogleFonts.lexend(
                                color: Color(0xff6318AF),
                                fontSize: screenWidth * 0.04,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: screenWidth * 0.07,
                          ),
                          CircleAvatar(
                            radius: screenHeight * 0.036,
                            backgroundColor: Colors.white,
                            child: CircleAvatar(
                              radius: screenHeight * 0.033,
                              backgroundColor: Color(0xff6318AF),
                              child: Icon(
                                Icons.arrow_forward_sharp,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xffE0D4EC),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            screenHeight * 0.04,
                          ),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => LoginView()),
                          (route) => false,
                        );
                      },
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
