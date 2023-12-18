import 'package:flutter/material.dart';

class CustomCheckboxListTile extends StatefulWidget {
  const CustomCheckboxListTile({Key? key}) : super(key: key);

  @override
  State<CustomCheckboxListTile> createState() => _CustomCheckboxListTileState();
}

class _CustomCheckboxListTileState extends State<CustomCheckboxListTile> {
  bool checkboxValue1 = true;
  bool checkboxValue2 = true;
  bool checkboxValue3 = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: const Color.fromARGB(255, 0, 0, 0), // Border color
                width: 1.0, // Border width
              ),
              borderRadius: BorderRadius.circular(15.0),
              boxShadow: [
                // black shadow
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 1,
                  offset: const Offset(0, 1), // changes position of shadow
                ),
              ],
            ),
            child: CheckboxListTile(
              value: checkboxValue1,
              onChanged: (bool? value) {
                setState(() {
                  checkboxValue1 = value ?? false;
                });
              },
              title: const Text(
                'Checklist 1',
                style: TextStyle(
                    fontFamily: 'Poppin', fontWeight: FontWeight.w600),
              ),
              controlAffinity: ListTileControlAffinity
                  .leading, // Place the checkbox on the leading side
              activeColor: const Color(
                  0xFF006A5C), // Change the color of the checked checkbox
              checkColor: Colors.white, // Change the color of the checkmark
            ),
          ),
          const SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: const Color.fromARGB(255, 0, 0, 0), // Border color
                width: 1.0, // Border width
              ),
              borderRadius: BorderRadius.circular(15.0),
              boxShadow: [
                // black shadow
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 1,
                  offset: const Offset(0, 1), // changes position of shadow
                ),
              ],
            ),
            child: CheckboxListTile(
              value: checkboxValue2,
              onChanged: (bool? value) {
                setState(() {
                  checkboxValue2 = value ?? false;
                });
              },
              title: const Text(
                'Checklist 2',
                style: TextStyle(
                    fontFamily: 'Poppin', fontWeight: FontWeight.w600),
              ),
              controlAffinity: ListTileControlAffinity
                  .leading, // Place the checkbox on the leading side
              activeColor: const Color(
                  0xFF006A5C), // Change the color of the checked checkbox
              checkColor: Colors.white, // Change the color of the checkmark
            ),
          ),
          const SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: const Color.fromARGB(255, 0, 0, 0), // Border color
                width: 1.0, // Border width
              ),
              borderRadius: BorderRadius.circular(15.0),
              boxShadow: [
                // black shadow
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 1,
                  offset: const Offset(0, 1), // changes position of shadow
                ),
              ],
            ),
            child: CheckboxListTile(
              value: checkboxValue3,
              onChanged: (bool? value) {
                setState(() {
                  checkboxValue3 = value ?? false;
                });
              },
              title: const Text(
                'Checklist 3',
                style: TextStyle(
                    fontFamily: 'Poppin', fontWeight: FontWeight.w600),
              ),
              controlAffinity: ListTileControlAffinity
                  .leading, // Place the checkbox on the leading side
              activeColor: const Color(
                  0xFF006A5C), // Change the color of the checked checkbox
              checkColor: Colors.white, // Change the color of the checkmark
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
