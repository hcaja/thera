import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/httptherapist_controller.dart';
import 'package:flutter_application_1/screens/map/map_page.dart';

import '../../../models/clinic_profiles.dart';
// import 'package:flutter_application_1/screens/parent/dashboard_tabbar.dart';

class TherapistsDashboard extends StatefulWidget {
  const TherapistsDashboard({Key? key}) : super(key: key);

  @override
  State<TherapistsDashboard> createState() => _TherapistsDashboardState();
}

class _TherapistsDashboardState extends State<TherapistsDashboard> {
  TherapistController therapistController = TherapistController();
  List<Employee> employee = [];
  @override
  void initState() {
    therapistController.getFreelanceTherapist().then((value) {
      setState(() {
        employee = value;
      });
    });
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
                      'Therapist Finder',
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

                // code for map
                const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: SizedBox(
                      height: 220,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        child: MapPage(),
                      ),
                    ),
                  ),
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
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (_) => HomeClinic(
                          //       clinics: clinics[index],
                          //       isEditable: false,
                          //     ),
                          //   ),
                          // );
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
                                      employee[index].profilePicture,
                                      height: 150,
                                      fit: BoxFit.cover,
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
                                  child: Text(employee[index].name,
                                      // textAlign: TextAlign.left,
                                      style: const TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF006A5B))),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: mq.height * 0.001, left: 5),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: List.generate(5, (starIndex) {
                                      return Icon(
                                        Icons.star,
                                        color: starIndex < 5
                                            ? Colors.yellow
                                            : Colors.grey,
                                        // Adjust star color based on the rating
                                        size: 15,
                                      );
                                    }),
                                  ),
                                ),
                                const SizedBox(height: 5.0),
                                Text(
                                  employee[index].about!,
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
                    childCount: employee.length,
                  ),
                ),
              ],
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
                  onTap: () {},
                  child: SizedBox(
                    width: 60, // size of the circular FAB
                    height: 60, // size of the circular FAB
                    child: Center(
                      child: Image.asset(
                        'asset/icons/add_1.png',
                        height: 30, // Make the image fit inside the box
                        color: Colors.white, // icon color
                      ),
                    ),
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
