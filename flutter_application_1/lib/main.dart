import 'package:flutter/material.dart';
import 'package:flutter_application_1/chat/chat_screen.dart';
import 'package:flutter_application_1/chat/message_screen.dart';
import 'package:flutter_application_1/screens/clinic/screens/home_clinic.dart';
import 'package:flutter_application_1/screens/clinic/widgets/patient_list.dart';
import 'package:flutter_application_1/screens/map/map_page.dart';
import 'package:flutter_application_1/screens/auth/login_as.dart';
import 'package:flutter_application_1/screens/auth/parent_login.dart';
import 'package:flutter_application_1/screens/auth/therapist_login.dart';
import 'package:flutter_application_1/screens/clinic/widgets/clinic_gallery.dart';
import 'package:flutter_application_1/screens/parent/screens/home_dashboard.dart';
import 'package:flutter_application_1/screens/parent/screens/home_parent_profile.dart';
import 'package:flutter_application_1/screens/parent/widgets/ther_dash.dart';
import 'package:flutter_application_1/screens/registration/clinic_reg.dart';
import 'package:flutter_application_1/screens/clinic/widgets/clinic_review.dart';
import 'package:flutter_application_1/screens/auth/login_page.dart';
import 'package:flutter_application_1/screens/registration/parent_reg.dart';
import 'package:flutter_application_1/screens/registration/select_reg.dart';
import 'package:flutter_application_1/screens/registration/therapist_reg.dart';
import 'package:flutter_application_1/splash_page.dart';
import 'package:flutter_application_1/screens/therapist/ther_gallery.dart';
import 'package:flutter_application_1/screens/therapist/ther_profile.dart';
import 'package:flutter_application_1/screens/therapist/ther_review.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TherapEase',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF006A5B)),
        useMaterial3: true,
      ),
      home: const SplashScreen(), // Set LoginAs as the home route
      routes: {
        '/splash': (context) => const SplashScreen(),
        '/loginas': (context) => const LoginAs(),
        '/login': (context) => const LoginPage(),
        '/parentlogin': (context) => const ParentLogin(),
        '/therlogin': (context) => const TherapistLogin(),
        '/selectregistrationas': (context) => const SelectRegister(),
        '/parentregistration': (context) => const ParentRegister(),
        '/therapistregister': (context) => const TherapistRegister(
              type: '',
            ),
        '/clinicregister': (context) => const ClinicRegister(),
        '/homeclinic': (context) => const HomeClinic(
              clinics: null,
              isEditable: false,
            ),
        '/clinicgallery': (context) => const ClinicGallery(),
        '/clinicreview': (context) => const ClinicReview(
              clinicId: null,
            ),
        '/therprofile': (context) => const TherapistProfile(),
        '/thergallery': (context) => const TherapistGallery(),
        '/therreview': (context) => const TherapistReview(),
        '/homedashboard': (context) => const HomeDashboard(),
        '/therapiststab': (context) => const TherapistsDashboard(),
        '/patientlist': (context) => const PatientList(),
        '/messagescreen': (context) => const MessageScreen(
              isParent: true,
            ),
        '/chatscreen': (context) => const ChatScreen(),
        '/mappage': (context) => const MapPage(),
        '/parentprofile': (context) =>
            const HomeParentDashboard(), // Set RegistrationPage as a secondary route
      },
    );
  }
}
