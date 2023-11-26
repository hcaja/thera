import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/http_bookingcontroller.dart';
import 'package:flutter_application_1/controller/httplogin_controller.dart';
import 'package:flutter_application_1/models/booking.dart';
import 'package:flutter_application_1/models/clinic_profiles.dart';
import 'package:flutter_application_1/screens/clinic/widgets/detail_time_duration.dart';
import 'package:flutter_application_1/screens/widgets/booking_detail_dropdown.dart';
import 'package:flutter_application_1/screens/widgets/booking_detail_form.dart';
import 'package:flutter_application_1/screens/widgets/template_background.dart';

class ConfirmBookingScreen extends StatefulWidget {
  const ConfirmBookingScreen({super.key, required this.appointment});
  final Appointment appointment;
  @override
  State<ConfirmBookingScreen> createState() => _ConfirmBookingScreenState();
}

class _ConfirmBookingScreenState extends State<ConfirmBookingScreen> {
  bool isLoading = false;
  ClinicLogin clinicLogin = ClinicLogin();
  BookingController bookingController = BookingController();
  late List<Employee> employees;
  late Employee selected;
  @override
  void initState() {
    _getLookup();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size mq = MediaQuery.of(context).size;
    return BackgroundBooking(
        child: Positioned(
            child: isLoading
                ? Column(
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
                          'Confirm Booking',
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
                                                data: widget.appointment.parent!
                                                    .fullname!,
                                                icon: Icons.person,
                                                note: false,
                                              ),
                                              BookingDetail(
                                                title: 'Contact Information',
                                                data: widget.appointment.parent!
                                                    .contactNumber!,
                                                icon: Icons.phone,
                                                note: false,
                                              ),
                                              BookingDetail(
                                                title: 'Note',
                                                data: widget.appointment.note!,
                                                icon: Icons.note_sharp,
                                                note: false,
                                              ),
                                              TimeDurationDetail(
                                                timeData: widget
                                                    .appointment.timeslot!,
                                              ),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              BookingDetailDropdown(
                                                employees: employees,
                                                callback: (value) {
                                                  selected = value;
                                                },
                                              ),
                                              SizedBox(
                                                width: mq.width * 0.5,
                                                child: ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      backgroundColor:
                                                          const Color(
                                                              0xFF006A5B),
                                                      foregroundColor:
                                                          Colors.white,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                    ),
                                                    onPressed: () {
                                                      bookingController
                                                          .acceptAppointments(
                                                              widget.appointment
                                                                  .id!,
                                                              selected.id)
                                                          .then((value) {
                                                        if (value) {
                                                          Navigator.pop(
                                                              context);
                                                        }
                                                      });
                                                    },
                                                    child: const Text(
                                                      'Confirm Booking',
                                                    )),
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
                  )
                : const Center(
                    child: CircularProgressIndicator(),
                  )));
  }

  void _getLookup() {
    clinicLogin
        .getProfiles(context, widget.appointment.clinic!.id)
        .then((value) {
      setState(() {
        employees = value;
        isLoading = true;
      });
    });
  }
}
