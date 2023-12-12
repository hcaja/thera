import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/http_materialscontroller.dart';
import 'package:flutter_application_1/models/materials.dart';
import 'package:flutter_application_1/screens/widgets/material_form.dart';

class ViewMaterials extends StatefulWidget {
  const ViewMaterials({
    Key? key,
    required this.material,
  }) : super(key: key);
  final ClinicMaterial material;
  @override
  State<ViewMaterials> createState() => _ViewMaterialsState();
}

class _ViewMaterialsState extends State<ViewMaterials> {
  MaterialsController materialsController = MaterialsController();
  ClinicMaterial? clinicMaterial;
  bool isLoading = true;

  @override
  void initState() {
    clinicMaterial = widget.material;
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
                  child: SizedBox(
                    height: mq.height,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 15),
                      child: Column(
                        children: [
                          Container(
                              height: mq.height * 0.2,
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
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(clinicMaterial!.thumbnail,
                                    fit: BoxFit.cover),
                              )),
                          SizedBox(
                            height: mq.height * 0.02,
                          ),
                          MaterialForm(
                            title: 'Title',
                            data: clinicMaterial!.title,
                            note: false,
                            view: true,
                          ),
                          SizedBox(
                            height: mq.height * 0.02,
                          ),
                          MaterialForm(
                            title: 'Description',
                            data: clinicMaterial!.desc,
                            note: true,
                            view: true,
                          ),
                          SizedBox(
                            height: mq.height * 0.02,
                          ),
                          const SizedBox(
                            width: double.infinity,
                            child: Text('Files'),
                          ),
                          SizedBox(
                            child: Column(
                              children: [
                                for (int i = 0;
                                    i < clinicMaterial!.files!.length;
                                    i++)
                                  Container(
                                    height: mq.height * 0.04,
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 10),
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
                                            Text(clinicMaterial!.files![i].file
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
                        ],
                      ),
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
                    Text('Loading...'),
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
                  onTap: () {},
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
}
