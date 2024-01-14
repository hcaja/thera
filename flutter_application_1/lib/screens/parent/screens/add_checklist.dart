import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/booking.dart';
import 'package:flutter_application_1/screens/parent/widgets/add_checklistcomp.dart';
import 'package:flutter_application_1/screens/widgets/app_drawer.dart';
import 'package:flutter_application_1/screens/widgets/app_drawer_therapist.dart';

class AddCheckList extends StatefulWidget {
  const AddCheckList({
    super.key,
    required this.isParent,
    required this.parent,
  });
  final bool isParent;
  final Parent parent;

  @override
  AddCheckListState createState() => AddCheckListState();
}

class AddCheckListState extends State<AddCheckList> {
  @override
  Widget build(BuildContext context) {
    final Size mq = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Parent Checklist List',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF006A5B),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              color: Colors.white,
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      drawer: !widget.isParent ? const AppDrawer() : const AppDrawerTherapist(),
      body: Stack(
        children: [
          // Top background
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 200, // Define the desired height for the top background
            child: Container(
              color: const Color(0xFF006A5B), // Or use your own decoration
            ),
          ),

          // bottom background
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: ConstrainedBox(
              constraints: BoxConstraints.expand(height: mq.height * 0.3),
              child: Image.asset(
                'asset/images/Ellipse 2.png',
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Main na screen
          Column(
            children: [
              const SizedBox(height: 30),

              /// E expand kay need para makuha tanan availalble na screen
              Expanded(
                child: AddChecklistComp(
                  parent: widget.parent,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
