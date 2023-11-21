import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/booking.dart';
import 'package:flutter_application_1/screens/video_call/screens/vidcall.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

void jumpToCallPage(BuildContext context,
    {required String roomID,
    required String localUserID,
    required String localUserName}) {
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

class ScheduleItem extends StatefulWidget {
  const ScheduleItem(
      {required this.mq,
      Key? key,
      required this.appointment,
      required this.request})
      : super(key: key);

  final Size mq;
  final Appointment appointment;
  final bool request;

  @override
  State<ScheduleItem> createState() => _ScheduleItemState();
}

class _ScheduleItemState extends State<ScheduleItem> {
  @override
  void initState() {
    _getUserdata();
    super.initState();
  }

  void _getUserdata() async {
    await SharedPreferences.getInstance().then((value) {
      String? token = value.getString('parentToken');
      Map<String, dynamic> payload = JwtDecoder.decode(token!);
      id = payload['ID'];
    });
  }

  int? id;
  bool selected = true;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: GestureDetector(
        onTap: () {
          setState(() {
            selected = !selected;
          });
        },
        child: Container(
          height: !selected ? widget.mq.height * 0.4 : widget.mq.height * 0.1,
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: widget.mq.height * 0.1,
                    width: widget.mq.width * 0.88,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: SizedBox(
                                  child: Text(
                                    widget.appointment.parent!.fullname!,
                                    maxLines: 1,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20.0 -
                                          (widget.appointment.parent!.fullname!
                                                      .length *
                                                  0.3)
                                              .toInt(),
                                    ),
                                  ),
                                ),
                              ),
                              !selected
                                  ? GestureDetector(
                                      onTap: () {
                                        jumpToCallPage(context,
                                            roomID: widget.appointment.id
                                                .toString(),
                                            localUserID: id.toString(),
                                            localUserName: widget.appointment
                                                .therapist!.username);
                                      },
                                      child: Container(
                                        margin: const EdgeInsets.only(left: 10),
                                        child: const Icon(
                                          Icons.videocam_sharp,
                                          color: Color(0xFF006A5B),
                                        ),
                                      ),
                                    )
                                  : const SizedBox(),
                              const SizedBox(
                                width: 15,
                              ),
                              const SizedBox(
                                width: 1,
                                height: double.infinity,
                                child: ColoredBox(
                                  color: Color.fromRGBO(0, 0, 0, 0.5),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.access_time,
                                size: 12,
                              ),
                              Expanded(
                                child: Text(
                                  '${widget.appointment.timeslot!.startTime!.format(context)} - ${widget.appointment.timeslot!.endTime!.format(context)} ',
                                  style: const TextStyle(fontSize: 12),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: !widget.request
                              ? Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(
                                      Icons.person,
                                      size: 12,
                                    ),
                                    Expanded(
                                      child: Text(
                                        widget.appointment.therapist!.name,
                                        style: const TextStyle(fontSize: 12),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    )
                                  ],
                                )
                              : const Row(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Icon(
                                      Icons.navigate_next,
                                      size: 25,
                                      color: Colors.blue,
                                    ),
                                  ],
                                ),
                        ),
                      ],
                    ),
                  ),
                  !selected
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Note:'),
                            Text(widget.appointment.note!),
                          ],
                        )
                      : const SizedBox()
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
