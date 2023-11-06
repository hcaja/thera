import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/httptherapist_controller.dart';
import 'package:flutter_application_1/models/clinic_profiles.dart';
import 'package:flutter_application_1/screens/therapist/ther_tab.dart';
import 'package:flutter_application_1/screens/widgets/app_drawer_therapist.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

import '../../models/services_offered.dart';

// import 'package:flutter_application_1/calendar.dart';

class TherapistProfile extends StatefulWidget {
  const TherapistProfile({Key? key}) : super(key: key);

  @override
  State<TherapistProfile> createState() => _TherapistProfileState();
}

class _TherapistProfileState extends State<TherapistProfile> {
  TherapistController controller = TherapistController();
  TextEditingController aboutController = TextEditingController();
  bool isLoading = false;
  Employee? employee;
  List<Services> servicesOffered = [];
  List<Services> selectedServicesOffered = [];

  void _openAnimatedDialog(BuildContext context, String title, String label) {
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
                    Text(
                      title,
                      style: const TextStyle(
                          fontSize: 13, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                )),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      height: 50,
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
                        controller: aboutController,
                        obscureText: false,
                        textInputAction: TextInputAction.done,
                        onSubmitted: (value) {
                          controller.saveabout(
                              employee!.id, aboutController.text);
                          setState(() {
                            employee!.about = aboutController.text;
                          });
                        },
                        decoration: InputDecoration(
                          hintText: label,
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

  void _openAnimatedDialogService(
      BuildContext context, List<Services> list, List<Services> selectedList) {
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
                title: const SizedBox(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Select Services Offered',
                      style:
                          TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                )),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    MultiSelectDialogField(
                      items:
                          list.map((e) => MultiSelectItem(e, e.desc)).toList(),
                      initialValue: selectedList,
                      onConfirm: (newSelected) {
                        setState(() {
                          selectedServicesOffered = newSelected;
                          controller.saveServices(employee!.id, newSelected);
                        });
                      },
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
  void initState() {
    controller.getTherapist().then((value) {
      setState(() {
        employee = value;
        aboutController.text = value.about;
      });
    });
    controller.getServices().then((value) {
      setState(() {
        servicesOffered = value;
        controller.getSelectedServices().then((value) {
          setState(() {
            for (var selected in value) {
              for (var lookup in servicesOffered) {
                if (lookup.id == selected.id) {
                  selectedServicesOffered.add(lookup);
                }
              }
            }
            isLoading = true;
          });
        });
      });
    });

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

      // drawer or sidebar of hamburger menu
      drawer: const AppDrawerTherapist(),

      // body
      body: !isLoading
          ? const Center(child: CircularProgressIndicator.adaptive())
          : Builder(
              builder: (context) => Stack(
                children: [
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: ConstrainedBox(
                      constraints:
                          BoxConstraints.expand(height: mq.height * 0.30),
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
                      constraints:
                          BoxConstraints.expand(height: mq.height * 0.3),
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
                              child: CircleAvatar(
                                radius: 70,
                                backgroundImage:
                                    NetworkImage(employee!.profilePicture),
                              ),
                            ),

                            // Spacing between profile picture and clinic name
                            const SizedBox(height: 5),

                            // Therapist Name
                            Text(
                              employee!.name,
                              style: const TextStyle(
                                color: Color(0xFF67AFA5),
                                fontSize: 20,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w900,
                              ),
                            ),

                            // Spacing between clinic name and 'About Us'
                            const SizedBox(height: 10),

                            // About Us
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'ABOUT',
                                  style: TextStyle(
                                    color: Color(0xFF999999),
                                    fontSize: 16,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    _openAnimatedDialog(
                                      context,
                                      'Edit About',
                                      '...',
                                    );
                                  },
                                  child: const Icon(
                                    Icons.edit,
                                    size: 16,
                                    color: Color(0xFF999999),
                                  ),
                                ),
                              ],
                            ),

                            // Spacing between 'About Us' and its content
                            const SizedBox(height: 5),

                            // About Us content

                            Text(
                              employee!.about,
                              style: const TextStyle(
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
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'SERVICES OFFERED',
                                  style: TextStyle(
                                    color: Color(0xFF999999),
                                    fontSize: 16,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    _openAnimatedDialogService(
                                        context,
                                        servicesOffered,
                                        selectedServicesOffered);
                                  },
                                  child: const Icon(
                                    Icons.edit,
                                    size: 16,
                                    color: Color(0xFF999999),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),

                        // Spacing between "Services Offered" and its content
                        const SizedBox(height: 5),

                        SizedBox(
                          // I've removed the height constraint so the SizedBox will take as much space as its child needs.
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 30,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                // Center the items in the row
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start, // Adjusted the spacing for the column
                                    children: [
                                      for (int i = 0;
                                          i < selectedServicesOffered.length;
                                          i++)
                                        if (i.isEven)
                                          Text(
                                              '• ${selectedServicesOffered[i].desc}',
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12.0)),
                                      const SizedBox(height: 5),
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start, // Adjusted the spacing for the column
                                    children: [
                                      for (int i = 0;
                                          i < selectedServicesOffered.length;
                                          i++)
                                        if (i.isOdd)
                                          Text(
                                              '• ${selectedServicesOffered[i].desc}',
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12.0)),
                                      const SizedBox(height: 5),
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
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
                                Icon(
                                  Icons.edit,
                                  size: 16,
                                  color: Color(0xFF999999),
                                ),
                              ],
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
                                      fontSize:
                                          16, // Adjust the font size as needed
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
                        color:
                            const Color(0xFF006A5B), // Set the background color
                        child: InkWell(
                          onTap: () {},
                          child: SizedBox(
                            width: 60, // Adjust the size of the circular FAB
                            height: 60, // Adjust the size of the circular FAB
                            child: Center(
                              child: Image.asset(
                                'asset/icons/calendar (1).png', // Set the image color
                                height: 30,
                                color: Colors
                                    .white, // Make the image fit inside the box
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
