import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/cloudinary_upload.dart';
import 'package:flutter_application_1/controller/http_materialscontroller.dart';
import 'package:flutter_application_1/models/materials.dart';
import 'package:flutter_application_1/screens/widgets/material_form.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddMaterials extends StatefulWidget {
  const AddMaterials({Key? key}) : super(key: key);

  @override
  State<AddMaterials> createState() => _AddMaterialsState();
}

class _AddMaterialsState extends State<AddMaterials> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  MaterialsController materialsController = MaterialsController();
  XFile? header;
  List<File>? files;
  int? clinic;
  final ImagePicker picker = ImagePicker();
  UploadController uploadController = UploadController();
  bool isLoading = true;
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
      allowedExtensions: ['jpg', 'pdf', 'doc', 'mp4'],
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
  void initState() {
    getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size mq = MediaQuery.of(context).size;

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

          isLoading
              ? SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 15),
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
                                        color: const Color(0xFF006A5B)
                                            .withOpacity(0.5),
                                      ),
                                    ),
                                    const Text(
                                        'click to upload material header')
                                  ],
                                ),
                        ),
                        SizedBox(
                          height: mq.height * 0.02,
                        ),
                        MaterialForm(
                          title: 'Title',
                          data: 'data',
                          note: false,
                          textEditingController: titleController,
                          view: false,
                        ),
                        SizedBox(
                          height: mq.height * 0.02,
                        ),
                        MaterialForm(
                          title: 'Description',
                          data: 'data',
                          note: true,
                          textEditingController: descController,
                          view: false,
                        ),
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
                                  color:
                                      const Color(0xFF006A5B).withOpacity(0.5),
                                ),
                              ),
                              const Text(
                                  'click to upload image, video, file...')
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
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 10),
                                        width: double.infinity,
                                        decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
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
                                                Text(files![i]
                                                    .path
                                                    .split('/')
                                                    .last),
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
                )
              : const Center(
                  child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(
                      height: 10,
                    ),
                    Text('Uploading...'),
                  ],
                )),
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

  void save() async {
    setState(() {
      isLoading = false;
    });

    await uploadHeader().then((value) {
      ClinicMaterial clinicMaterial = ClinicMaterial(
        title: titleController.text,
        desc: descController.text,
        clinic: clinic,
        thumbnail: value,
      );
      materialsController.saveMaterial(clinicMaterial).then((material) async {
        await uploadAttatched(material!.id!).then((materialFile) {
          materialsController.saveAttachment(materialFile!).then((success) {
            if (success) {
              setState(() {
                isLoading = true;
                Navigator.pop(context);
              });
            }
          });
        });
      });
    });
  }

  Future<String> uploadHeader() async {
    String url = '';
    await uploadController.uploadHeader(header!).then((value) {
      url = value;
    });
    return url;
  }

  Future<List<MaterialFile>?> uploadAttatched(int materialId) async {
    List<MaterialFile> uploadResults = [];
    for (var element in files!) {
      await uploadController.uploadFile(element).then((value) {
        uploadResults.add(MaterialFile(
            material: materialId,
            type: element.path.split('/').last.split('.').last,
            file: value));
      });
    }
    return uploadResults;
  }

  void getUser() async {
    await SharedPreferences.getInstance().then((value) {
      String? token = value.getString('clinicToken');
      Map<String, dynamic> payload = JwtDecoder.decode(token!);
      clinic = payload['ID'];
    });
  }
}
