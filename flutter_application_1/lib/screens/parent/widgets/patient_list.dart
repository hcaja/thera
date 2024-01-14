import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/httpclinic_controller.dart';
import 'package:flutter_application_1/models/booking.dart';
import 'package:flutter_application_1/screens/parent/screens/add_checklist.dart';
import 'package:flutter_application_1/screens/parent/widgets/patient_itemlv.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PatientListsView extends StatefulWidget {
  const PatientListsView({Key? key, required this.isParent}) : super(key: key);
  final bool isParent;
  @override
  State<PatientListsView> createState() => _PatientListsViewState();
}

class _PatientListsViewState extends State<PatientListsView> {
  ClinicController clinicController = ClinicController();
  List<Parent> parents = [];
  List<Parent> filteredItems = [];
  void filterSearchResults(String query) {
    List<Parent> searchResults = [];

    if (query.isNotEmpty) {
      for (var item in parents) {
        if (item.fullname!.toLowerCase().contains(query.toLowerCase())) {
          searchResults.add(item);
        }
      }
    } else {
      searchResults.addAll(parents);
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
                const SliverToBoxAdapter(
                  child: SizedBox(height: 50),
                ),
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
                const SliverToBoxAdapter(
                  child: SizedBox(height: 1),
                ),
                const SliverToBoxAdapter(
                  child: SizedBox(height: 10),
                ),
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
                          onPressed: () {},
                        ),
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    margin: const EdgeInsets.only(top: 25),
                    child: Column(children: [
                      for (int i = 0; i < parents.length; i++)
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => AddCheckList(
                                    isParent: true,
                                    parent: parents[i],
                                  ),
                                ));
                          },
                          child: PatientListViewItem(
                            name: parents[i].fullname!,
                            userName: '@${parents[i].username!}',
                          ),
                        ),
                    ]),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void reload() {
    getUser().then((id) {
      clinicController.getParentsByClinic(id!).then((value) {
        setState(() {
          parents = value;
          filteredItems.addAll(parents);
        });
      });
    });
  }
}
