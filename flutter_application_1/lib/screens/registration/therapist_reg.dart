import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/pick_image.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';

import 'widgets/custom_textfield.dart';

final logger = Logger(); // Instantiate the logger at the top of the file

class TherapistRegister extends StatefulWidget {
  const TherapistRegister({Key? key}) : super(key: key);

  @override
  State<TherapistRegister> createState() => _TherapistRegisterState();
}

class _TherapistRegisterState extends State<TherapistRegister> {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController contactNumberController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  TherapistProID therapistId = TherapistProID();
  XFile? _attachFile;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      // Title or app bar
      appBar: AppBar(
        title: const Text(
          'Register as Therapist',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF006A5B),
      ),
      body: Stack(
        children: [
          // top background
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: ConstrainedBox(
              constraints: BoxConstraints.expand(height: size.height * 0.20),
              child: Image.asset(
                'asset/images/WAVE.png',
                fit: BoxFit.cover,
              ),
            ),
          ),

          // bottom background
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: ConstrainedBox(
              constraints: BoxConstraints.expand(height: size.height * 0.20),
              child: Image.asset(
                'asset/images/WAVE (1).png',
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Text fields for the needed details
          Padding(
            padding: const EdgeInsets.all(45.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CustomTextField(
                    textEditingController: fullNameController,
                    label: 'Full Name',
                    password: false,
                  ),
                  const SizedBox(height: 16.0),
                  CustomTextField(
                    textEditingController: fullNameController,
                    label: 'Username',
                    password: false,
                  ),
                  const SizedBox(height: 16.0),
                  CustomTextField(
                    textEditingController: fullNameController,
                    label: 'Email',
                    password: false,
                  ),
                  const SizedBox(height: 16.0),
                  CustomTextField(
                    textEditingController: fullNameController,
                    label: 'Contact Number',
                    password: false,
                  ),
                  const SizedBox(height: 16.0),
                  CustomTextField(
                    textEditingController: fullNameController,
                    label: 'Address',
                    password: false,
                  ),
                  const SizedBox(height: 16.0),
                  CustomTextField(
                    textEditingController: fullNameController,
                    label: 'Password',
                    password: true,
                  ),
                  const SizedBox(height: 14.0),
                  CustomTextField(
                    textEditingController: fullNameController,
                    label: 'Confirm Password',
                    password: false,
                  ),
                  // For attaching files
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Upload Professional ID:",
                        style: TextStyle(
                          height: 2,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        // provides some spacing between the label and the button
                        height: 0.0,
                      ),
                      _attachFile == null
                          ? ElevatedButton.icon(
                              icon: const Icon(Icons.attach_file),
                              label: const Text('Attach File'),
                              onPressed: () async {
                                _attachFile =
                                    await therapistId.pickImageFromGallery();
                                setState(() {});
                              },
                            )
                          : Chip(
                              label: Text(_attachFile?.name ?? 'Attached'),
                              deleteIcon: const Icon(Icons.delete),
                              onDeleted: () {
                                setState(() {
                                  _attachFile = null;
                                });
                              },
                            ),

                      // Register button
                      const SizedBox(height: 8.0),
                      Center(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF006A5B),
                            padding: const EdgeInsets.symmetric(
                              vertical: 20.0,
                              horizontal: 115.0,
                            ),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                          onPressed: () {},
                          child: const Text(
                            'Register',
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
