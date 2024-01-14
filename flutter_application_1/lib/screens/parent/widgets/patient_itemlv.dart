import 'package:flutter/material.dart';

class PatientListViewItem extends StatelessWidget {
  const PatientListViewItem(
      {super.key, required this.name, required this.userName});
  final String name;
  final String userName;
  @override
  Widget build(BuildContext context) {
    final Size mq = MediaQuery.of(context).size;
    return Container(
        width: mq.width * 0.9,
        height: 50,
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(
            color: const Color.fromARGB(255, 255, 255, 255),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: const TextStyle(fontSize: 18),
              maxLines: 1,
            ),
            Text(userName),
          ],
        ));
  }
}
