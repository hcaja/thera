import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/materials.dart';
//import 'package:flutter_application_1/screens/materials/widgets/materials_add.dart';
import 'package:flutter_application_1/screens/materials/widgets/materials_tab.dart';
import 'package:flutter_application_1/screens/materials/widgets/materials_view.dart';
import 'package:flutter_application_1/screens/widgets/app_drawer_therapist.dart';

class ViewMaterialsScreen extends StatefulWidget {
  const ViewMaterialsScreen({super.key, required this.clinicMaterial});

  final ClinicMaterial clinicMaterial;

  @override
  ViewMaterialsScreenState createState() => ViewMaterialsScreenState();
}

class ViewMaterialsScreenState extends State<ViewMaterialsScreen> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  // Function to handle tab changes
  void _onTabSelected(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size mq = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Materials',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF006A5B),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              color: Colors.white,
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      drawer: const AppDrawerTherapist(),
      body: Stack(
        children: [
          // Top background
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 200, // Define the desired height for the top background
            child: Container(
              color: const Color(0xFF006A5B), // Or use your own decoration
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

          // Main na screen
          Column(
            children: [
              const SizedBox(height: 30),

              /// Custom Tab bar
              ClinicMaterialsTab(
                selectedIndex: _currentIndex,
                onTabSelected: _onTabSelected,
              ),

              /// E expand kay need para makuha tanan availalble na screen
              Expanded(
                child: IndexedStack(
                  index: _currentIndex,
                  children: [
                    ViewMaterials(material: widget.clinicMaterial),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
