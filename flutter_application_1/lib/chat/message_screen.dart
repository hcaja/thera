import 'package:flutter/material.dart';
// import 'package:flutter_application_1/chat/chat_user_card.dart';
import 'package:flutter_application_1/screens/auth/connection.dart';
import 'package:flutter_application_1/screens/auth/login_as.dart';
import 'package:flutter_application_1/screens/widgets/app_drawer_therapist.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> imgs = [
      "profile.jpg",
      "ther.jpg",
      "tiny.png",
      "ther.jpg",
      "profile.jpg",
      "ther.jpg",
      "profile.jpg",
      "ther.jpg",
      "tiny.png",
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Messages',
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // spacing of app bar and search bar
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Container(
                // Your search bar
                padding: const EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(50),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            hintText: "Search",
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    const Icon(
                      Icons.search,
                      color: Color(0xFF006A5B),
                    ),
                  ],
                ),
              ),
            ),

            // spacing of search bar and chat profile heads
            // const SizedBox(height: 5),

            // chat user heads pictures
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Active Now",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 90,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 9,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    width: 65,
                    height: 65,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          spreadRadius: 2,
                          blurRadius: 10,
                        )
                      ],
                    ),
                    child: Stack(
                      textDirection: TextDirection.rtl,
                      children: [
                        Center(
                          child: SizedBox(
                            height: 65,
                            width: 65,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(30),
                              child: Image.asset(
                                "asset/images/${imgs[index]}",
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),

                        // Shows when active
                        Container(
                          margin: const EdgeInsets.all(3),
                          padding: const EdgeInsets.all(4),
                          height: 20,
                          width: 20,
                          decoration: const BoxDecoration(
                              color: Colors.white, shape: BoxShape.circle),
                          child: Container(
                            decoration: const BoxDecoration(
                              color: Colors.green,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Recent Chat",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            // spacing for chat name cards and recent chat
            const SizedBox(height: 15),

            ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 9,
              shrinkWrap: true,
              separatorBuilder: (BuildContext context, int index) =>
                  const SizedBox(height: 5),
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: ListTile(
                    tileColor: Colors.green.shade50,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, '/chatscreen');
                    },
                    leading: CircleAvatar(
                      radius: 25,
                      backgroundImage:
                          AssetImage("asset/images/${imgs[index]}"),
                    ),
                    title: const Text(
                      "Name of Clinic or Therapist",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: const Text(
                      "Hello! I want to inquire.",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
