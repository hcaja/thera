import 'package:flutter/material.dart';

class Dialogs {
  static void showSnackbar(BuildContext context, msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg),
      backgroundColor: Colors.pink.withOpacity(.8),
      behavior: SnackBarBehavior.floating,
    ));
  }

  static void showProgressBar(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) => const Center(child: CircularProgressIndicator()));
  }
}
