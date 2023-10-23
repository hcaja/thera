import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/pick_image.dart';
import 'package:flutter_application_1/controller/register_controller.dart';
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
  parentGovID parentId = parentGovID();
  RegisterParentUser controller = RegisterParentUser();
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
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(
                          color: const Color.fromARGB(255, 255, 255, 255),
                        ),
                        color: Colors.white, // White color
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x3F000000),
                            blurRadius: 4,
                            offset: Offset(0, 4),
                            spreadRadius: 0,
                          ),
                        ],
                      ),
                      child: TextField(
                        controller: fullNameController,
                        decoration: const InputDecoration(
                          labelText: 'Full Name',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 14.0),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(
                          color: const Color.fromARGB(255, 245, 250, 255),
                        ),
                        color: Colors.white, // White color
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x3F000000),
                            blurRadius: 4,
                            offset: Offset(0, 4),
                            spreadRadius: 0,
                          ),
                        ],
                      ),
                      child: TextField(
                        controller: userNameController,
                        decoration: const InputDecoration(
                          labelText: 'User Name',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 14.0),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(
                          color: const Color.fromARGB(255, 255, 255, 255),
                        ),
                        color: Colors.white, // White color
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x3F000000),
                            blurRadius: 4,
                            offset: Offset(0, 4),
                            spreadRadius: 0,
                          ),
                        ],
                      ),
                      child: TextField(
                        controller: emailController,
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          border: InputBorder.none,
                        ),
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ),
                    const SizedBox(height: 14.0),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(
                          color: const Color.fromARGB(255, 255, 255, 255),
                        ),
                        color: Colors.white, // White color
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x3F000000),
                            blurRadius: 4,
                            offset: Offset(0, 4),
                            spreadRadius: 0,
                          ),
                        ],
                      ),
                      child: TextField(
                        controller: contactNumberController,
                        decoration: const InputDecoration(
                          labelText: 'Contact Number',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 14.0),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(
                          color: const Color.fromARGB(255, 245, 250, 255),
                        ),
                        color: Colors.white, // White color
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x3F000000),
                            blurRadius: 4,
                            offset: Offset(0, 4),
                            spreadRadius: 0,
                          ),
                        ],
                      ),
                      child: TextField(
                        controller: addressController,
                        decoration: const InputDecoration(
                          labelText: 'Address',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 14.0),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(
                          color: const Color.fromARGB(255, 255, 255, 255),
                        ),
                        color: Colors.white, // White color
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x3F000000),
                            blurRadius: 4,
                            offset: Offset(0, 4),
                            spreadRadius: 0,
                          ),
                        ],
                      ),
                      child: TextField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          labelText: 'Password',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 14.0),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(
                          color: const Color.fromARGB(255, 255, 255, 255),
                        ),
                        color: Colors.white, // White color
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x3F000000),
                            blurRadius: 4,
                            offset: Offset(0, 4),
                            spreadRadius: 0,
                          ),
                        ],
                      ),
                      child: TextField(
                        controller: confirmPasswordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          labelText: 'Confirm Password',
                          border: InputBorder.none,
                        ),
                      ),
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
                              controller.registerParentUser(
                                context,
                                fullNameController.text,
                                userNameController.text,
                                emailController.text,
                                contactNumberController.text,
                                addressController.text,
                                passwordController.text,
                                confirmPasswordController.text,
                              );
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
