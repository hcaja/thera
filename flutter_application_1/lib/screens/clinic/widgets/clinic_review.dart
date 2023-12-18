import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/httpclinic_controller.dart';
import 'package:flutter_application_1/models/reviews.dart';
import 'package:flutter_application_1/screens/clinic/widgets/add_reviews.dart';
import 'package:flutter_application_1/screens/therapist/ther_review.dart';
import 'package:intl/intl.dart';

class ClinicReview extends StatefulWidget {
  const ClinicReview({
    Key? key,
    this.clinicId,
  }) : super(key: key);
  final int? clinicId;

  @override
  State<ClinicReview> createState() => _ClinicReviewState();
}

class _ClinicReviewState extends State<ClinicReview> {
  ClinicController clinicController = ClinicController();
  List<Reviews> reviews = [];
  void refresh() {
    clinicController.getReviews(widget.clinicId!).then((value) {
      setState(() {
        reviews = value;
      });
    });
  }

  void _showRatingModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return AddReviews(
          clinicId: widget.clinicId!,
          reload: refresh,
        );
      },
    );
  }

  @override
  void initState() {
    refresh();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size mq = MediaQuery.of(context).size;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showRatingModal(context);
        },
        shape: const CircleBorder(),
        backgroundColor: const Color(0xFF006A5B),
        foregroundColor: Colors.white,
        child: const Icon(Icons.reviews),
      ),
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
              constraints: const BoxConstraints.expand(height: 100),
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
                  const SizedBox(height: 20),

                  SizedBox(
                    height: mq.height,
                    child: ListView.builder(
                      itemCount: reviews.length,
                      itemBuilder: (context, index) {
                        return ReviewWidget(
                          userName: reviews[index].parent.fullname!,
                          reviewText: reviews[index].review,
                          rating: reviews[index].rating,
                          reviewDate: DateFormat('yyyy-MM-dd HH:mm:ss')
                              .format(reviews[index].date),
                          url:
                              'https://www.google.com/url?sa=i&url=https%3A%2F%2Fhwchamber.co.uk%2Ftestimonial-layout-test%2Favatar-placeholder%2F&psig=AOvVaw3EVI_8aP4YUn7Y-HJBulHt&ust=1702955357864000&source=images&cd=vfe&ved=0CBIQjRxqFwoTCLj1056BmIMDFQAAAAAdAAAAABAE',
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
