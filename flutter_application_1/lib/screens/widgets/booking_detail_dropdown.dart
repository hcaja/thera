import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/clinic_profiles.dart';

class BookingDetailDropdown extends StatefulWidget {
  const BookingDetailDropdown({
    super.key,
    required this.employees,
    required this.callback,
  });
  final List<Employee> employees;
  final Function(Employee) callback;

  @override
  State<BookingDetailDropdown> createState() => _BookingDetailDropdownState();
}

class _BookingDetailDropdownState extends State<BookingDetailDropdown> {
  late Employee selectedEmployee;

  @override
  void initState() {
    selectedEmployee = widget.employees[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size mq = MediaQuery.of(context).size;
    return SizedBox(
      width: mq.width * 0.85,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 10),
            child: Text('Select Available Therapist'),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                height: mq.height * 0.07,
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
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: double.infinity,
                        child: Center(
                          child: Icon(
                            Icons.person,
                            color: Color(0xFF006A5B),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      DropdownButton<Employee>(
                        underline: Container(),
                        value: selectedEmployee,
                        onChanged: (Employee? newValue) {
                          setState(() {
                            selectedEmployee = newValue!;
                            widget.callback(newValue);
                          });
                        },
                        items: widget.employees.map<DropdownMenuItem<Employee>>(
                            (Employee employee) {
                          return DropdownMenuItem<Employee>(
                            value: employee,
                            child: SizedBox(
                              width: mq.width * 0.57,
                              child: Text(employee.name),
                            ),
                          );
                        }).toList(),
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
