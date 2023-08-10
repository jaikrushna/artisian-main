import 'dart:async';
import 'package:artisian/auth/signup_screen_new.dart';
import 'package:artisian/view/landing.dart';
import 'package:artisian/view/onboarding/onboarding_main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _slideLeftAnimation;
  late Timer _timer;
  int _counter = 0;
  bool _isFirstTextVisible = true;
  bool _isSecondWidgetVisible = false;
  bool isLoggedIn = FirebaseAuth.instance.currentUser != null;

  final String onboardingKey = 'onboarding_screen_shown';

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );

    _slideLeftAnimation = Tween<Offset>(
      begin: const Offset(0.0, 0.0),
      end: const Offset(0.0, 0.0),
    ).animate(_animationController);

    _timer = Timer(const Duration(seconds: 3), () {
      setState(() {
        _counter++;
        _isFirstTextVisible = !_isFirstTextVisible;
        if (_counter == 1) {
          _startSecondWidgetAnimation();
        }
      });
    });

    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed && _counter == 1) {
        _navigateToNextScreen();
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _timer.cancel();
    super.dispose();
  }

  void _startSecondWidgetAnimation() {
    setState(() {
      _isSecondWidgetVisible = true;
    });
    _animationController.forward();
  }

  
  void _navigateToNextScreen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool onboardingShown = prefs.getBool(onboardingKey) ?? false;

    if (onboardingShown) {
      // Onboarding screen has been shown before
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => isLoggedIn ? Landing() : LoginView()),
        );
      }
    } else {
      // Onboarding screen has not been shown before
      await prefs.setBool(onboardingKey, true);
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => OnboardingScreen()),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF7E5B7),
      body: Stack(
        children: [
          SvgPicture.asset(
            'assets/icons/splash.svg',
            fit: BoxFit.fill,
            width: double.infinity,
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 1000),
            color: _isFirstTextVisible ? Colors.transparent : const Color(0xff200D31),
            onEnd: () {
              if (!_isFirstTextVisible) {
                _navigateToNextScreen();
              }
            },
          ),
          Center(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              child: _isFirstTextVisible
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Image.asset(
                        //   'assets/icons/logo 3.png',
                        //   height: 500,
                        //   width: 500,
                        // ),
                        Text(
                          'Welcome',
                          style: GoogleFonts.capriola(
                            color: const Color(0xffF7E5B7),
                            fontSize: 50,
                          ),
                          key: const ValueKey<int>(1),
                        ),
                      ],
                    )
                  : AnimatedOpacity(
                      opacity: _isSecondWidgetVisible ? 1.0 : 0.0,
                      duration: const Duration(milliseconds: 500),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                          'assets/icons/logo 3.png',
                            height: 500,
                            width: 500,
                          ),
                          // Text(
                          //   'Craft My Plate',
                          //   style: GoogleFonts.capriola(
                          //     color: const Color(0xffF7E5B7),
                          //     fontSize: 32,
                          //   ),
                          //   key: const ValueKey<int>(2),
                          // ),
                          // Text(
                          //   'You customise, We cater',
                          //   style: GoogleFonts.courgette(
                          //     color: const Color(0xffD5B67D),
                          //     fontSize: 16,
                          //   ),
                          // ),
                        ],
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
