import 'package:flutter/material.dart';

class ChatUserCard extends StatelessWidget {
  const ChatUserCard({super.key});

  @override
  Widget build(BuildContext context) {
    final Size mq = MediaQuery.of(context).size;

    return Card(
      margin: EdgeInsets.symmetric(horizontal: mq.width * 0.055, vertical: 3),
      color: const Color(0xFFA8EEE4),
      elevation: 0.5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: InkWell(
        onTap: () {
          // Handle the navigation to the chat screen here
        },
        child: Padding(
          padding: const EdgeInsets.all(.05),
          child: ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(mq.height * 0.3),
              child: CircleAvatar(
                backgroundColor: const Color(
                    0xFF80B5AD), // Replace with your user's profile image
                radius: mq.height * 0.0375, // Adjust the size as needed
              ),
            ),
            title: const Text(
              "User Name", // Replace with your user's name
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            subtitle: const Text(
              "Last message goes here", // Replace with the last message text
              style: TextStyle(
                fontSize: 14,
              ),
            ),
            trailing: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "10:30 AM", // Replace with the message timestamp
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
                // You can add an indicator for unread messages here
              ],
            ),
          ),
        ),
      ),
    );
  }
}
