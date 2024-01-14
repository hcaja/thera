import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/http_bookingcontroller.dart';
import 'package:flutter_application_1/controller/httpclinic_controller.dart';
import 'package:flutter_application_1/models/materials.dart';
import 'package:flutter_application_1/screens/widgets/template_background.dart';

class JournalAdd extends StatefulWidget {
  const JournalAdd({
    super.key,
    required this.checklist,
    required this.reload,
  });
  final Checklist checklist;
  final Function reload;
  @override
  State<JournalAdd> createState() => _JournalAddState();
}

class _JournalAddState extends State<JournalAdd> {
  bool isLoading = false;
  ClinicController clinicController = ClinicController();
  TextEditingController textEditingController = TextEditingController();
  @override
  void initState() {
    textEditingController.text = widget.checklist.journal!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size mq = MediaQuery.of(context).size;
    return BackgroundBooking(
        child: Positioned(
            child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: mq.height * 0.07,
        ),
        SizedBox(
          height: mq.height * 0.02,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Text(
            widget.checklist.checklist!,
            style: const TextStyle(
              color: Color(0xFF006A5B),
              fontSize: 20,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const SizedBox(height: 8.0),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 13),
            child: SingleChildScrollView(
              child: SizedBox(
                  child: Column(
                children: [
                  Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
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
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            controller: textEditingController,
                            maxLines:
                                9, // Set the maxLines property to make it multi-line
                            decoration: const InputDecoration(
                              hintText: 'Enter your text here',
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      )),
                  CheckboxListTile(
                    value: widget.checklist.checked,
                    onChanged: (bool? value) {
                      setState(() {
                        widget.checklist.checked = value ?? false;
                      });
                    },
                    title: const Text(
                      'Mark as Done',
                      style: TextStyle(
                          fontFamily: 'Poppin', fontWeight: FontWeight.w600),
                    ),
                    controlAffinity: ListTileControlAffinity
                        .leading, // Place the checkbox on the leading side
                    activeColor: const Color(
                        0xFF006A5C), // Change the color of the checked checkbox
                    checkColor:
                        Colors.white, // Change the color of the checkmark
                  ),
                  SizedBox(
                    width: mq.width * 0.9,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF006A5B),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {
                          clinicController
                              .saveJournal(textEditingController.text,
                                  widget.checklist.checked, widget.checklist.id)
                              .then((value) {
                            if (value) {
                              widget.reload;
                              Navigator.of(context).pop();
                            }
                          });
                        },
                        child: const Text(
                          'Save',
                        )),
                  ),
                ],
              )),
            ))
      ],
    )));
  }
}
