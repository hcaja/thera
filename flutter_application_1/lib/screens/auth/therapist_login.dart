import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/httplogin_controller.dart';
import 'package:flutter_application_1/screens/therapist/ther_profile.dart';

class TherapistLogin extends StatefulWidget {
  const TherapistLogin({Key? key}) : super(key: key);

  @override
  State<TherapistLogin> createState() => _TherapistLoginState();
}

class _TherapistLoginState extends State<TherapistLogin> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  EmployeeLogin employeeLogin = EmployeeLogin();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text(
          'Therapist Login',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF006A5B),
      ),
      body: GestureDetector(
        // GestureDetector to dismiss the keyboard on a tap
        onTap: () => FocusScope.of(context).unfocus(),
        child: Stack(
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
                  Image.asset(
                    'asset/images/logo3_1.png',
                    height: 100,
                  ),
                  const SizedBox(height: 16.0),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(
                        color: const Color.fromARGB(255, 255, 255, 255),
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
                      controller: emailController,
                      decoration: const InputDecoration(
                        labelText: 'Email or username',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
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
                      decoration: const InputDecoration(
                        labelText: 'Password',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30.0),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF006A5B),
                      padding: const EdgeInsets.symmetric(
                        vertical: 20.0,
                        // horizontal: 140.0,
                      ),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      employeeLogin
                          .soloEmployeeLogin(
                              emailController.text, passwordController.text)
                          .then((value) {
                        if (value) {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => const TherapistProfile(),
                            ),
                          );
                        }
                      });
                    },
                    child: const Text(
                      'Login',
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/therreview');
                    },
                    child: const Text('Forgot Password?'),
                  ),
                  const SizedBox(height: 16.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account?"),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context,
                              '/selectregistrationas'); // Navigate to the registration screen
                        },
                        child: const Text('Register'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Future loginUser(email, String password, BuildContext context) async {
//   Client client = Client();
//   Account account = Account(client);

//   client
//           .setEndpoint('https://cloud.appwrite.io/v1') // Your API Endpoint
//           .setProject('Educanet_2023') // Your project ID
//       ;
//   try {
//     final user = await account.createEmailSession(
//       email: email,
//       password: password,
//     );
//     if (user != null) {
//       Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => ClinicProfile(),
//           ));
//       print('user logged in');
//     }
//   } catch (e) {
//     print(e);
//   }
// }
