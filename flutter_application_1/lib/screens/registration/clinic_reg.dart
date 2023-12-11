import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/httpregister_controller.dart';
import 'package:flutter_application_1/controller/pick_image.dart';
import 'package:flutter_application_1/screens/auth/login_as.dart';
import 'package:flutter_application_1/screens/widgets/custom_textfield.dart';
import 'package:flutter_application_1/screens/widgets/loading_button.dart';
import 'package:image_picker/image_picker.dart';

class ClinicRegister extends StatefulWidget {
  const ClinicRegister({Key? key}) : super(key: key);

  @override
  State<ClinicRegister> createState() => _ClinicRegisterState();
}

class _ClinicRegisterState extends State<ClinicRegister> {
  final TextEditingController clinicNameController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController contactNumberController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  ClinicGovFiles therapistId = ClinicGovFiles();
  ClinicRegisterApi controller = ClinicRegisterApi();
  XFile? _attachFile;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      // Title or app bar
      appBar: AppBar(
        title: const Text(
          'Clinic Registrarion',
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
                    textEditingController: clinicNameController,
                    label: 'Clinic Name',
                    password: false,
                  ),
                  const SizedBox(height: 16.0),
                  CustomTextField(
                    textEditingController: userNameController,
                    label: 'User name',
                    password: false,
                  ),
                  const SizedBox(height: 16.0),
                  CustomTextField(
                    textEditingController: emailController,
                    label: 'Email',
                    password: false,
                  ),
                  const SizedBox(height: 16.0),
                  CustomTextField(
                    textEditingController: contactNumberController,
                    label: 'Contact Number',
                    password: false,
                  ),
                  const SizedBox(height: 16.0),
                  CustomTextField(
                    textEditingController: addressController,
                    label: 'Address',
                    password: false,
                  ),
                  const SizedBox(height: 16.0),
                  CustomTextField(
                    textEditingController: passwordController,
                    label: 'Password',
                    password: true,
                  ),
                  const SizedBox(height: 14.0),
                  CustomTextField(
                    textEditingController: confirmPasswordController,
                    label: 'Confirm Password',
                    password: true,
                  ),
                  const SizedBox(height: 16.0),
                  // For attaching files
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Upload Government files: Registration, Permit, etc.",
                        style: TextStyle(
                          height: 1.5,
                          fontSize: 13.0,
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
                      const SizedBox(height: 8.0),
                      Center(
                        child: !isLoading
                            ? ElevatedButton(
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
                                onPressed: () {
                                  setState(() {
                                    isLoading = true;
                                  });
                                  controller
                                      .clinicRegister(
                                    clinicNameController.text,
                                    userNameController.text,
                                    emailController.text,
                                    contactNumberController.text,
                                    addressController.text,
                                    passwordController.text,
                                    confirmPasswordController.text,
                                  )
                                      .then((value) {
                                    if (value) {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) => const LoginAs(),
                                        ),
                                      );
                                    }
                                  });
                                  setState(() {
                                    isLoading = false;
                                  });
                                },
                                child: const Text(
                                  'Register',
                                ))
                            : const CircularLoadingButton(),
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
