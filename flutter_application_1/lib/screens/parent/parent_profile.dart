import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/parent/check_list.dart';
// import 'package:flutter_application_1/screens/parent/profile_parent_tabbar.dart';
// import 'package:flutter_application_1/screens/widgets/app_drawer.dart';

class ParentProfile extends StatelessWidget {
  const ParentProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size mq = MediaQuery.of(context).size;

    return Scaffold(
      // appBar: AppBar(
      //   title: const Text(
      //     'Profile',
      //     style: TextStyle(color: Colors.white),
      //   ),
      //   backgroundColor: const Color(0xFF006A5B),
      //   leading: Builder(
      //     builder: (BuildContext context) {
      //       return IconButton(
      //         icon: const Icon(Icons.menu),
      //         color: Colors.white,
      //         onPressed: () {
      //           Scaffold.of(context).openDrawer();
      //         },
      //       );
      //     },
      //   ),
      // ),
      // drawer: const AppDrawer(),
      body: Builder(
        builder: (context) => Stack(children: [
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

          Positioned(
            child: ListView(
              children: <Widget>[
                const SizedBox(height: 20),

                // - Tab bar -
                // const Padding(
                //   padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
                //   child: ProfileDashTab(),
                // ),

                // Padding added before the CustomTabBar to avoid overlap
                const SizedBox(height: 50),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Profile picture
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color(0xFF0A5E2D),
                          width: 1.0,
                        ),
                        shape: BoxShape.circle,
                      ),
                      child: const CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage('asset/images/lara.jpg'),
                      ),
                    ),

                    // Spacing between profile picture and parent name
                    const SizedBox(height: 5),

                    // Parent Name
                    const Text(
                      'Princess Lara Mae Danica Fiona Marie Delute',
                      style: TextStyle(
                        color: Color(0xFF67AFA5),
                        fontSize: 15,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w900,
                      ),
                    ),

                    const Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.phone,
                              color: Color(
                                  0xFF006A5C), // Change the color of the phone icon
                              size: 14, // Change the size of the phone icon
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "09457862611",
                              style: TextStyle(
                                color: Color(
                                    0xFF645B5B), // Change the color of the phone number text
                                fontSize:
                                    10, // Change the font size of the phone number text
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.email,
                              color: Color(
                                  0xFF006A5C), // Change the color of the email icon
                              size: 14, // Change the size of the email icon
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "princesslara@sample.email",
                              style: TextStyle(
                                color: Color(
                                    0xFF645B5B), // Change the color of the email text
                                fontSize:
                                    10, // Change the font size of the email text
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    // Spacing between parent name and bio
                    const SizedBox(height: 5),
                    Column(
                      children: [
                        const SizedBox(height: 5),
                        const Text(
                          "BIO",
                          style: TextStyle(
                            color: Color(0xFF999999),
                            fontSize: 13,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        const SizedBox(height: 5),

                        // Bio Text Field
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 40.0, right: 40.0),
                          child: TextFormField(
                            decoration: const InputDecoration(
                              hintText: "Enter your bio here...", // Hint text
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.green),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xFF006A5C)),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 10),
                        // Buttons for Update and Edit
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                // Handle the "Update" button action
                              },
                              child: const Text(
                                "Edit",
                                style: TextStyle(
                                  color: Color(0xFF006A5C),
                                ),
                              ),
                            ),
                            const SizedBox(
                                width: 10), // Add spacing between the buttons
                            ElevatedButton(
                              onPressed: () {
                                // Handle the "Edit" button action
                              },
                              child: const Text(
                                "Update",
                                style: TextStyle(
                                  color: Color(0xFF006A5C),
                                ),
                              ),
                            ),
                          ],
                        ),
                        // spacing between buttons and checklist
                        const SizedBox(height: 20),
                        const Padding(
                          padding: EdgeInsets.only(left: 30.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Checklist',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF67AFA5),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        const CustomCheckboxListTile(),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
