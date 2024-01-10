import 'package:flutter/material.dart';

class ServicePill extends StatelessWidget {
  const ServicePill({
    super.key,
    required this.selected,
    required this.title,
    required this.onTap,
  });
  final bool selected;
  final String title;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8, top: 8, right: 4, left: 4),
        child: ClipRect(
          child: ElevatedButton(
            style: selected
                ? ElevatedButton.styleFrom(
                    side: const BorderSide(color: Colors.green))
                : null,
            onPressed: onTap,
            child: Text(title),
          ),
        ),
      ),
    );
  }
}
