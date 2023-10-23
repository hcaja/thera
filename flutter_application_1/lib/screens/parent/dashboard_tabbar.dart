import 'package:flutter/material.dart';

class DashTab extends StatefulWidget {
  const DashTab({Key? key}) : super(key: key);

  @override
  State<DashTab> createState() => _DashTabState();
}

class _DashTabState extends State<DashTab> {
  int _selectedTabIndex = 0;

  void _onTabTapped(int index) {
    setState(() {
      _selectedTabIndex = index;
      if (index == 1) {
        // Navigate to the Therapists Dashboard using the defined route name
        Navigator.of(context).pushNamed('/therapiststab');
      } else if (index == 0) {
        // Navigate to the Clinic Dashboard using the defined route name
        Navigator.of(context).pushNamed('/dashboard');
      } else if (index == 2) {
        // Navigate to the Materials Dashboard using the defined route name
        Navigator.of(context).pushNamed('/materialsdash');
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
          buildTab('Clinics', 0),
          buildTab('Therapists', 1),
          buildTab('Materials', 2),
        ],
      ),
    );
  }
}
