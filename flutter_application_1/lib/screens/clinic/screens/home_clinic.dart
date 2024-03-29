import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/clinic_profiles.dart';
import 'package:flutter_application_1/screens/clinic/widgets/clinic_gallery.dart';
import 'package:flutter_application_1/screens/clinic/widgets/clinic_profile.dart';
import 'package:flutter_application_1/screens/clinic/widgets/clinic_review.dart';
import 'package:flutter_application_1/screens/clinic/widgets/dash_tab_clinic.dart';
import 'package:flutter_application_1/screens/clinic/widgets/thera_list.dart';
import 'package:flutter_application_1/screens/widgets/app_drawer.dart';
import 'package:flutter_application_1/screens/widgets/app_drawer_therapist.dart';

class HomeClinic extends StatefulWidget {
  const HomeClinic(
      {super.key, required this.clinics, required this.isEditable});
  final Clinics? clinics;
  final bool isEditable;
  @override
  HomeClinicState createState() => HomeClinicState();
}

class HomeClinicState extends State<HomeClinic> {
  int _currentIndex = 0;

  // Function to handle tab changes
  void _onTabSelected(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size mq = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Dashboard',
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
      drawer:
          widget.isEditable ? const AppDrawerTherapist() : const AppDrawer(),
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

              /// Custom Tab bar
              DashTabClinic(
                selectedIndex: _currentIndex,
                onTabSelected: _onTabSelected,
              ),

              /// E expand kay need para makuha tanan availalble na screen
              Expanded(
                child: IndexedStack(
                  index: _currentIndex,
                  children: [
                    ClinicProfile(
                      isEditable: false,
                      clinics: widget.clinics,
                    ),
                    TherapistListView(
                      clinicId: widget.clinics!.id,
                    ),
                    const ClinicGallery(),
                    ClinicReview(
                      clinicId: widget.clinics!.id,
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
