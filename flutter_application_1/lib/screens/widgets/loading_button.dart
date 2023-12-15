import 'package:flutter/material.dart';

class CircularLoadingButton extends StatelessWidget {
  const CircularLoadingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF006A5B),
            padding: const EdgeInsets.symmetric(
              vertical: 12.0,
              horizontal: 115.0,
            ),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
          ),
          onPressed: () {},
          child: const CircularProgressIndicator(
            color: Color.fromARGB(255, 149, 167, 164),
          )),
    );
  }
}
