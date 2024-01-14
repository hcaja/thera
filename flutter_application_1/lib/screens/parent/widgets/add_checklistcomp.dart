import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/httpclinic_controller.dart';
import 'package:flutter_application_1/models/booking.dart';
import 'package:flutter_application_1/models/materials.dart';
import 'package:flutter_application_1/screens/materials/screens/add_materials.dart';
import 'package:flutter_application_1/screens/parent/widgets/patient_itemlv.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddChecklistComp extends StatefulWidget {
  const AddChecklistComp({
    Key? key,
    required this.parent,
  }) : super(key: key);
  final Parent parent;
  @override
  State<AddChecklistComp> createState() => _AddChecklistCompState();
}

class _AddChecklistCompState extends State<AddChecklistComp> {
  TextEditingController chk = TextEditingController();
  ClinicController clinicController = ClinicController();
  List<Checklist> checklists = [];
  List<Checklist> filteredItems = [];

  void _showBottomModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const Text(
                    'Checklist',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  TextField(
                    controller: chk,
                    decoration: const InputDecoration(
                      labelText: 'Enter your checklist',
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () {
                      getUser().then((clinic) {
                        clinicController
                            .saveChecklist(widget.parent.id!, chk.text, clinic!)
                            .then((value) {
                          if (value) {
                            reload();
                            Navigator.of(context).pop();
                          }
                        });
                      });
                    },
                    child: const Text('Save'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void filterSearchResults(String query) {
    List<Checklist> searchResults = [];

    if (query.isNotEmpty) {
      for (var item in checklists) {
        if (item.checklist!.toLowerCase().contains(query.toLowerCase())) {
          searchResults.add(item);
        }
      }
    } else {
      searchResults.addAll(checklists);
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
    reload();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size mq = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showBottomModal(context),
        backgroundColor: const Color(0xFF006A5B),
        foregroundColor: Colors.white,
        shape: const CircleBorder(),
        child: const Icon(Icons.add),
      ),
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
                  pinned: true,
                  expandedHeight: 0.0,
                  toolbarHeight: 0.0,
                  backgroundColor: Colors.transparent,
                ),
                const SliverToBoxAdapter(
                  child: SizedBox(height: 50),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      "${widget.parent.fullname}'s Checklist",
                      style: const TextStyle(
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
                SliverToBoxAdapter(
                  child: Container(
                    margin: const EdgeInsets.only(top: 25),
                    child: Column(children: [
                      for (int i = 0; i < checklists.length; i++)
                        PatientListViewItem(
                          name: checklists[i].checklist!,
                          userName: checklists[i].checked
                              ? 'Status: Done'
                              : 'Status: unfinished',
                        ),
                    ]),
                  ),
                ),
              ],
            ),
          ),

          Positioned(
              bottom: 35, // distance from the bottom
              right: 30, // distance from the right
              child: ClipOval(
                  child: Material(
                      color: const Color(0xFF006A5B), // FAB background color
                      child: InkWell(onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const AddMaterialScreen(),
                          ),
                        );
                      })))),
        ],
      ),
    );
  }

  void reload() {
    getUser().then((id) {
      clinicController.getChecklist(widget.parent.id!, id!).then((value) {
        setState(() {
          checklists = value;
          filteredItems.addAll(checklists);
        });
      });
    });
  }
}
