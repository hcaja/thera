import 'package:flutter/material.dart';

class LoginAs extends StatelessWidget {
  const LoginAs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Login As',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF006A5B),
      ),
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
                Image.asset(
                  'asset/images/logo3_1.png',
                  height: 100,
                ),
                const SizedBox(height: 30.0),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF006A5B),
                    padding: const EdgeInsets.symmetric(
                      vertical: 20.0,
                    ),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/parentlogin');
                  },
                  child: const Text(
                    'Login as Parent',
                  ),
                ),
                const SizedBox(height: 30.0),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF006A5B),
                    padding: const EdgeInsets.symmetric(
                      vertical: 20.0,
                    ),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/therlogin');
                  },
                  child: const Text(
                    'Login as Therapist',
                  ),
                ),
                const SizedBox(height: 30.0),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF006A5B),
                    padding: const EdgeInsets.symmetric(
                      vertical: 20.0,
                    ),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/login');
                  },
                  child: const Text(
                    'Clinic Login',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
