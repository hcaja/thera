import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/booking.dart';
import 'package:intl/intl.dart';

class TimeDurationDetail extends StatelessWidget {
  const TimeDurationDetail({
    super.key,
    required this.timeData,
  });
  final TimeData timeData;
  @override
  Widget build(BuildContext context) {
    final Size mq = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 10),
          child: Text('Date and Time'),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
              height: mq.height * 0.07,
              width: mq.width * 0.8,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
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
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.calendar_month,
                      color: Color(0xFF006A5B),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      '${DateFormat('MMMM dd, ').format(timeData.date!)} ${timeData.startTime!.format(context)} to ${timeData.endTime!.format(context)}',
                      style: const TextStyle(color: Colors.black54),
                    )
                  ],
                ),
              )),
        )
      ],
    );
  }
}
