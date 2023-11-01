import 'package:flutter/material.dart';

class CircularLoadingButton extends StatelessWidget {
  const CircularLoadingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 149, 167, 164),
          padding: const EdgeInsets.symmetric(
            vertical: 12.0,
          ),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: () {},
        child: const CircularProgressIndicator());
  }
}
