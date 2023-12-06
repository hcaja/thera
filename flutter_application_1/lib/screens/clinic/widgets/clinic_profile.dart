import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/httpclinic_controller.dart';
import 'package:flutter_application_1/models/clinic_profiles.dart';
import 'package:flutter_application_1/models/services_offered.dart';
import 'package:flutter_application_1/screens/auth/connection.dart';
import 'package:flutter_application_1/screens/auth/login_as.dart';
import 'package:flutter_application_1/screens/booking/screens/booking.dart';
import 'package:flutter_application_1/screens/clinic/screens/parent_booking.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';

class ClinicProfile extends StatefulWidget {
  const ClinicProfile(
      {Key? key, required this.clinics, required this.isEditable})
      : super(key: key);
  final Clinics? clinics;
  final bool isEditable;

  @override
  State<ClinicProfile> createState() => _ClinicProfileState();
}

class _ClinicProfileState extends State<ClinicProfile> {
  late Clinics? clinic;
  ClinicController controller = ClinicController();
  TextEditingController aboutController = TextEditingController();
  List<Services> servicesOffered = [];
  List<Services> selectedServicesOffered = [];
  bool isLoading = false;

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
                              clinic!.id, aboutController.text);
                          setState(() {
                            clinic!.bio = aboutController.text;
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
                          controller.saveServices(clinic!.id, newSelected);
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
    clinic = widget.clinics;
    controller.getServices().then((value) {
      setState(() {
        servicesOffered = value;
        controller.getSelectedServices(clinic!.id).then((value) {
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
                          backgroundImage: NetworkImage(clinic!.picture!),
                        ),
                      ),

                      // Spacing between profile picture and clinic name
                      const SizedBox(height: 5),

                      // Therapist Name
                      Text(
                        clinic!.name!,
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
                          widget.isEditable
                              ? GestureDetector(
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
                                )
                              : const SizedBox(),
                        ],
                      ),

                      // Spacing between 'About Us' and its content
                      const SizedBox(height: 5),

                      // About Us content

                      Text(
                        clinic!.bio!,
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
                          widget.isEditable
                              ? GestureDetector(
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
                                )
                              : const SizedBox(),
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
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                    Text('• ${selectedServicesOffered[i].desc}',
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
                                    Text('• ${selectedServicesOffered[i].desc}',
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
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'PRICES',
                            style: TextStyle(
                              color: Color(0xFF999999),
                              fontSize: 16,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          widget.isEditable
                              ? const Icon(
                                  Icons.edit,
                                  size: 16,
                                  color: Color(0xFF999999),
                                )
                              : const SizedBox(),
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
                    onTap: () {
                      if (widget.isEditable) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const BookingScreen(),
                          ),
                        );
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ParentBooking(
                              clinics: clinic,
                            ),
                          ),
                        );
                      }
                    },
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
