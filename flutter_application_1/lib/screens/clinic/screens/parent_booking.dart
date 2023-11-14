import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/clinic_profiles.dart';
import 'package:flutter_application_1/screens/clinic/widgets/calendarview.dart';

class ParentBooking extends StatefulWidget {
  const ParentBooking({super.key, required this.clinics});
  final Clinics? clinics;
  @override
  State<ParentBooking> createState() => _ParentBookingState();
}

class _ParentBookingState extends State<ParentBooking> {
  @override
  Widget build(BuildContext context) {
    final Size mq = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Booking',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF006A5B),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              color: Colors.white,
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      drawer: Drawer(
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
                // Handle dashboard action here
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
                Navigator.of(context).pushNamed('/parentprofile');
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
                // Handle materials action here
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
                // Handle schedule action here
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
                Navigator.of(context).pushNamed('/messagescreen');
              },
            ),
            // Add more items as needed

            // Add a divider for visual separation for logout
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout), // Icon for logout
              title: const Text('Logout'), // Text for logout
              onTap: () {},
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          // Top background
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 200, // Define the desired height for the top background
            child: Container(
              color: const Color(0xFF006A5B), // Or use your own decoration
            ),
          ),

          // bottom background
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: ConstrainedBox(
              constraints: BoxConstraints.expand(height: mq.height * 0.3),
              child: Image.asset(
                'asset/images/Ellipse 2.png',
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Main na screen
          Column(
            children: [
              const SizedBox(height: 30),
              Expanded(
                child: ClientCalendar(
                  clinic: widget.clinics,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
