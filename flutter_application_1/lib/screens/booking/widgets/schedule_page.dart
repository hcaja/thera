import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/http_bookingcontroller.dart';
import 'package:flutter_application_1/models/booking.dart';
import 'package:flutter_application_1/screens/booking/screens/events_calendar.dart';
import 'package:flutter_application_1/screens/booking/widgets/schedule_item.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({Key? key}) : super(key: key);

  @override
  State<SchedulePage> createState() => _SchedulePage();
}

class _SchedulePage extends State<SchedulePage> {
  BookingController bookingController = BookingController();
  late List<Appointment> appointments;
  bool isloading = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      isloading = true;
    });
    _getUserdata().then((id) {
      bookingController.getAppointments(id,2).then((value) {
        setState(() {
          appointments = value;
          isloading = false;
        });
      });
    });
  }

  Future<int> _getUserdata() async {
    int id = 1;
    await SharedPreferences.getInstance().then((value) {
      String? token = value.getString('employeeToken');
      Map<String, dynamic> payload = JwtDecoder.decode(token!);
      id = payload['ID'];
    });
    return id;
  }

  @override
  Widget build(BuildContext context) {
    final Size mq = MediaQuery.of(context).size;

    return Scaffold(
      // body
      body: Stack(
        children: [
          // top background
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
          !isloading
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: double.infinity,
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: mq.height * 0.07,
                            ),
                            const Text('September, 19, 2023'),
                            SizedBox(
                              height: mq.height * 0.01,
                            ),
                            SingleChildScrollView(
                              child: SizedBox(
                                height: mq.height * 0.8,
                                child: ListView.builder(
                                  itemCount: appointments.length,
                                  itemBuilder: (context, index) {
                                    return Column(
                                      children: [
                                        ScheduleItem(
                                            mq: mq,
                                            parentName: appointments[index]
                                                .parent!
                                                .fullname!,
                                            time:
                                                '${appointments[index].timeslot!.startTime!.format(context)} - ${appointments[index].timeslot!.endTime!.format(context)} ',
                                            therapist: appointments[index]
                                                .therapist!
                                                .name, request: false,),
                                        SizedBox(
                                          height: mq.height * 0.02,
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              : const Center(child: CircularProgressIndicator()),
          // Floating Action Button (FAB)
          Positioned(
            bottom: 35, // distance from the bottom
            right: 30, // distance from the right
            child: ClipOval(
              child: Material(
                color: const Color(0xFF006A5B), // FAB background color
                child: InkWell(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return const SizedBox(
                            width: double.infinity,
                            child: TableEventsExample());
                      },
                    );
                  },
                  child: const SizedBox(
                    width: 60, // size of the circular FAB
                    height: 60, // size of the circular FAB
                    child: Center(
                        child: Icon(
                      Icons.calendar_month,
                      color: Colors.white,
                    )),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
