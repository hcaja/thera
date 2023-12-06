import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/http_bookingcontroller.dart';
import 'package:flutter_application_1/controller/httpclinic_controller.dart';
import 'package:flutter_application_1/models/booking.dart';
import 'package:flutter_application_1/models/clinic_profiles.dart';
import 'package:flutter_application_1/screens/clinic/screens/parent_schedule_booking.dart';
import 'package:flutter_application_1/screens/video_call/screens/vidcall.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';

class ScheduleClientCalendar extends StatefulWidget {
  const ScheduleClientCalendar({
    super.key,
    this.clinic,
  });
  final Clinics? clinic;

  @override
  ScheduleClientCalendarState createState() => ScheduleClientCalendarState();
}

final kToday = DateTime.now();
final kFirstDay = DateTime(kToday.year, kToday.month - 3, kToday.day);
final kLastDay = DateTime(kToday.year, kToday.month + 3, kToday.day);

List<DateTime> daysInRange(DateTime first, DateTime last) {
  final dayCount = last.difference(first).inDays + 1;
  return List.generate(
    dayCount,
    (index) => DateTime.utc(first.year, first.month, first.day + index),
  );
}

class ScheduleClientCalendarState extends State<ScheduleClientCalendar> {
  late final ValueNotifier<List<ParentTimeData>> _selectedEvents;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode
      .toggledOff; // Can be toggled on/off by longpressing a date
  ClinicController clinicController = ClinicController();
  BookingController bookingController = BookingController();
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;
  Map<DateTime, List<ParentTimeData>> events = {};
  Offset position = const Offset(0.0, 0.0);
  bool isLoading = false;

  Future<String> getName(int? clinic) async {
    String res = '';
    clinicController.getClinic(clinic!).then((value) {
      res = value.name!;
    });
    return res;
  }

  void _getUserdata() async {
    await SharedPreferences.getInstance().then((value) {
      String? token = value.getString('parentToken');
      Map<String, dynamic> payload = JwtDecoder.decode(token!);
      bookingController
          .getParent(payload['ID'])
          .then((value) => parent = value);
    });
  }

  @override
  void initState() {
    _getUserdata();
    clinicController.getParentTimeData().then((value) {
      setState(() {
        events = value;
        isLoading = true;
        _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
      });
    });
    _selectedDay = _focusedDay;

    isLoading = false;
    super.initState();
  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  List<ParentTimeData> _getEventsForDay(DateTime day) {
    return events[DateTime(day.year, day.month, day.day)] ?? [];
  }

  List<ParentTimeData> _getEventsForRange(DateTime start, DateTime end) {
    // Implementation example
    final days = daysInRange(start, end);

    return [
      for (final d in days) ..._getEventsForDay(d),
    ];
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        _rangeStart = null; // Important to clean those
        _rangeEnd = null;
        _rangeSelectionMode = RangeSelectionMode.toggledOff;
      });

      _selectedEvents.value = _getEventsForDay(selectedDay);
    }
  }

  void _onRangeSelected(DateTime? start, DateTime? end, DateTime focusedDay) {
    setState(() {
      _selectedDay = null;
      _focusedDay = focusedDay;
      _rangeStart = start;
      _rangeEnd = end;
      _rangeSelectionMode = RangeSelectionMode.toggledOn;
    });

    // `start` or `end` could be null
    if (start != null && end != null) {
      _selectedEvents.value = _getEventsForRange(start, end);
    } else if (start != null) {
      _selectedEvents.value = _getEventsForDay(start);
    } else if (end != null) {
      _selectedEvents.value = _getEventsForDay(end);
    }
  }

  late Parent? parent;
  @override
  Widget build(BuildContext context) {
    final Size mq = MediaQuery.of(context).size;
    return isLoading
        ? Positioned(
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: mq.height * 0.07,
                child: const Center(
                    child: Text(
                  'Schedules',
                  style: TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontSize: 20,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w900,
                  ),
                )),
              ),
              SizedBox(
                height: mq.height * 0.02,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  'Select Schedule',
                  style: TextStyle(
                    color: Color(0xFF006A5B),
                    fontSize: 20,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              TableCalendar<ParentTimeData>(
                firstDay: kFirstDay,
                lastDay: kLastDay,
                focusedDay: _focusedDay,
                selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                rangeStartDay: _rangeStart,
                rangeEndDay: _rangeEnd,
                calendarFormat: _calendarFormat,
                rangeSelectionMode: _rangeSelectionMode,
                eventLoader: (day) {
                  return _getEventsForDay(day);
                },
                startingDayOfWeek: StartingDayOfWeek.sunday,
                calendarStyle: CalendarStyle(
                  todayDecoration: BoxDecoration(
                      color: const Color(0xFF006A5B).withOpacity(0.5),
                      shape: BoxShape.circle),
                  selectedDecoration: const BoxDecoration(
                      color: Color(0xFF006A5B), shape: BoxShape.circle),
                  outsideDaysVisible: false,
                ),
                onDaySelected: _onDaySelected,
                onRangeSelected: _onRangeSelected,
                onFormatChanged: (format) {
                  if (_calendarFormat != format) {
                    setState(() {
                      _calendarFormat = format;
                    });
                  }
                },
                onPageChanged: (focusedDay) {
                  _focusedDay = focusedDay;
                },
              ),
              const SizedBox(height: 8.0),
              Padding(
                padding: const EdgeInsets.only(left: 15, bottom: 10),
                child: widget.clinic != null
                    ? const Text('Available Timeslot:')
                    : const Text('Schedule'),
              ),
              SizedBox(
                height: mq.height * 0.25,
                child: ValueListenableBuilder<List<ParentTimeData>>(
                  valueListenable: _selectedEvents,
                  builder: (context, value, _) {
                    return ListView.builder(
                        itemCount: value.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => ParentScheduleBooking(
                                    timeData: value[index],
                                  ),
                                ),
                              );
                            },
                            child: Container(
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 12.0,
                                  vertical: 4.0,
                                ),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 15),
                                decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 240, 244, 244),
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(value[index].clinic!.name!),
                                        Text(
                                          ' ${value[index].startTime!.format(context)} - ${value[index].endTime!.format(context)}',
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        jumpToCallPage(context,
                                            roomID:
                                                value[index].booking.toString(),
                                            localUserID: 'PARENT${parent!.id}',
                                            localUserName: parent!.fullname);
                                      },
                                      child: const Icon(
                                        Icons.videocam_rounded,
                                        color: Color(0xFF006A5B),
                                      ),
                                    ),
                                  ],
                                )),
                          );
                        });
                  },
                ),
              ),
            ],
          ))
        : const Center(
            child: CircularProgressIndicator(),
          );
  }

  void jumpToCallPage(BuildContext context,
      {required String roomID,
      required String localUserID,
      required String? localUserName}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CallPage(
          localUserID: localUserID,
          localUserName: localUserName,
          roomID: roomID,
        ),
      ),
    );
  }
}
