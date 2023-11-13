import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/http_bookingcontroller.dart';
import 'package:flutter_application_1/models/booking.dart';
import 'package:intl/intl.dart';

class AddBooking extends StatefulWidget {
  const AddBooking(
      {super.key, required this.datePicked, required this.onResult});
  final DateTime? datePicked;
  final Function(TimeData timeData) onResult;
  @override
  State<AddBooking> createState() => _AddBookingState();
}

class _AddBookingState extends State<AddBooking> {
  int rows = 1;
  List<bool> showButtons = [true];
  late TimeData td;
  BookingController bookingController = BookingController();
  bool isloading = true;
  @override
  void initState() {
    td = TimeData(
      date: widget.datePicked,
      startTime: null,
      endTime: null,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Future<void> timePicker(int order) async {
      final TimeOfDay? time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );
      setState(() {
        if (order == 1) {
          td.startTime = time;
        } else {
          td.endTime = time;
        }
      });
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 50),
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Set Time Slot for:',
              style: TextStyle(fontWeight: FontWeight.w300, fontSize: 13),
            ),
            Text(
              DateFormat('MMMM dd, yyyy').format(widget.datePicked!),
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 15),
            SingleChildScrollView(
              child: SizedBox(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () async {
                              timePicker(1);
                            },
                            child: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                border: Border.all(
                                  color:
                                      const Color.fromARGB(255, 255, 255, 255),
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
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: td.startTime == null
                                    ? const Text('Select time')
                                    : Text(td.startTime!.format(context)),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 30,
                          child: Center(child: Text('to')),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () async {
                              timePicker(2);
                            },
                            child: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                border: Border.all(
                                  color:
                                      const Color.fromARGB(255, 255, 255, 255),
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
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: td.endTime == null
                                    ? const Text('Select time')
                                    : Text(td.endTime!.format(context)),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF006A5B),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {
                          if (td.endTime != null && td.startTime != null) {
                            isloading = true;
                            bookingController.saveTimeData(td).then((value) {
                              if (value.id != null) {
                                td.id = value.id;
                                widget.onResult(td);
                                Navigator.pop(context);
                                isloading = false;
                              }
                            });
                          }
                        },
                        child: isloading
                            ? const Text(
                                'Add Time',
                              )
                            : const CircularProgressIndicator.adaptive(),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
