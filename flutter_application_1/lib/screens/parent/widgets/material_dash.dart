import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/http_materialscontroller.dart';
import 'package:flutter_application_1/screens/widgets/pdf_viewer.dart';
import 'package:flutter_application_1/screens/widgets/video_player.dart';

class MaterialsTab extends StatefulWidget {
  const MaterialsTab({Key? key}) : super(key: key);

  @override
  State<MaterialsTab> createState() => _MaterialsTabState();
}

class _MaterialsTabState extends State<MaterialsTab> {
  List<LearningMaterial> pdfMaterials = [];
  List<LearningMaterial> videoMaterials = [];
  MaterialsController materialsController = MaterialsController();

  @override
  void initState() {
    super.initState();
    getPdf().then((value) {
      setState(() {
        pdfMaterials = value;
      });
    });
    getVideo().then((value) {
      setState(() {
        videoMaterials = value;
      });
    });
  }

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
            title: Text(materials[index].title),
            subtitle: Text(materials[index].name),
            onTap: () {
              if (materials[index].type != MaterialType.video) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ViewPDF(pdfLink: materials[index].link),
                  ),
                );
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        VideoPlayerScreen(link: materials[index].link),
                  ),
                );
              }
            },
          ),
        );
      },
    );
  }

  Future<List<LearningMaterial>> getVideo() async {
    List<LearningMaterial> temp = [];
    await materialsController.getFiles('mp4').then((value) {
      for (var files in value) {
        temp.add(LearningMaterial(
            type: MaterialType.video,
            link: files.file,
            name: files.file.split('/').last,
            title: files.title!));
      }
    });
    return temp;
  }

  Future<List<LearningMaterial>> getPdf() async {
    List<LearningMaterial> temp = [];
    await materialsController.getFiles('pdf').then((value) {
      for (var files in value) {
        temp.add(LearningMaterial(
            type: MaterialType.pdf,
            link: files.file,
            name: files.file.split('/').last,
            title: files.title!));
      }
    });
    return temp;
  }
}

// Define a class for learning materials
class LearningMaterial {
  final MaterialType type;
  final String name;
  final String title;
  final String link;
  LearningMaterial({
    required this.type,
    required this.name,
    required this.title,
    required this.link,
  });
}

// Enum to represent the type of learning material
enum MaterialType {
  pdf,
  video,
}
