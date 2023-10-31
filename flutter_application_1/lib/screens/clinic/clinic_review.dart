import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/therapist/ther_review.dart';

class ClinicReview extends StatelessWidget {
  const ClinicReview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size mq = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          // Bottom Background Image
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: ConstrainedBox(
              constraints: BoxConstraints.expand(height: mq.height * 0.3),
              child: Image.asset(
                'asset/images/Ellipse 2.png', // bottom background
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Background Image
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: ConstrainedBox(
              constraints: BoxConstraints.expand(height: 100),
              child: Image.asset(
                'asset/images/Ellipse 1.png', // top background
                fit: BoxFit.cover,
              ),
            ),
          ),

          Positioned(
            top: 30,
            left: 0,
            right: 0,
            bottom: 0, // Allow the reviews to expand
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Custom Tab bar (You can add the tab bar here if needed)

                  // Add spacing between the tab bar and the reviews
                  SizedBox(height: 20),

                  // Review 1
                  ReviewWidget(
                    userName: 'User 1',
                    reviewText: 'Great experience at The Tiny House!',
                    rating: 5,
                    reviewDate: DateTime.now().toString(),
                  ),

                  // Reply Text Field for Review 1
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        hintText: 'Write your reply here...',
                        border: OutlineInputBorder(),
                      ),
                      maxLines: 5,
                    ),
                  ),

                  // Reply Button for Review 1
                  ElevatedButton(
                    onPressed: () {
                      // Handle reply submission for Review 1
                    },
                    child: const Text('Reply'),
                  ),

                  // Add spacing between reviews
                  SizedBox(height: 20),

                  // Review 2
                  ReviewWidget(
                    userName: 'User 2',
                    reviewText: 'Highly recommended!',
                    rating: 4,
                    reviewDate: DateTime.now().toString(),
                  ),

                  // Reply Text Field for Review 2
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        hintText: 'Write your reply here...',
                        border: OutlineInputBorder(),
                      ),
                      maxLines: 5,
                    ),
                  ),

                  // Reply Button for Review 2
                  ElevatedButton(
                    onPressed: () {
                      // Handle reply submission for Review 2
                    },
                    child: const Text('Reply'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
