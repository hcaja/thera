import 'package:flutter/material.dart';

class ParentTabBar extends StatefulWidget {
  const ParentTabBar({Key? key}) : super(key: key);

  @override
  State<ParentTabBar> createState() => _ParentTabBarState();
}

class _ParentTabBarState extends State<ParentTabBar> {
  int _selectedTabIndex = 0;

  void _onTabTapped(int index) {
    setState(() {
      _selectedTabIndex = index;
      if (index == 1) {
        // Navigate to the Therapists Dashboard using the defined route name
        Navigator.of(context).pushNamed('/parentmaterials');
      } else if (index == 0) {
        // Navigate to the Clinic Dashboard using the defined route name
        Navigator.of(context).pushNamed('/parentprofile');
      } else if (index == 2) {
        // Navigate to the Materials Dashboard using the defined route name
        Navigator.of(context).pushNamed('/parentjournals');
      }
    });
  }

  Widget buildTab(String label, int index) {
    final isSelected = _selectedTabIndex == index;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          _onTabTapped(index); // Call the method to handle navigation
        },
        child: Container(
          height: 40,
          decoration: BoxDecoration(
            color: isSelected
                ? Colors.white
                : Colors
                    .transparent, // Set background color to white when selected
            borderRadius: BorderRadius.circular(20),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(
              color: isSelected
                  ? const Color.fromARGB(255, 3, 62, 54)
                  : Colors.white, // Set text color based on selection
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350, // Adjust the width as needed
      height: 40,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.5),
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          buildTab('Profile', 0),
          buildTab('Materials', 1),
          buildTab('Journals', 2),
        ],
      ),
    );
  }
}
