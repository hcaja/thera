import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/httpregister_controller.dart';
import 'package:flutter_application_1/controller/pick_image.dart';
import 'package:flutter_application_1/screens/widgets/custom_textfield.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';

final logger = Logger(); // Instantiate the logger at the top of the file

class ParentRegister extends StatefulWidget {
  const ParentRegister({Key? key}) : super(key: key);

  @override
  State<ParentRegister> createState() => _ParentRegisterState();
}

class _ParentRegisterState extends State<ParentRegister> {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController contactNumberController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  ClinicRegisterApi controller = ClinicRegisterApi();
  ParentGovID parentId = ParentGovID();
  XFile? _attachFile;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      // Title or app bar
      appBar: AppBar(
        title: const Text(
          'Register as Parent',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF006A5B),
      ),

      body: GestureDetector(
        // GestureDetector to dismiss the keyboard on a tap
        onTap: () => FocusScope.of(context).unfocus(),
        child: Stack(
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
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    CustomTextField(
                      textEditingController: fullNameController,
                      label: 'Full Name',
                      password: false,
                    ),
                    const SizedBox(height: 14.0),
                    CustomTextField(
                      textEditingController: userNameController,
                      label: 'User Name',
                      password: false,
                    ),
                    const SizedBox(height: 14.0),
                    CustomTextField(
                      textEditingController: emailController,
                      label: 'Email',
                      password: false,
                    ),
                    const SizedBox(height: 14.0),
                    CustomTextField(
                      textEditingController: contactNumberController,
                      label: 'Contact Number',
                      password: false,
                    ),
                    const SizedBox(height: 14.0),
                    CustomTextField(
                      textEditingController: addressController,
                      label: 'Address',
                      password: false,
                    ),
                    const SizedBox(height: 14.0),
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
                    // For attaching files
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Upload any Valid Government ID:",
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
                                      await parentId.pickImageFromGallery();
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
                            onPressed: () {
                              controller
                                  .parentRegister(
                                      fullNameController.text,
                                      userNameController.text,
                                      emailController.text,
                                      contactNumberController.text,
                                      addressController.text,
                                      passwordController.text)
                                  .then((value) {
                                if (value) {
                                  Navigator.of(context).pop();
                                }
                              });
                            },
                            child: const Text(
                              'Register',
                            ),
                          ),
                        ),
                        // const SizedBox(height: 16.0),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Or",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),

                        // Register with Google or Facebook
                        const SizedBox(height: 1.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                // google auth
                              },
                              child: Image.asset(
                                'asset/icons/social.png', // google icon
                                width: 35,
                                height: 35,
                              ),
                            ),
                            const SizedBox(width: 20),
                            GestureDetector(
                              onTap: () {
                                // facebook auth
                              },
                              child: Image.asset(
                                'asset/icons/facebook (1).png', // facebook icon
                                width: 35,
                                height: 35,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
