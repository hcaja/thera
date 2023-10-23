import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/auth/connection.dart';
import 'package:flutter_application_1/screens/clinic/clinic_profile.dart';
import 'package:flutter_application_1/screens/parent/dashboard.dart';
import 'package:flutter_application_1/screens/therapist/ther_profile.dart';

class RegisterParentUser {
  Future<void> registerParentUser(
    BuildContext context,
    String fullName,
    String userName,
    String email,
    String contactNumber,
    String address,
    String password,
    String passwordConfirm,
  ) async {
    // Save the user record to the users collection

    final label = 'parent';

    try {
      final addNewParentUser = await Connection.pb.collection('users').create(
        body: {
          'username': userName,
          'email': email,
          'contactnumber': contactNumber,
          'address': address,
          'password': password,
          'passwordConfirm': passwordConfirm,
          'label': label,
        },
      );

      await Connection.pb
          .collection('users')
          .authWithPassword(userName, password);

      final currentUser = Connection.pb.authStore.model;

      final parentinfo = await Connection.pb.collection('parent').create(
        body: {
          'id': currentUser.id,
          'fullname': fullName,
          'username': userName,
          'email': email,
          'contactnumber': contactNumber,
          'address': address,
          'password': password,
          'passwordConfirm': passwordConfirm,
        },
      );

      //Check if the API response indicates success. This depends on the response structure.
      // Here, I'm just checking if addNewParentUser and parentinfo are not null, but you might need to adjust depending on your backend's response.
      if (addNewParentUser != null && parentinfo != null) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Dashboard()),
        );
        showDialog(
          context: context,
          builder: (BuildContext dialogContext) {
            return AlertDialog(
              title: const Text('Registration Successful'),
              content: const Text('You have successfully registered.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(dialogContext).pop();
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      }
    } catch (e) {
      // Handle the error by showing a message to the user
    }
  }
}

class RegisterTherapistUser {
  Future<void> registerTherapistUser(
    BuildContext context,
    String fullName,
    String userName,
    String email,
    String contactNumber,
    String address,
    String password,
    String passwordConfirm,
  ) async {
    // Save the user record to the users collection

    final label = 'therapist';

    try {
      final addNewTherapistUser =
          await Connection.pb.collection('users').create(
        body: {
          'username': userName,
          'email': email,
          'contactnumber': contactNumber,
          'address': address,
          'password': password,
          'passwordConfirm': passwordConfirm,
          'label': label,
        },
      );

      await Connection.pb
          .collection('users')
          .authWithPassword(userName, password);

      final currentUser = Connection.pb.authStore.model;

      final therapistinfo = await Connection.pb.collection('therapist').create(
        body: {
          'id': currentUser.id,
          'fullname': fullName, // Corrected field name
          'username': userName,
          'email': email,
          'contactnumber': contactNumber,
          'address': address,
          'password': password,
          'passwordConfirm': passwordConfirm,
        },
      );

      //Check if the API response indicates success. This depends on the response structure.
      // Here, I'm just checking if addNewTherapistUser and therapistinfo are not null, but you might need to adjust depending on your backend's response.
      if (addNewTherapistUser != null && therapistinfo != null) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const TherapistProfile()),
        );
        showDialog(
          context: context,
          builder: (BuildContext dialogContext) {
            return AlertDialog(
              title: const Text('Registration Successful'),
              content: const Text('You have successfully registered.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(dialogContext).pop();
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      }
    } catch (e) {
      // Handle the error by showing a message to the user
    }
  }
}

class RegisterClinicUser {
  Future<void> registerClinicUser(
    BuildContext context,
    String clinicName,
    String userName,
    String email,
    String contactNumber,
    String address,
    String password,
    String passwordConfirm,
  ) async {
    // Save the user record to the users collection

    final label = 'clinic';

    try {
      final addNewClinicUser = await Connection.pb.collection('users').create(
        body: {
          'username': userName,
          'email': email,
          'contactnumber': contactNumber,
          'address': address,
          'password': password,
          'passwordConfirm': passwordConfirm,
          'label': label,
        },
      );

      await Connection.pb
          .collection('users')
          .authWithPassword(userName, password);

      final currentUser = Connection.pb.authStore.model;

      final clinicinfo = await Connection.pb.collection('clinic').create(
        body: {
          'id': currentUser.id,
          'clinicname': clinicName,
          'username': userName,
          'email': email,
          'contactnumber': contactNumber,
          'address': address,
          'password': password,
          'passwordConfirm': passwordConfirm,
        },
      );

      //Check if the API response indicates success. This depends on the response structure.
      // Here, I'm just checking if addNewClinicUser and clinicinfo are not null, but you might need to adjust depending on your backend's response.
      if (addNewClinicUser != null && clinicinfo != null) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ClinicProfile()),
        );
        showDialog(
          context: context,
          builder: (BuildContext dialogContext) {
            return AlertDialog(
              title: const Text('Registration Successful'),
              content: const Text('You have successfully registered.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(dialogContext).pop();
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      }
    } catch (e) {
      // Handle the error by showing a message to the user
    }
  }
}
