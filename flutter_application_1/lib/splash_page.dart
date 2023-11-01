import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:flutter_application_1/controller/httplogin_controller.dart';
import 'package:flutter_application_1/screens/auth/login_as.dart';
import 'package:flutter_application_1/screens/auth/login_profiles.dart';
import 'package:flutter_application_1/screens/parent/dashboard.dart';
import 'package:flutter_application_1/screens/therapist/ther_profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum LoginType {
  parent,
  therapist,
  clinic,
  notLoggedIn,
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Size mq;
  late SharedPreferences prefs;
  LoginType login = LoginType.notLoggedIn;
  bool _logoVisible = false;
  bool _textVisible = false;

  @override
  void initState() {
    super.initState();
    checkLogin();
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

      if (login == LoginType.notLoggedIn) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => const LoginAs(),
          ),
        );
      } else if (login == LoginType.clinic) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => const LoginProfile(),
          ),
        );
      } else if (login == LoginType.therapist) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => const TherapistProfile(),
          ),
        );
      } else if (login == LoginType.parent) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => const Dashboard(),
          ),
        );
      }
    });
  }

  Validator validator = Validator();
  void checkLogin() async {
    prefs = await SharedPreferences.getInstance();
    String? clinicToken = prefs.getString('clinicToken');
    String? employeeToken = prefs.getString('employeeToken');
    String? parentToken = prefs.getString('parentToken');
   // await prefs.remove('clinicToken');
    if (clinicToken != null) {
      validator.validateToken(clinicToken).then((value) {
        setState(() {
          login = LoginType.clinic;
        });
      });
      if (employeeToken != null) {
        validator.validateToken(employeeToken).then((value) {
          setState(() {
            login = LoginType.therapist;
          });
        });
      }
    } else if (parentToken != null) {
      validator.validateToken(parentToken).then((value) {
        setState(() {
          login = LoginType.parent;
          //print('Parent');
        });
      });
    } else {
      setState(() {
        login = LoginType.notLoggedIn;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;

    return Scaffold(
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
