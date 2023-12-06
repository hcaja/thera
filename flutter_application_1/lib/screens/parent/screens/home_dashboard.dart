import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/key_center.dart';
import 'package:flutter_application_1/screens/auth/connection.dart';
import 'package:flutter_application_1/screens/auth/login_as.dart';
import 'package:flutter_application_1/screens/parent/custom_dash.dart';
import 'package:flutter_application_1/screens/parent/screens/parent_schedules.dart';
import 'package:flutter_application_1/screens/widgets/app_drawer.dart';
import 'package:zego_express_engine/zego_express_engine.dart';

import '../widgets/dashboard.dart';
import '../widgets/material_dash.dart';
import '../widgets/ther_dash.dart';

class HomeDashboard extends StatefulWidget {
  const HomeDashboard({super.key});

  @override
  HomeDashboardState createState() => HomeDashboardState();
}

Future<void> createEngine() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ZegoExpressEngine.createEngineWithProfile(ZegoEngineProfile(
    appID,
    ZegoScenario.Default,
    appSign: kIsWeb ? null : appSign,
  ));
}

class HomeDashboardState extends State<HomeDashboard> {
  int _currentIndex = 0;

  @override
  void initState() {
    intializeCall();
    super.initState();
  }

  // Function to handle tab changes
  void _onTabSelected(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void intializeCall() async {
    await createEngine();
  }

  @override
  Widget build(BuildContext context) {
    final Size mq = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Dashboard',
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
              DashTab(
                selectedIndex: _currentIndex,
                onTabSelected: _onTabSelected,
              ),

              /// E expand kay need para makuha tanan availalble na screen
              Expanded(
                child: IndexedStack(
                  index: _currentIndex,
                  children: const [
                    Dashboard(),
                    TherapistsDashboard(),
                    MaterialsTab(),
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
