import 'package:flutter/material.dart';

class ScheduleItem extends StatefulWidget {
  const ScheduleItem(
      {required this.mq,
      Key? key,
      required this.parentName,
      required this.time,
      required this.therapist,
      required this.request})
      : super(key: key);

  final Size mq;
  final String parentName;
  final String time;
  final String therapist;
  final bool request;

  @override
  State<ScheduleItem> createState() => _ScheduleItemState();
}

class _ScheduleItemState extends State<ScheduleItem> {
  bool selected = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: Container(
            height:
                selected ? widget.mq.height * 0.08 : widget.mq.height * 0.08,
            width: widget.mq.width * 0.9,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),

              color: Colors.white, // White color
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
                SizedBox(
                  width: widget.mq.width * 0.03,
                ),
                Text(
                  widget.parentName,
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize:
                          20.0 - (widget.parentName.length * 0.2).toInt()),
                ),
                SizedBox(
                  width: widget.mq.width * 0.02,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: SizedBox(
                    width: 1,
                    height: double.infinity,
                    child: ColoredBox(
                      color: Color.fromRGBO(0, 0, 0, 0.5),
                    ),
                  ),
                ),
                SizedBox(
                  width: widget.mq.width * 0.02,
                ),
                SizedBox(
                  child: Row(
                    children: [
                      const Icon(
                        Icons.access_time,
                        size: 12,
                      ),
                      Text(
                        widget.time,
                        style: const TextStyle(fontSize: 12),
                      )
                    ],
                  ),
                ),
                !widget.request
                    ? SizedBox(
                        width: widget.mq.width * 0.02,
                      )
                    : SizedBox(
                        width: widget.mq.width * 0.15,
                      ),
                !widget.request
                    ? SizedBox(
                        child: Row(
                          children: [
                            const Icon(
                              Icons.person,
                              size: 12,
                            ),
                            Text(
                              widget.therapist,
                              style: const TextStyle(fontSize: 12),
                            )
                          ],
                        ),
                      )
                    : const SizedBox(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Icon(
                              Icons.navigate_next,
                              size: 25,
                              color: Colors.blue,
                            ),
                          ],
                        ),
                      )
              ],
            )));
  }
}
