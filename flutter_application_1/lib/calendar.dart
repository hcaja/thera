// import 'package:flutter/material.dart';

// class BookingScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Book an Appointment'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             const Text(
//               'Select Date and Time',
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 16),
//             // Date and Time Selection Widgets (you can use date picker and time picker here)

//             const Text(
//               'Select Service Type',
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 16),
//             // Service Type Selection Widgets (you can use radio buttons or dropdown)

//             const SizedBox(height: 32),
//             ElevatedButton(
//               onPressed: () {
//                 // Handle booking submission here
//                 // You can navigate back to the previous screen or show a confirmation dialog
//               },
//               child: const Text('Book Appointment'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// void main() {
//   runApp(MaterialApp(
//     home: Scaffold(
//       appBar: AppBar(
//         title: const Text('Existing App'),
//       ),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () {
//             // Navigate to the booking screen when a button is pressed
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => BookingScreen(),
//               ),
//             );
//           },
//           child: const Text('Open Booking Screen'),
//         ),
//       ),
//     ),
//   ));
// }
