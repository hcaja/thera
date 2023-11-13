import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/httptherapist_controller.dart';
import 'package:flutter_application_1/screens/booking/widgets/booking_tab.dart';
import 'package:flutter_application_1/screens/booking/widgets/request_page.dart';
import 'package:flutter_application_1/screens/booking/widgets/schedule_page.dart';
import 'package:flutter_application_1/screens/booking/widgets/today_page.dart';
import 'package:flutter_application_1/screens/widgets/app_drawer_therapist.dart';


class BookingScreen extends StatefulWidget {
  const BookingScreen({Key? key}) : super(key: key);

  @override
  State<BookingScreen> createState() => _BookingScreen();
}

class _BookingScreen extends State<BookingScreen> {
  TherapistController controller = TherapistController();
  TextEditingController aboutController = TextEditingController();
  bool isLoading = true;
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
          'Booking Schedule',
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

      // drawer or sidebar of hamburger menu
      drawer: const AppDrawerTherapist(),

      // body
      body: !isLoading
          ? const Center(child: CircularProgressIndicator.adaptive())
          : Builder(
              builder: (context) => Stack(
                children: [
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    height:
                        200, // Define the desired height for the top background
                    child: Container(
                      color:
                          const Color(0xFF006A5B), // Or use your own decoration
                    ),
                  ),

                  // bottom background
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: ConstrainedBox(
                      constraints:
                          BoxConstraints.expand(height: mq.height * 0.3),
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
                      BookingTab(
                        selectedIndex: _currentIndex,
                        onTabSelected: _onTabSelected,
                      ),

                      /// E expand kay need para makuha tanan availalble na screen
                      Expanded(
                        child: IndexedStack(
                          index: _currentIndex,
                          children: const [
                            TodayPage(),
                            SchedulePage(),
                            RequestPage(),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}
