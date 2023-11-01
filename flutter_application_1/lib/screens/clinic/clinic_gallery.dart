import 'package:flutter/material.dart';

class ClinicGallery extends StatefulWidget {
  const ClinicGallery({Key? key}) : super(key: key);

  @override
  State<ClinicGallery> createState() => _ClinicGalleryState();
}

class _ClinicGalleryState extends State<ClinicGallery> {
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
                'asset/images/Ellipse 2.png',
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
              constraints: const BoxConstraints.expand(height: 100),
              child: Image.asset(
                'asset/images/Ellipse 1.png',
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Content Below CustomTabBar
          Positioned(
            top: mq.height * 0.30,
            left: 0,
            right: 0,
            bottom: 0, // Allow the content to expand
            child: const SingleChildScrollView(
              child: Column(
                children: [
                  // Add your content here
                ],
              ),
            ),
          ),
          // Gallery UI and Upload Button
          Positioned(
            bottom: 20, // Adjust the position as needed
            right: 20, // Adjust the position as needed
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Handle image upload here
                    // You can open a file picker or camera to select/upload an image
                  },
                  child: const Icon(Icons.upload),
                ),
                const SizedBox(height: 10), // Adjust the spacing
                // Add your gallery UI here
                // For example, you can use a GridView.builder to display images
              ],
            ),
          ),
        ],
      ),
    );
  }
}
