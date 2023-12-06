import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/parent/parent_journals.dart';
import 'package:flutter_application_1/screens/parent/parent_materials.dart';
import 'package:flutter_application_1/screens/widgets/app_drawer.dart';

import '../parent_profile.dart';
import '../profile_parent_tabbar.dart';

class HomeParentDashboard extends StatefulWidget {
  const HomeParentDashboard({super.key});

  @override
  HomeParentDashboardState createState() => HomeParentDashboardState();
}

class HomeParentDashboardState extends State<HomeParentDashboard> {
  int _currentIndex = 0;

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
          'Profile',
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
      drawer: const AppDrawer(),
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
              ProfileDashTab(
                selectedIndex: _currentIndex,
                onTabSelected: _onTabSelected,
              ),

              /// E expand kay need para makuha tanan availalble na screen
              Expanded(
                child: IndexedStack(
                  index: _currentIndex,
                  children: const [
                    ParentProfile(),
                    ParentMaterials(),
                    ParentJournals(),
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
