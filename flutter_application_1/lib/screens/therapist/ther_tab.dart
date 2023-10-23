import 'package:flutter/material.dart';

class TherDashTab extends StatefulWidget {
  const TherDashTab({Key? key}) : super(key: key);

  @override
  State<TherDashTab> createState() => _TherDashTabState();
}

class _TherDashTabState extends State<TherDashTab> {
  int _selectedTabIndex = 0;

  Widget buildTab(String label, int index) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          // Update the selected tab and rebuild the widget
          setState(() {
            _selectedTabIndex = index;
          });
        },
        child: Container(
          height: 40,
          decoration: _selectedTabIndex == index
              ? ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                )
              : null,
          alignment: Alignment.center,
          child: Text(
            label,
            style: const TextStyle(
              color: Color.fromARGB(255, 3, 62, 54),
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
      decoration: ShapeDecoration(
        color: Colors.white.withOpacity(0.5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
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
