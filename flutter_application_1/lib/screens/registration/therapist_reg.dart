import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/cloudinary_upload.dart';
import 'package:flutter_application_1/controller/httpregister_controller.dart';
import 'package:flutter_application_1/controller/pick_image.dart';
import 'package:flutter_application_1/screens/registration/widgets/custom_dropdown.dart';
import 'package:flutter_application_1/screens/widgets/loading_button.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';

import '../widgets/custom_textfield.dart';

final logger = Logger(); // Instantiate the logger at the top of the file

class TherapistRegister extends StatefulWidget {
  const TherapistRegister({
    Key? key,
    required this.type,
    this.refresh,
  }) : super(key: key);
  final String type;
  final Function? refresh;
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
  int role = 1;

  ClinicRegisterApi controller = ClinicRegisterApi();
  UploadController uploadController = UploadController();
  XFile? _attachFile;
  XFile? _clinicPic;
  String? picLink;
  String? atFilelink;
  ClinicGovFiles therapistfiles = ClinicGovFiles();
  ClinicRegisterApi clinicRegisterApi = ClinicRegisterApi();
  bool isUploadingPic = false;
  bool isUploadingFile = false;
  bool isLoading = false;

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
                    textEditingController: userNameController,
                    label: 'Username',
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
                    password: false,
                  ),

                  const SizedBox(height: 14.0),
                  if (widget.type != 'ind')
                    CustomDropDownReg(
                      setRole: (value) {
                        role = value;
                      },
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
                                    await therapistfiles.pickImageFromGallery();
                                if (_attachFile != null) {
                                  setState(() {
                                    isUploadingFile = true;
                                  });
                                  await uploadController
                                      .uploadHeader(_attachFile!)
                                      .then((value) {
                                    atFilelink = value;
                                    setState(() {
                                      isUploadingFile = false;
                                    });
                                  });
                                }
                                setState(() {});
                              },
                            )
                          : Chip(
                              label: Text(_attachFile?.name ?? 'Attached'),
                              deleteIcon: !isUploadingFile
                                  ? const Icon(Icons.delete)
                                  : const CircularProgressIndicator.adaptive(),
                              onDeleted: () {
                                setState(() {
                                  _attachFile = null;
                                });
                              },
                            ),
                      const Text(
                        "Upload Profile Picture",
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
                      _clinicPic == null
                          ? ElevatedButton.icon(
                              icon: const Icon(Icons.attach_file),
                              label: const Text('Attach File'),
                              onPressed: () async {
                                _clinicPic =
                                    await therapistfiles.pickImageFromGallery();
                                if (_clinicPic != null) {
                                  if (_clinicPic != null) {
                                    setState(() {
                                      isUploadingPic = true;
                                    });
                                    await uploadController
                                        .uploadHeader(_clinicPic!)
                                        .then((value) {
                                      picLink = value;
                                      setState(() {
                                        isUploadingPic = false;
                                      });
                                    });
                                  }
                                }
                                setState(() {});
                              },
                            )
                          : Chip(
                              label: Text(_clinicPic?.name ?? 'Attached'),
                              deleteIcon: !isUploadingPic
                                  ? const Icon(Icons.delete)
                                  : const CircularProgressIndicator.adaptive(),
                              onDeleted: () {
                                setState(() {
                                  _attachFile = null;
                                });
                              },
                            ),

                      // Register button
                      const SizedBox(height: 8.0),

                      // Register button
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
                                  if (atFilelink != null && picLink != null) {
                                    setState(() {
                                      isLoading = true;
                                    });
                                    if (widget.type == 'ind') {
                                      clinicRegisterApi
                                          .soloTherapistRegister(
                                              fullNameController.text,
                                              emailController.text,
                                              passwordController.text,
                                              addressController.text,
                                              contactNumberController.text,
                                              '1',
                                              'M',
                                              userNameController.text,
                                              picLink!,
                                              atFilelink!)
                                          .then((value) {
                                        if (value) {
                                          setState(() {
                                            isLoading = false;
                                          });
                                          Navigator.of(context).pop();
                                          widget.refresh!();
                                        } else {
                                          setState(() {
                                            isLoading = false;
                                          });
                                        }
                                      });
                                    } else {
                                      clinicRegisterApi
                                          .clinicTherapistRegister(
                                              role.toString(),
                                              fullNameController.text,
                                              emailController.text,
                                              passwordController.text,
                                              addressController.text,
                                              contactNumberController.text,
                                              '1',
                                              'M',
                                              picLink!,
                                              userNameController.text,
                                              atFilelink!)
                                          .then((value) {
                                        if (value) {
                                          setState(() {
                                            isLoading = true;
                                          });
                                          Navigator.of(context).pop();
                                          widget.refresh!();
                                        } else {
                                          setState(() {
                                            isLoading = false;
                                          });
                                        }
                                      });
                                    }
                                  } else {
                                    Fluttertoast.showToast(
                                        msg: 'Please attatch files',
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.CENTER,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.red,
                                        textColor: Colors.white,
                                        fontSize: 16.0);
                                    setState(() {
                                      isLoading = false;
                                    });
                                  }
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
