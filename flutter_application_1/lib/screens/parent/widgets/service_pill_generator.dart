import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/services_offered.dart';
import 'package:flutter_application_1/screens/parent/widgets/service_pill.dart';

class ServicePillGenerator extends StatefulWidget {
  const ServicePillGenerator(
      {super.key, required this.services, required this.callback});
  final List<Services> services;
  final ValueChanged<int> callback;
  @override
  State<ServicePillGenerator> createState() => _ServicePillGeneratorState();
}

class _ServicePillGeneratorState extends State<ServicePillGenerator> {
  int selectedServiceIndex = -1;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.services.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return ServicePill(
          selected: index == selectedServiceIndex,
          title: widget.services[index].desc,
          onTap: () {
            setState(() {
              if (index == selectedServiceIndex) {
                selectedServiceIndex = -1;
              } else {
                selectedServiceIndex = index;
              }
              widget.callback(selectedServiceIndex);
            });
          },
        );
      },
    );
  }
}
