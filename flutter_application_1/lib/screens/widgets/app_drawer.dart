import 'package:flutter/material.dart';
import 'package:flutter_application_1/chat/message_screen.dart';
import 'package:flutter_application_1/controller/httplogout_controller.dart';
import 'package:flutter_application_1/screens/auth/login_as.dart';
import 'package:flutter_application_1/screens/materials/screens/therapist_materials.dart';
import 'package:flutter_application_1/screens/parent/parent_profile.dart';
import 'package:flutter_application_1/screens/parent/screens/home_dashboard.dart';
import 'package:flutter_application_1/screens/parent/screens/parent_schedules.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  void navigateOut(BuildContext context) {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const LoginAs(),
        ));
  }

  @override
  Widget build(BuildContext context) {
    Logout logout = Logout();
    return Drawer(
      child: ListView(
        children: [
          SizedBox(
            height: 90,
            child: DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.white, // background color of the head title
              ),
              child: Row(
                children: [
                  Image.asset("asset/icons/logo_ther.png",
                      width: 40.0, height: 40.0), // logo

                  // Add spacing between logo and text
                  const SizedBox(width: 8.0),

                  // app name
                  const Text(
                    "TherapEase",
                    style: TextStyle(
                      color: Color(0xFF006A5B),
                      fontFamily: 'Poppins',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Add your other side bar items
          ListTile(
            leading: const Icon(Icons.home),
            iconColor: const Color(0xFF006A5B),
            title: const Text(
              'Dashboard',
              style: TextStyle(
                color: Color(0xFF006A5B),
                fontFamily: 'Poppins',
                fontSize: 15,
                fontWeight: FontWeight.w900,
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const HomeDashboard(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.person),
            iconColor: const Color(0xFF006A5B),
            title: const Text(
              'Profile',
              style: TextStyle(
                color: Color(0xFF006A5B),
                fontFamily: 'Poppins',
                fontSize: 15,
                fontWeight: FontWeight.w900,
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const ParentProfile(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.sticky_note_2_rounded),
            iconColor: const Color(0xFF006A5B),
            title: const Text(
              'Materials',
              style: TextStyle(
                color: Color(0xFF006A5B),
                fontFamily: 'Poppins',
                fontSize: 15,
                fontWeight: FontWeight.w900,
              ),
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const TherapistMaterials(
                      isParent: false,
                    ),
                  ));
            },
          ),
          ListTile(
            leading: const Icon(Icons.edit_calendar_rounded),
            iconColor: const Color(0xFF006A5B),
            title: const Text(
              'Schedule',
              style: TextStyle(
                color: Color(0xFF006A5B),
                fontFamily: 'Poppins',
                fontSize: 15,
                fontWeight: FontWeight.w900,
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const ParentSchedules(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.note_alt),
            iconColor: const Color(0xFF006A5B),
            title: const Text(
              'Journal',
              style: TextStyle(
                color: Color(0xFF006A5B),
                fontFamily: 'Poppins',
                fontSize: 15,
                fontWeight: FontWeight.w900,
              ),
            ),
            onTap: () {
              // Handle journal action here
            },
          ),
          ListTile(
            leading: const Icon(Icons.message),
            iconColor: const Color(0xFF006A5B),
            title: const Text(
              'Chat',
              style: TextStyle(
                color: Color(0xFF006A5B),
                fontFamily: 'Poppins',
                fontSize: 15,
                fontWeight: FontWeight.w900,
              ),
            ),
            onTap: () {
              // Handle chat action here
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const MessageScreen(
                    isParent: true,
                  ),
                ),
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout), // Icon for logout
            title: const Text('Logout'), // Text for logout
            onTap: () {
              logout.allLogout().then((value) => navigateOut(context));
            },
          ),
        ],
      ),
    );
  }
}
