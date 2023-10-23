import 'package:flutter/material.dart';
import 'package:flutter_application_1/chat/chat_sample.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: AppBar(
          backgroundColor: const Color(0xFF006A5B),
          iconTheme: const IconThemeData(color: Colors.white),
          leadingWidth: 25,
          title: const Padding(
            padding: EdgeInsets.only(top: 8),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 19,
                  backgroundImage: AssetImage("asset/images/profile.jpg"),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text(
                    "Clinic or Therapist Name",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // action button for settings
          actions: const [
            Padding(
              padding: EdgeInsets.only(top: 8, right: 10),
              child: Icon(
                Icons.more_vert,
                color: Colors.white,
                size: 26,
              ),
            ),
          ],
        ),
      ),
      body: ListView.builder(
        itemCount: 10,
        padding:
            const EdgeInsets.only(top: 20, right: 15, left: 15, bottom: 80),
        itemBuilder: (context, index) => const ChatSample(),
      ),
      bottomNavigationBar: Container(
        height: 65,
        decoration: const BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(
            color: Colors.black12,
            spreadRadius: 2,
            blurRadius: 10,
          )
        ]),
        child: Row(
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 8),
              child: Icon(
                Icons.add,
                size: 30,
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 8),
              child: Icon(
                Icons.emoji_emotions_outlined,
                color: Color.fromARGB(255, 255, 206, 57),
                size: 30,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Container(
                alignment: Alignment.centerRight,
                width: MediaQuery.of(context).size.width / 1.6,
                child: TextFormField(
                  decoration: const InputDecoration(
                    hintText: "Type your message here",
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Icon(Icons.send, size: 30, color: Colors.green.shade200),
            ),
          ],
        ),
      ),
    );
  }
}
