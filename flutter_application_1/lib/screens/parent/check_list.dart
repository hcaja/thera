import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/httpclinic_controller.dart';
import 'package:flutter_application_1/models/booking.dart';
import 'package:flutter_application_1/models/materials.dart';
import 'package:flutter_application_1/screens/parent/screens/journal_add.dart';

class CustomCheckboxListTile extends StatefulWidget {
  const CustomCheckboxListTile({
    Key? key,
    required this.parent,
  }) : super(key: key);
  final Parent parent;
  @override
  State<CustomCheckboxListTile> createState() => _CustomCheckboxListTileState();
}

class _CustomCheckboxListTileState extends State<CustomCheckboxListTile> {
  List checklist = [];
  ClinicController clinicController = ClinicController();
  @override
  void initState() {
    reload();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        children: <Widget>[
          for (int i = 0; i < checklist.length; i++)
            Container(
              margin: const EdgeInsets.symmetric(vertical: 5),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: const Color.fromARGB(255, 0, 0, 0), // Border color
                  width: 1.0, // Border width
                ),
                borderRadius: BorderRadius.circular(15.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 1,
                    offset: const Offset(0, 1), // changes position of shadow
                  ),
                ],
              ),
              child: CheckboxListTile(
                value: checklist[i].checked,
                onChanged: (bool? value) {
                  setState(() {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => JournalAdd(
                          checklist: checklist[i],
                          reload: reload,
                        ),
                      ),
                    );
                  });
                },
                title: Text(
                  checklist[i].checklist!,
                  style: const TextStyle(
                      fontFamily: 'Poppin', fontWeight: FontWeight.w600),
                ),
                controlAffinity: ListTileControlAffinity
                    .leading, // Place the checkbox on the leading side
                activeColor: const Color(
                    0xFF006A5C), // Change the color of the checked checkbox
                checkColor: Colors.white, // Change the color of the checkmark
              ),
            ),
        ],
      ),
    );
  }

  void reload() {
    clinicController.getChecklistByParent(widget.parent.id!).then((value) {
      setState(() {
        checklist = value;
      });
    });
  }
}
