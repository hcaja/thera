import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/http_bookingcontroller.dart';
import 'package:flutter_application_1/models/booking.dart';
import 'package:flutter_application_1/screens/clinic/widgets/booking_detail_form.dart';
import 'package:flutter_application_1/screens/clinic/widgets/detail_time_duration.dart';
import 'package:flutter_application_1/screens/clinic/widgets/template_background.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScheduleBooking extends StatefulWidget {
  const ScheduleBooking({super.key, required this.timeData});
  final TimeData timeData;

  @override
  State<ScheduleBooking> createState() => _ScheduleBookingState();
}

class _ScheduleBookingState extends State<ScheduleBooking> {
  late Parent parent;
  bool isloading = false;
  bool isSaving = false;
  TextEditingController noteController = TextEditingController();
  BookingController bookingController = BookingController();

  @override
  void initState() {
    _getUserdata();
    super.initState();
  }

  void _getUserdata() async {
    setState(() {
      isloading = true;
    });

    await SharedPreferences.getInstance().then((value) {
      String? token = value.getString('parentToken');
      Map<String, dynamic> payload = JwtDecoder.decode(token!);
      bookingController.getParent(payload['ID']).then((value) {
        setState(() {
          parent = value;
          isloading = false;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size mq = MediaQuery.of(context).size;

    void save() {
      setState(() {
        isSaving = true;
        bookingController
            .saveBooking(
          widget.timeData.id!,
          widget.timeData.clinic!,
          parent.id!,
          noteController.text,
        )
            .then((value) {
          isSaving = false;
          Navigator.pop(context);
        });
      });
    }

    return BackgroundBooking(
      child: Positioned(
          child: !isloading
              ? SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: mq.height * 0.07,
                      ),
                      SizedBox(
                        height: mq.height * 0.02,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(
                          'Booking Process',
                          style: TextStyle(
                            color: Color(0xFF006A5B),
                            fontSize: 20,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      SingleChildScrollView(
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 13),
                            child: SizedBox(
                                child: SingleChildScrollView(
                              child: Container(
                                  height: mq.height * 0.6,
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(10),
                                      bottomRight: Radius.circular(10),
                                    ),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Color(0x3F000000),
                                        blurRadius: 4,
                                        offset: Offset(0, 4),
                                        spreadRadius: 0,
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    children: [
                                      const SizedBox(
                                        width: 4,
                                        height: double.infinity,
                                        child: ColoredBox(
                                          color: Color(0xFF006A5B),
                                        ),
                                      ),
                                      SingleChildScrollView(
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 30,
                                              horizontal: mq.width * 0.03),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              BookingDetail(
                                                title: 'Name',
                                                data: parent.fullname!,
                                                icon: Icons.person,
                                                note: false,
                                              ),
                                              BookingDetail(
                                                title: 'Contact Information',
                                                data: parent.contactNumber!,
                                                icon: Icons.phone,
                                                note: false,
                                              ),
                                              BookingDetail(
                                                textEditingController:
                                                    noteController,
                                                title: 'Note',
                                                data: 'Note',
                                                icon: Icons.note_sharp,
                                                note: true,
                                              ),
                                              TimeDurationDetail(
                                                timeData: widget.timeData,
                                              ),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              SizedBox(
                                                width: mq.width * 0.5,
                                                child: ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        const Color(0xFF006A5B),
                                                    foregroundColor:
                                                        Colors.white,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                  ),
                                                  onPressed: () => save(),
                                                  child: !isSaving
                                                      ? const Text(
                                                          'Confirm Schedule',
                                                        )
                                                      : const Center(
                                                          child:
                                                              CircularProgressIndicator
                                                                  .adaptive()),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  )),
                            )),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              : const Center(
                  child: CircularProgressIndicator(),
                )),
    );
  }
}
