import 'package:flutter/material.dart';

class CustomDropDownReg extends StatefulWidget {
  const CustomDropDownReg({
    super.key,
    this.setRole,
  });
  final Function(int)? setRole;
  @override
  State<CustomDropDownReg> createState() => _CustomDropDownRegState();
}

class _CustomDropDownRegState extends State<CustomDropDownReg> {
  int selectedRole = 1;
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
        child: DropdownButton<int>(
          value: selectedRole,
          onChanged: (int? newValue) {
            setState(() {
              selectedRole = newValue!;
              widget.setRole!(newValue);
            });
          },
          items: <int>[1, 2] // 2 for Secretary, 1 for Therapist
              .map<DropdownMenuItem<int>>((int value) {
            String roleText = (value == 1) ? 'Therapist' : 'Secretary';
            return DropdownMenuItem<int>(
              value: value,
              child: Text(roleText),
            );
          }).toList(),
        ));
  }
}
