import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:flutter_application_1/screens/auth/login_as.dart';
// import 'package:flutter_application_1/screens/auth/login_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Size mq;
  bool _logoVisible = false;
  bool _textVisible = false;

  @override
  void initState() {
    super.initState();
    // Delay for 3 seconds before animating the logo
    Timer(const Duration(seconds: 3), () {
      setState(() {
        _logoVisible = true;
      });
    });
    // Delay for 4 seconds before animating the text
    Timer(const Duration(seconds: 4), () {
      setState(() {
        _textVisible = true;
      });
    });
    // Delay for 8 seconds before navigating to the next screen
    Timer(const Duration(seconds: 8), () {
      // Exit full-screen
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.white,
        statusBarColor: Colors.white,
      ));

      // Navigate to the login page directly
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const LoginAs(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Welcome to TherapEase',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF006A5B),
      ),
      body: Stack(
        children: [
          // Logo Animation
          Positioned(
            top: mq.height * (_logoVisible ? 0.17 : 0.5),
            right: mq.width * 0.12,
            width: mq.width * 0.75,
            child: DelayedDisplay(
              delay:
                  const Duration(seconds: 4), // Delay before animation starts
              child: AnimatedOpacity(
                opacity: _logoVisible ? 1.0 : 0.0,
                duration:
                    const Duration(seconds: 2), // Duration of the animation
                child: Image.asset('asset/images/logo3_1.png'),
              ),
            ),
          ),

          // MADE IN DAVAO WITH ❣️ Animation
          Positioned(
            bottom: mq.height *
                (_textVisible ? 0.09 : 0.5), // Adjust this value as needed
            width: mq.width,
            child: DelayedDisplay(
              delay:
                  const Duration(seconds: 6), // Delay before animation starts
              child: AnimatedOpacity(
                opacity: _textVisible ? 1.0 : 0.0,
                duration:
                    const Duration(seconds: 2), // Duration of the animation
                child: const Text(
                  'MADE IN DAVAO WITH ❣️',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    color: Color.fromARGB(255, 17, 158, 132),
                    letterSpacing: 0.9,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
