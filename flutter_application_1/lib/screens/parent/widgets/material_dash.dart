import 'package:flutter/material.dart';

class MaterialsTab extends StatefulWidget {
  const MaterialsTab({Key? key}) : super(key: key);

  @override
  State<MaterialsTab> createState() => _MaterialsTabState();
}

class _MaterialsTabState extends State<MaterialsTab> {
  final List<LearningMaterial> pdfMaterials = [
    LearningMaterial(type: MaterialType.pdf, name: 'PDF 1'),
    LearningMaterial(type: MaterialType.pdf, name: 'PDF 2'),
    // Add more PDF materials as needed
  ];

  final List<LearningMaterial> videoMaterials = [
    LearningMaterial(type: MaterialType.video, name: 'Video 1'),
    LearningMaterial(type: MaterialType.video, name: 'Video 2'),
    // Add more video materials as needed
  ];

  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: Stack(
          children: [
            // top background
            Positioned(
              child: SizedBox(
                height: 175,
                child: ConstrainedBox(
                  constraints:
                      BoxConstraints.expand(height: mq.size.height * 0.30),
                  child: Image.asset(
                    'asset/images/Ellipse 1.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),

            // bottom background
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: ConstrainedBox(
                constraints:
                    BoxConstraints.expand(height: mq.size.height * 0.3),
                child: Image.asset(
                  'asset/images/Ellipse 2.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),

            // TabBarView content
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  color: const Color(0xFF006A5B),
                  child: const TabBar(
                    indicator: BoxDecoration(
                      color: Color(0xFF006A5B),
                    ),
                    labelColor: Colors.white,
                    tabs: [
                      Tab(text: 'PDF Materials'),
                      Tab(text: 'Video Materials'),
                    ],
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      _buildCategoryList(pdfMaterials),
                      _buildCategoryList(videoMaterials),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () {
        //     // Handle the FAB click event, e.g., open a file picker
        //     _showMaterialUploadDialog(context);
        //   },
        //   tooltip: 'Upload Material',
        //   child: const Icon(Icons.upload),
        // ),
      ),
    );
  }

  Widget _buildCategoryList(List<LearningMaterial> materials) {
    return ListView.builder(
      itemCount: materials.length,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.all(8),
          child: ListTile(
            title: Text(materials[index].name),
            subtitle: Text(materials[index].type == MaterialType.pdf
                ? 'PDF File'
                : 'Video File'),
            onTap: () {
              // Handle the tap on the material
              // You can open PDF or video here
            },
          ),
        );
      },
    );
  }

  // void _showMaterialUploadDialog(BuildContext context) {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: const Text('Choose Material Type'),
  //         content: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             ElevatedButton(
  //               onPressed: () {
  //                 // Handle PDF upload
  //                 Navigator.pop(context);
  //               },
  //               child: const Text('Upload PDF'),
  //             ),
  //             const SizedBox(height: 10),
  //             ElevatedButton(
  //               onPressed: () {
  //                 // Handle video upload
  //                 Navigator.pop(context);
  //               },
  //               child: const Text('Upload Video'),
  //             ),
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }
}

// Define a class for learning materials
class LearningMaterial {
  final MaterialType type;
  final String name;

  LearningMaterial({required this.type, required this.name});
}

// Enum to represent the type of learning material
enum MaterialType {
  pdf,
  video,
}
