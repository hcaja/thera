import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/clinic_profiles.dart';
import 'package:flutter_application_1/screens/clinic/widgets/calendarview.dart';
import 'package:flutter_application_1/screens/widgets/template_background.dart';

class ParentBooking extends StatelessWidget {
  const ParentBooking({super.key, required this.clinics});
  final Clinics? clinics;
  @override
  Widget build(BuildContext context) {
    return BackgroundBooking(
        child: ClientCalendar(
      clinic: clinics,
    ));
  }
}
