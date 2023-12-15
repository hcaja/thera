import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/http_materialscontroller.dart';
import 'package:flutter_application_1/models/materials.dart';
import 'package:flutter_application_1/screens/materials/screens/add_materials.dart';
import 'package:flutter_application_1/screens/materials/screens/view_materials.dart';
//import 'package:flutter_application_1/screens/materials/widgets/materials_view.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MaterialsMenu extends StatefulWidget {
  const MaterialsMenu({Key? key, required this.isParent}) : super(key: key);
  final bool isParent;
  @override
  State<MaterialsMenu> createState() => _MaterialsMenuState();
}

class _MaterialsMenuState extends State<MaterialsMenu> {
  MaterialsController materialsController = MaterialsController();
  List<ClinicMaterial> materials = [];
  List<ClinicMaterial> filteredItems = [];
  void filterSearchResults(String query) {
    List<ClinicMaterial> searchResults = [];

    if (query.isNotEmpty) {
      for (var item in materials) {
        if (item.title.toLowerCase().contains(query.toLowerCase())) {
          searchResults.add(item);
        }
      }
    } else {
      searchResults.addAll(materials);
    }

    setState(() {
      filteredItems.clear();
      filteredItems.addAll(searchResults);
    });
  }

  Future<int?> getUser() async {
    int? clinicId;
    await SharedPreferences.getInstance().then((value) {
      String? token = value.getString('clinicToken');
      Map<String, dynamic> payload = JwtDecoder.decode(token!);
      clinicId = payload['ID'];
    });
    return clinicId;
  }

  @override
  void initState() {
    if (!widget.isParent) {
      getUser().then((id) {
        materialsController.getMaterials(id!).then((value) {
          setState(() {
            materials = value;
            filteredItems.addAll(materials);
          });
        });
      });
    } else {
      getUser().then((id) {
        materialsController.getMaterials(null).then((value) {
          setState(() { 
            materials = value;
            filteredItems.addAll(materials);
          });
        });
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size mq = MediaQuery.of(context).size;

    return Scaffold(
      // body
      body: Stack(
        children: [
          // top background
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

          // bottom background
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

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomScrollView(
              slivers: <Widget>[
                const SliverAppBar(
                  automaticallyImplyLeading: false,
                  pinned:
                      true, // Set to true if you want it pinned, false for floating
                  expandedHeight: 0.0,
                  toolbarHeight: 0.0, // Set the toolbar height
                  backgroundColor: Colors.transparent,
                ),

                // top height of the therapy clinic finder and/or spacing of therapy clinic finder and custom tab bar
                const SliverToBoxAdapter(
                  child: SizedBox(height: 50),
                ),

                // Therapy clinic finder
                const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'Therapy Clinic Materials',
                      style: TextStyle(
                        color: Color(0xFF67AFA5),
                        fontSize: 20,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w900,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),

                // top height of the map
                const SliverToBoxAdapter(
                  child: SizedBox(height: 1),
                ),

                // top height of the searchbar and/or spacing of search bar and map
                const SliverToBoxAdapter(
                  child: SizedBox(height: 10),
                ),

                // code for the search bar
                SliverToBoxAdapter(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16.0),
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: TextField(
                      onChanged: filterSearchResults,
                      decoration: InputDecoration(
                        hintText: 'Search...',
                        border: InputBorder.none,
                        suffixIcon: IconButton(
                          icon: const Icon(
                            Icons.search,
                            color: Color(0xFF67AFA5),
                          ),
                          onPressed: () {
                            // Handle search here
                          },
                        ),
                      ),
                    ),
                  ),
                ),

                // top height of the grid and/or spacing of grid and search bar
                const SliverToBoxAdapter(
                  child: SizedBox(height: 15),
                ),

                SliverGrid(
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200.0,
                    mainAxisSpacing: 12.0,
                    crossAxisSpacing: 12.0,
                    childAspectRatio: 0.55, //size of the containers
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ViewMaterialsScreen(
                                  clinicMaterial: filteredItems[index]),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10)),
                                  child: SizedBox(
                                    height: mq.height * 0.13,
                                    width: mq.width * 0.5,
                                    child: Image.network(
                                      filteredItems[index].thumbnail,
                                      height: 150,
                                      fit: BoxFit.fill,
                                      // fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10.0),
                                Padding(
                                  padding: EdgeInsets.only(
                                    top: mq.height * 0.001,
                                    left: 10,
                                    right: 10,
                                  ),
                                  child: Text(filteredItems[index].title,
                                      // textAlign: TextAlign.left,
                                      style: const TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF006A5B))),
                                ),
                                const SizedBox(height: 5.0),
                                Text(
                                  filteredItems[index].desc,
                                  maxLines: (mq.height * 0.007).round(),
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(fontSize: 11.0),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    childCount: filteredItems.length,
                  ),
                ),
              ],
            ),
          ),
          // Floating Action Button (FAB)
          widget.isParent
              ? Positioned(
                  bottom: 35, // distance from the bottom
                  right: 30, // distance from the right
                  child: ClipOval(
                    child: Material(
                      color: const Color(0xFF006A5B), // FAB background color
                      child: InkWell(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const AddMaterialScreen(),
                            ),
                          );
                        },
                        child: const SizedBox(
                          width: 60, // size of the circular FAB
                          height: 60, // size of the circular FAB
                          child: Center(
                              child: Icon(
                            Icons.add,
                            color: Colors.white,
                          )),
                        ),
                      ),
                    ),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
