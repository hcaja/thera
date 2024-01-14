import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/http_bookingcontroller.dart';
import 'package:flutter_application_1/controller/httpclinic_controller.dart';
import 'package:flutter_application_1/models/booking.dart';
import 'package:flutter_application_1/models/materials.dart';
import 'package:flutter_application_1/screens/parent/check_list.dart';
import 'package:flutter_application_1/screens/widgets/app_drawer.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ParentProfile extends StatefulWidget {
  const ParentProfile({Key? key}) : super(key: key);

  @override
  State<ParentProfile> createState() => _ParentProfileState();
}

class _ParentProfileState extends State<ParentProfile> {
  BookingController bookingController = BookingController();
  ClinicController clinicController = ClinicController();
  List<Checklist> checklist = [];
  late Parent parent;

  Future<int?> getUser() async {
    int? clinicId;
    await SharedPreferences.getInstance().then((value) {
      String? token = value.getString('parentToken');
      Map<String, dynamic> payload = JwtDecoder.decode(token!);
      clinicId = payload['ID'];
    });
    return clinicId;
  }

  @override
  void initState() {
    reload();
    super.initState();
  }

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
      drawer: const AppDrawer(),
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
                          backgroundImage: NetworkImage(
                              'https://i.pinimg.com/originals/f1/0f/f7/f10ff70a7155e5ab666bcdd1b45b726d.jpg')),
                    ),

                    // Spacing between profile picture and parent name
                    const SizedBox(height: 5),

                    // Parent Name
                    Text(
                      parent.fullname!,
                      style: const TextStyle(
                        color: Color(0xFF67AFA5),
                        fontSize: 15,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w900,
                      ),
                    ),

                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.phone,
                              color: Color(
                                  0xFF006A5C), // Change the color of the phone icon
                              size: 14, // Change the size of the phone icon
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              parent.contactNumber!,
                              style: const TextStyle(
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
                            const Icon(
                              Icons.email,
                              color: Color(
                                  0xFF006A5C), // Change the color of the email icon
                              size: 14, // Change the size of the email icon
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              parent.email!,
                              style: const TextStyle(
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
                        CustomCheckboxListTile(
                          parent: parent,
                        ),
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

  void reload() {
    getUser().then((parentID) {
      bookingController.getParent(parentID!).then((value) {
        setState(() {
          parent = value;
        });
      });
    });
  }
}
