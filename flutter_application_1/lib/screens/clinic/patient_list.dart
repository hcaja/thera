import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/auth/connection.dart';
import 'package:flutter_application_1/screens/auth/login_as.dart';
import 'package:flutter_application_1/screens/clinic/custom_tabbar.dart';

class PatientList extends StatelessWidget {
  const PatientList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final patients = [
      'Patient 1',
      'Patient 2',
      'Patient 3',
      'Patient 4',
      'Patient 5',
      // Add more patient names as needed
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Patient List',
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

      // drawer or sidebar of the hamburger menu
      drawer: Drawer(
        child: ListView(
          children: [
            SizedBox(
              height: 90,
              child: DrawerHeader(
                decoration: const BoxDecoration(
                  color: Colors.white, // background color of the header title
                ),
                child: Row(
                  children: [
                    Image.asset(
                      "asset/icons/logo_ther.png",
                      width: 40.0,
                      height: 40.0,
                    ), // logo

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
                Navigator.of(context).pushNamed('/clinicprofile');
                // Handle profile action here
              },
            ),
            ListTile(
              leading: const Icon(Icons.edit_calendar_rounded),
              iconColor: const Color(0xFF006A5B),
              title: const Text(
                'Booking',
                style: TextStyle(
                  color: Color(0xFF006A5B),
                  fontFamily: 'Poppins',
                  fontSize: 15,
                  fontWeight: FontWeight.w900,
                ),
              ),
              onTap: () {
                // Handle booking action here
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
              leading: const Icon(Icons.edit_note_rounded),
              iconColor: const Color(0xFF006A5B),
              title: const Text(
                'Patient List',
                style: TextStyle(
                  color: Color(0xFF006A5B),
                  fontFamily: 'Poppins',
                  fontSize: 15,
                  fontWeight: FontWeight.w900,
                ),
              ),
              onTap: () {
                Navigator.of(context).pushNamed('/patientlist');
                // Handle patient list action here
              },
            ),

            ListTile(
              leading: const Icon(Icons.groups_2),
              iconColor: const Color(0xFF006A5B),
              title: const Text(
                'Clinic Staff',
                style: TextStyle(
                  color: Color(0xFF006A5B),
                  fontFamily: 'Poppins',
                  fontSize: 15,
                  fontWeight: FontWeight.w900,
                ),
              ),
              onTap: () {
                // Handle clinic staff action here
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
                Navigator.of(context).pushNamed('/messagescreen');
                // Handle chat action here
              },
            ),
            // Add more items as needed

            // Add a divider for visual separation for logout
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout), // Icon for logout
              title: const Text('Logout'), // Text for logout
              onTap: () {
                Connection.pb.authStore.clear();
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const LoginAs()));
                // Handle logout action here
              },
            ),
          ],
        ),
      ),

      // Body
      body: Stack(
        children: [
          // Top background image
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Image.asset(
              'asset/images/Ellipse 1.png', // Replace with your top image
              fit: BoxFit.cover,
            ),
          ),

          // Bottom background image
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Image.asset(
              'asset/images/Ellipse 2.png', // Replace with your bottom image
              fit: BoxFit.cover,
            ),
          ),

          // List view
          Positioned(
            // Adjust the top position as needed

            top: 30,
            left: 16,
            right: 16,
            bottom: 100,
            child: Column(
              children: <Widget>[
                // Custom Tab bar
                const Center(child: CustomTabBar()),

                // Padding added before the CustomTabBar to avoid overlap
                const SizedBox(height: 60),

                // Patient list
                Expanded(
                  child: ListView.builder(
                    itemCount: patients.length,
                    itemBuilder: (context, index) {
                      final patientName = patients[index];

                      return ListTile(
                        title: Text(patientName),
                        subtitle: Text(
                            'Patient ID: $index'), // Add patient information here
                        leading: const CircleAvatar(
                          backgroundImage: AssetImage(
                            'asset/images/ther.jpg', // Replace with the actual path to your image in assets
                          ),
                        ),
                        onTap: () {
                          // Handle tapping on a patient to view their details
                          // You can navigate to a patient detail screen here if needed
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text('Patient Details'),
                                content: Text(
                                    'Details for $patientName'), // Display patient details here
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(
                                          context); // Close the dialog
                                    },
                                    child: const Text('Close'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),

          // Floating Action Button (FAB)
          Positioned(
            bottom: 35, // Adjust the distance from the bottom as needed
            right: 30, // Adjust the distance from the right as needed
            child: ClipOval(
              child: Material(
                color: const Color(0xFF006A5B), // Set the background color
                child: InkWell(
                  onTap: () {
                    // Handle FAB action here
                  },
                  child: const SizedBox(
                    width: 60, // Adjust the size of the circular FAB
                    height: 60, // Adjust the size of the circular FAB
                    child: Center(
                      child: Icon(
                        Icons.calendar_today, // Use the calendar icon
                        color: Colors.white, // Set the icon color
                        size: 30, // Adjust the icon size
                      ),
                    ),
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
