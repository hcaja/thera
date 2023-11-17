import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/httpclinic_controller.dart';
import 'package:flutter_application_1/models/booking.dart';
import 'package:flutter_application_1/models/clinic_profiles.dart';
import 'package:flutter_application_1/screens/clinic/screens/schedule_booking.dart';
import 'package:table_calendar/table_calendar.dart';

class ClientCalendar extends StatefulWidget {
  const ClientCalendar({
    super.key,
    required this.clinic,
  });
  final Clinics? clinic;

  @override
  ClientCalendarState createState() => ClientCalendarState();
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

class ClientCalendarState extends State<ClientCalendar> {
  late final ValueNotifier<List<TimeData>> _selectedEvents;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode
      .toggledOff; // Can be toggled on/off by longpressing a date
  ClinicController bookingController = ClinicController();
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;
  Map<DateTime, List<TimeData>> events = {};
  Offset position = const Offset(0.0, 0.0);
  bool isLoading = false;

  @override
  void initState() {
    bookingController.getTimeData(widget.clinic!.id).then((value) {
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

  List<TimeData> _getEventsForDay(DateTime day) {
    return events[DateTime(day.year, day.month, day.day)] ?? [];
  }

  List<TimeData> _getEventsForRange(DateTime start, DateTime end) {
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
                child: Center(
                    child: Text(
                  widget.clinic!.name,
                  style: const TextStyle(
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
                  'Booking Process',
                  style: TextStyle(
                    color: Color(0xFF006A5B),
                    fontSize: 20,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              TableCalendar<TimeData>(
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
              const Padding(
                padding: EdgeInsets.only(left: 15, bottom: 10),
                child: Text('Available Timeslot:'),
              ),
              SizedBox(
                height: mq.height * 0.07,
                child: ValueListenableBuilder<List<TimeData>>(
                  valueListenable: _selectedEvents,
                  builder: (context, value, _) {
                    return ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: value.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => ScheduleBooking(
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
                                  vertical: 10, horizontal: 10),
                              decoration: BoxDecoration(
                                color: const Color(0xFF006A5B),
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              child: Center(
                                child: Text(
                                  ' ${value[index].startTime!.format(context)} - ${value[index].endTime!.format(context)}',
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
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
}
