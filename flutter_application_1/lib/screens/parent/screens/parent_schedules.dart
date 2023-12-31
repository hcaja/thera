import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/clinic/widgets/schedule_calendar_view.dart';
import 'package:flutter_application_1/screens/widgets/template_background.dart';

class ParentSchedules extends StatefulWidget {
  const ParentSchedules({super.key});

  @override
  State<ParentSchedules> createState() => _ParentSchedulesState();
}

class _ParentSchedulesState extends State<ParentSchedules> {
  @override
  Widget build(BuildContext context) {
    return const BackgroundBooking(
      child: ScheduleClientCalendar(),
    );
  }
}
