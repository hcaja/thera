import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/cloudinary_upload.dart';
import 'package:flutter_application_1/models/materials.dart';
import 'package:flutter_application_1/screens/widgets/material_form.dart';
import 'package:image_picker/image_picker.dart';

class AddMaterials extends StatefulWidget {
  const AddMaterials({Key? key}) : super(key: key);

  @override
  State<AddMaterials> createState() => _AddMaterialsState();
}

class _AddMaterialsState extends State<AddMaterials> {
  XFile? header;
  List<File>? files;
  final ImagePicker picker = ImagePicker();
  UploadController uploadController = UploadController();

  //we can upload image from camera or from gallery based on parameter
  Future getImage(ImageSource media) async {
    await picker.pickImage(source: media).then((value) {
      setState(() {
        header = value;
      });
    });
  }

  Future getFiles() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowMultiple: true,
      allowedExtensions: ['jpg', 'pdf', 'doc'],
    );
    if (result != null) {
      setState(() {
        List<File> resFiles = result.paths.map((path) => File(path!)).toList();
        files = resFiles;
      });
    } else {
      // User canceled the picker
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size mq = MediaQuery.of(context).size;
    final TextEditingController titleController = TextEditingController();
    ClinicMaterial? clinicMaterial;

    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            child: SizedBox(
              height: 100,
              child: ConstrainedBox(
                constraints: BoxConstraints.expand(height: mq.height * 0.30),
                child: Image.asset(
                  'asset/images/Ellipse 1.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: ConstrainedBox(
              constraints: BoxConstraints.expand(height: mq.height * 0.3),
              child: Image.asset(
                'asset/images/Ellipse 2.png',
                fit: BoxFit.cover,
              ),
            ),
          ),

          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
              child: Column(
                children: [
                  Container(
                    height: mq.height * 0.2,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Colors.white, // White color
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x3F000000),
                          blurRadius: 4,
                          offset: Offset(0, 4),
                          spreadRadius: 0,
                        ),
                      ],
                    ),
                    child: header != null
                        ? GestureDetector(
                            onTap: () {
                              setState(() {
                                header = null;
                              });
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.file(
                                File(header!.path),
                                fit: BoxFit.cover,
                              ),
                            ),
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  getImage(ImageSource.gallery);
                                },
                                child: Icon(
                                  Icons.cloud_upload_outlined,
                                  size: 100,
                                  color:
                                      const Color(0xFF006A5B).withOpacity(0.5),
                                ),
                              ),
                              const Text('click to upload material header')
                            ],
                          ),
                  ),
                  SizedBox(
                    height: mq.height * 0.02,
                  ),
                  const MaterialForm(title: 'Title', data: 'data', note: false),
                  SizedBox(
                    height: mq.height * 0.02,
                  ),
                  const MaterialForm(
                      title: 'Description', data: 'data', note: true),
                  SizedBox(
                    height: mq.height * 0.02,
                  ),
                  const SizedBox(
                    width: double.infinity,
                    child: Text('Upload File'),
                  ),
                  Container(
                    height: mq.height * 0.2,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Colors.white, // White color
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x3F000000),
                          blurRadius: 4,
                          offset: Offset(0, 4),
                          spreadRadius: 0,
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            getFiles();
                          },
                          child: Icon(
                            Icons.cloud_upload_outlined,
                            size: 100,
                            color: const Color(0xFF006A5B).withOpacity(0.5),
                          ),
                        ),
                        const Text('click to upload image, video, file...')
                      ],
                    ),
                  ),
                  files != null
                      ? SizedBox(
                          child: Column(
                            children: [
                              for (int i = 0; i < files!.length; i++)
                                Container(
                                  height: mq.height * 0.04,
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  width: double.infinity,
                                  decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    color: Colors.white, // White color
                                    boxShadow: [
                                      BoxShadow(
                                        color: Color(0x3F000000),
                                        blurRadius: 4,
                                        offset: Offset(0, 4),
                                        spreadRadius: 0,
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        children: [
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          const Icon(Icons.attachment),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Text(files![i].path.split('/').last),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                            ],
                          ),
                        )
                      : const Text('No files selected')
                ],
              ),
            ),
          ),
          // Floating Action Button (FAB)
          Positioned(
            bottom: 35, // distance from the bottom
            right: 30, // distance from the right
            child: ClipOval(
              child: Material(
                color: const Color(0xFF006A5B), // FAB background color
                child: InkWell(
                  onTap: () {
                    save();
                  },
                  child: const SizedBox(
                    width: 60, // size of the circular FAB
                    height: 60, // size of the circular FAB
                    child: Center(
                        child: Icon(
                      Icons.save,
                      color: Colors.white,
                    )),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void save() {
    uploadHeader();
  }

  Future<String> uploadHeader() async {
    String url = '';
    uploadController.uploadFile(header!).then((value) {
      url = value;
    });
    return url;
  }
}
