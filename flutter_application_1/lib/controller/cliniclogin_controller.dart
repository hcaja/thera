import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/auth/connection.dart';
import 'package:flutter_application_1/screens/clinic/clinic_profile.dart';
import 'package:flutter_application_1/screens/parent/dashboard.dart';
import 'package:flutter_application_1/screens/therapist/ther_profile.dart';
import 'package:pocketbase/pocketbase.dart';

class LoginClinic {
  Future<void> login(BuildContext context, username, password) async {
    try {
      final authData = await Connection.pb
          .collection('users')
          .authWithPassword(username, password);

      final label = authData.record!.data['label'];

      if (label == 'clinic') {
        // Show a message dialog that login is successful

        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const ClinicProfile(),
          ),
        );
        print('Login Successful!');
      } else {
        print('This account is not a parent account');
        Connection.pb.authStore.clear();
      }
    } catch (error) {
      if (error is ClientException) {
        var status = error.statusCode;
        if (status == 400) {
          print('The username or password is incorrect!');
        }
      }
    }
  }
}

class LoginParent {
  Future<void> login(BuildContext context, username, password) async {
    try {
      final authData = await Connection.pb
          .collection('users')
          .authWithPassword(username, password);

      final label = authData.record!.data['label'];

      if (label == 'parent') {
        // Show a message dialog that login is successful

        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const Dashboard(),
          ),
        );
        print('Login Successful!');
      } else {
        print('This account is not a parent account');
        Connection.pb.authStore.clear();
      }
    } catch (error) {
      if (error is ClientException) {
        var status = error.statusCode;
        if (status == 400) {
          print('The username or password is incorrect!');
        }
      }
    }
  }
}

class LoginTherapist {
  Future<void> login(BuildContext context, username, password) async {
    try {
      final authData = await Connection.pb
          .collection('users')
          .authWithPassword(username, password);

      final label = authData.record!.data['label'];

      if (label == 'therapist') {
        // Show a message dialog that login is successful

        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const TherapistProfile(),
          ),
        );
        print('Login Successful!');
      } else {
        print('This account is not a parent account');
        Connection.pb.authStore.clear();
      }
    } catch (error) {
      if (error is ClientException) {
        var status = error.statusCode;
        if (status == 400) {
          print('The username or password is incorrect!');
        }
      }
    }
  }
}
