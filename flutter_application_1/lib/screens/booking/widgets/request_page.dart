import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/booking/widgets/schedule_item.dart';

// import 'package:flutter_application_1/screens/parent/dashboard_tabbar.dart';

class RequestPage extends StatefulWidget {
  const RequestPage({Key? key}) : super(key: key);

  @override
  State<RequestPage> createState() => _RequestPageState();
}

class _RequestPageState extends State<RequestPage> {
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
            child: SizedBox(
              height: double.infinity,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: mq.height * 0.07,
                      ),
                      const Text('September, 19, 2023'),
                      SizedBox(
                        height: mq.height * 0.01,
                      ),
                      ScheduleItem(
                          mq: mq,
                          parentName: 'Taylor Swift',
                          time: '10:30 - 12:00',
                          therapist: 'Maria labo'),
                      SizedBox(
                        height: mq.height * 0.01,
                      ),
                      ScheduleItem(
                          mq: mq,
                          parentName: 'Taylor Swift',
                          time: '10:30 - 12:00',
                          therapist: 'Maria labo'),
                      SizedBox(
                        height: mq.height * 0.01,
                      ),
                      const Center(child: Text('Thats it for today')),
                    ],
                  ),
                ),
              ),
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
                  child: const SizedBox(
                    width: 60, // size of the circular FAB
                    height: 60, // size of the circular FAB
                    child: Center(
                        child: Icon(
                      Icons.calendar_month,
                      color: Colors.white,
                    )),
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
