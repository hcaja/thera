import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/therapist/ther_tab.dart';
import 'package:flutter_application_1/screens/widgets/app_drawer.dart';
// import 'package:flutter_application_1/calendar.dart';

class TherapistProfile extends StatelessWidget {
  const TherapistProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size mq = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profile',
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

      // drawer or sidebar of hamburger menu
      drawer: const AppDrawer(),

      // body
      body: Builder(
        builder: (context) => Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: ConstrainedBox(
                constraints: BoxConstraints.expand(height: mq.height * 0.30),
                child: Image.asset(
                  'asset/images/Ellipse 1.png', // top background
                  fit: BoxFit.cover,
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
            // - Therapist name
            // - About us
            // - Services offered
            // - Prices

            Positioned(
              child: ListView(
                children: <Widget>[
                  const SizedBox(height: 30),

                  // - Custom Tab bar -
                  const Center(
                    child: TherDashTab(),
                  ),

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
                          backgroundImage: AssetImage('asset/images/ther.jpg'),
                        ),
                      ),

                      // Spacing between profile picture and clinic name
                      const SizedBox(height: 5),

                      // Therapist Name
                      const Text(
                        'Therapist Name',
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
                        'ABOUT',
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
                        'Offers variety of therapy services for your child!',
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
                                        fontSize: 12.0)),
                                SizedBox(
                                    height: 5), // For spacing between items
                                Text('• Physical Therapy',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12.0)),
                                SizedBox(
                                    height: 5), // For spacing between items
                                Text('• Cognitive Therapy',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12.0)),
                                SizedBox(
                                    height: 5), // For spacing between items
                                Text('• Speech Therapy',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12.0)),
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
                                        fontSize: 12.0)),
                                SizedBox(
                                    height: 5), // For spacing between items
                                Text('• ADHD',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12.0)),
                                SizedBox(
                                    height: 5), // For spacing between items
                                Text('• Learning Disability',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12.0)),
                                SizedBox(
                                    height: 5), // For spacing between items
                                Text('• Oral Motor Issues',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12.0)),
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
                  )
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
