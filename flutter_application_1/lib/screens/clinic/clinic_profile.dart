import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/auth/connection.dart';
import 'package:flutter_application_1/screens/auth/login_as.dart';

class ClinicProfile extends StatelessWidget {
  const ClinicProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size mq = MediaQuery.of(context).size;

    return Scaffold(
      // drawer or sidebar of hamburger menu
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

      // body
      body: Builder(
        builder: (context) => Stack(
          children: [
            Positioned(
              child: SizedBox(
                height: 100,
                child: ConstrainedBox(
                  constraints: BoxConstraints.expand(height: mq.height * 0.30),
                  child: Image.asset(
                    'asset/images/Ellipse 1.png',
                    fit: BoxFit.cover,
                  ),
                ),
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

            // List view
            // - Custom Tab bar
            // - Clinic Profile & name
            // - About us
            // - Services offered
            // - Prices

            Positioned(
              child: ListView(
                children: <Widget>[
                  // Padding added before the CustomTabBar to avoid overlap
                  const SizedBox(height: 60),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Profile picture
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color.fromARGB(255, 10, 94, 45),
                            width: 1.0,
                          ),
                          shape: BoxShape.circle,
                        ),
                        child: const CircleAvatar(
                          radius: 70,
                          backgroundImage:
                              AssetImage('asset/images/profile.jpg'),
                        ),
                      ),

                      // Spacing between profile picture and clinic name
                      const SizedBox(height: 5),

                      // Clinic Name
                      const Text(
                        'The Tiny House',
                        style: TextStyle(
                          color: Color(0xFF67AFA5),
                          fontSize: 20,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w900,
                        ),
                      ),

                      // Spacing between clinic name and 'About Us'
                      const SizedBox(height: 10),

                      // About Us
                      const Text(
                        'ABOUT US',
                        style: TextStyle(
                          color: Color(0xFF999999),
                          fontSize: 16,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w900,
                        ),
                      ),

                      // Spacing between 'About Us' and its content
                      const SizedBox(height: 5),

                      // About Us content
                      const Text(
                        'A center with all your needed services, The Tiny House Therapy and Learning Center',
                        style: TextStyle(
                          height: 1.3,
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),

                  // Spacing between About Us content and "Services offered"
                  const SizedBox(height: 15),

                  // Services Offered
                  const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'SERVICES OFFERED',
                        style: TextStyle(
                          color: Color(0xFF999999),
                          fontSize: 16,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  ),

                  // Spacing between "Services Offered" and its content
                  const SizedBox(height: 5),
                  const SizedBox(
                    // I've removed the height constraint so the SizedBox will take as much space as its child needs.
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          // Center the items in the row
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment
                                  .start, // Adjusted the spacing for the column
                              children: [
                                Text('• Occupational Therapy',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13.0)),
                                SizedBox(
                                    height: 5), // For spacing between items
                                Text('• Physical Therapy',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13.0)),
                                SizedBox(
                                    height: 5), // For spacing between items
                                Text('• Cognitive Therapy',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13.0)),
                                SizedBox(
                                    height: 5), // For spacing between items
                                Text('• Speech Therapy',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16.0)),
                              ],
                            ),
                            SizedBox(
                                width:
                                    20), // Optional: Added this for spacing between two columns
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment
                                  .start, // Adjusted the spacing for the column
                              children: [
                                Text('• Developmental Delays',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13.0)),
                                SizedBox(
                                    height: 5), // For spacing between items
                                Text('• ADHD',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13.0)),
                                SizedBox(
                                    height: 5), // For spacing between items
                                Text('• Learning Disability',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13.0)),
                                SizedBox(
                                    height: 5), // For spacing between items
                                Text('• Oral Motor Issues',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13.0)),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Spacing between services offered content and "Prices"
                  const SizedBox(height: 20),

                  // Prices
                  const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'PRICES',
                        style: TextStyle(
                          color: Color(0xFF999999),
                          fontSize: 16,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  ),

                  // Spacing between "Prices" and its content
                  const SizedBox(height: 15),

                  // Prices content
                  Column(
                    children: [
                      Center(
                        child: Container(
                          width: 297,
                          height: 51,
                          decoration: ShapeDecoration(
                            color: const Color(0xFF006A5B),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            shadows: const [
                              BoxShadow(
                                color: Color(0x3F000000),
                                blurRadius: 4,
                                offset: Offset(0, 4),
                                spreadRadius: 0,
                              )
                            ],
                          ),
                          child: const Center(
                            child: Text(
                              "₱750/Session (1hr)",
                              style: TextStyle(
                                color: Colors.white, // Text color
                                fontSize: 16, // Adjust the font size as needed
                              ),
                            ),
                          ),
                        ),
                      ),
                      // Add other widgets to the Column if needed
                    ],
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
                    onTap: () {},
                    child: SizedBox(
                      width: 60, // Adjust the size of the circular FAB
                      height: 60, // Adjust the size of the circular FAB
                      child: Center(
                        child: Image.asset(
                          'asset/icons/calendar (1).png', // Set the image color
                          height: 30,
                          color:
                              Colors.white, // Make the image fit inside the box
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
