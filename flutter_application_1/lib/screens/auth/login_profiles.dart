import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/httplogin_controller.dart';
import 'package:flutter_application_1/controller/httplogout_controller.dart';
import 'package:flutter_application_1/models/clinic_profiles.dart';
import 'package:flutter_application_1/screens/auth/login_as.dart';

import '../therapist/ther_profile.dart';

class LoginProfile extends StatefulWidget {
  const LoginProfile({super.key});

  @override
  State<LoginProfile> createState() => _LoginProfileState();
}

class _LoginProfileState extends State<LoginProfile> {
  final TextEditingController passwordController = TextEditingController();
  ClinicLogin controller = ClinicLogin();
  EmployeeLogin employeeLogin = EmployeeLogin();
  List<Employee>? profiles;

  @override
  void initState() {
    controller.getProfiles(context, 2).then((List<Employee> result) => {
          setState(() {
            profiles = result;
          })
        });

    super.initState();
  }

  void _openAnimatedDialog(BuildContext context, Employee profile) {
    showGeneralDialog(
        context: context,
        barrierDismissible: true,
        barrierLabel: '',
        transitionDuration: const Duration(milliseconds: 200),
        pageBuilder: (context, animation1, animation2) {
          return Container();
        },
        transitionBuilder: (context, a1, a2, widget) {
          return ScaleTransition(
            scale: Tween<double>(begin: 0.5, end: 1.0).animate(a1),
            child: FadeTransition(
              opacity: Tween<double>(begin: 0.5, end: 1.0).animate(a1),
              child: AlertDialog(
                title: SizedBox(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text(
                      'Employee Sign In',
                      style:
                          TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Container(
                          width: 72,
                          height: 72,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: const Color(0xFF006A5B),
                              width: 2.0,
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(profile.profilePicture),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          profile.name,
                          style: const TextStyle(
                              color: Color(0xFF006A5B),
                              fontWeight: FontWeight.w800,
                              fontSize: 17),
                        )
                      ],
                    ),
                  ],
                )),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(
                          color: const Color.fromARGB(255, 245, 250, 255),
                        ),
                        color: Colors.white, // White color
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x3F000000),
                            blurRadius: 4,
                            offset: Offset(0, 4),
                            spreadRadius: 0,
                          ),
                        ],
                      ),
                      child: TextField(
                        controller: passwordController,
                        obscureText: true,
                        textInputAction: TextInputAction.done,
                        onSubmitted: (value) {
                          employeeLogin
                              .employeeLogin(context, profile.email,
                                  passwordController.text)
                              .then((value) {
                            if (value) {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const TherapistProfile(),
                                ),
                              );
                            }
                          });
                        },
                        decoration: const InputDecoration(
                          labelText: 'Enter Password',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
                backgroundColor: Colors.white,
                shape: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    Logout logout = Logout();
    return Scaffold(
      appBar: null,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: ConstrainedBox(
              constraints: BoxConstraints.expand(height: size.height * 0.2),
              child: Image.asset(
                'asset/images/WAVE.png', // top background
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: ConstrainedBox(
              constraints: BoxConstraints.expand(height: size.height * 0.30),
              child: Image.asset(
                'asset/images/WAVE (1).png', // bottom background
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(45.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                !(profiles != null)
                    ? const Center(child: CircularProgressIndicator())
                    : SizedBox(
                        height: size.height * 0.5,
                        child: ListView(
                          children: [
                            if (profiles != null)
                              for (int i = 0; i < profiles!.length; i++)
                                GestureDetector(
                                  onTap: () {
                                    _openAnimatedDialog(context, profiles![i]);
                                  },
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      SizedBox(
                                        height: size.height * 0.02,
                                      ),
                                      SizedBox(
                                          child: Row(
                                        children: [
                                          Container(
                                            width: 72,
                                            height: 72,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: Border.all(
                                                color: const Color(0xFF006A5B),
                                                width: 2.0,
                                              ),
                                            ),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: Image.network(
                                                profiles![i].profilePicture,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            profiles![i].name,
                                            style: const TextStyle(
                                                color: Color(0xFF006A5B),
                                                fontWeight: FontWeight.w800,
                                                fontSize: 17),
                                          )
                                        ],
                                      )),
                                    ],
                                  ),
                                ),
                            GestureDetector(
                              onTap: () {
                                logout.clinicLogout();
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => const LoginAs(),
                                    ));
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  SizedBox(
                                    height: size.height * 0.02,
                                  ),
                                  SizedBox(
                                      child: Row(
                                    children: [
                                      SizedBox(
                                        width: 72,
                                        height: 72,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: const Icon(
                                            Icons.logout,
                                            color: Colors.red,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      const Text(
                                        'Logout',
                                        style: TextStyle(
                                            color: Colors.red,
                                            fontWeight: FontWeight.w800,
                                            fontSize: 17),
                                      )
                                    ],
                                  )),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
