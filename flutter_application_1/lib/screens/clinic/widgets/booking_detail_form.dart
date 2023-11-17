import 'package:flutter/material.dart';

class BookingDetail extends StatelessWidget {
  const BookingDetail(
      {super.key,
      required this.title,
      required this.data,
      required this.icon,
      required this.note,
      this.textEditingController});
  final bool note;
  final String title;
  final String data;
  final IconData icon;
  final TextEditingController? textEditingController;
  @override
  Widget build(BuildContext context) {
    final Size mq = MediaQuery.of(context).size;
    return SizedBox(
      width: mq.width * 0.85,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(title),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                height: !note ? mq.height * 0.07 : mq.height * 0.15,
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
                      Icon(
                        icon,
                        color: const Color(0xFF006A5B),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      !note
                          ? Text(
                              data,
                              style: const TextStyle(color: Colors.black54),
                            )
                          : Flexible(
                              child: TextField(
                                controller: textEditingController,
                                maxLines: 3,
                                style: const TextStyle(
                                  color: Colors.black54,
                                  fontSize: 13,
                                ),
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                    ],
                  ),
                )),
          )
        ],
      ),
    );
  }
}
