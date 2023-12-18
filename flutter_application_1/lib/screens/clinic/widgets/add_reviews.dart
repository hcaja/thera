import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/httpclinic_controller.dart';

class AddReviews extends StatefulWidget {
  const AddReviews({
    super.key,
    required this.clinicId,
    required this.reload,
  });
  final int clinicId;
  final VoidCallback reload;

  @override
  State<AddReviews> createState() => _AddReviewsState();
}

class _AddReviewsState extends State<AddReviews> {
  ClinicController clinicController = ClinicController();
  int rating = 0;
  TextEditingController reviewController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Container(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const Text(
                    'Rate and Review',
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(5, (index) {
                      return IconButton(
                        onPressed: () {
                          setState(() {
                            rating = index + 1;
                          });
                        },
                        icon: Icon(
                          index < rating ? Icons.star : Icons.star_border,
                          size: 30.0,
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 16.0),
                  TextField(
                    controller: reviewController,
                    decoration: const InputDecoration(
                      hintText: 'Write your review...',
                    ),
                    maxLines: 3,
                  ),
                  const SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () {
                      clinicController
                          .saveReviews(
                              widget.clinicId, rating, reviewController.text)
                          .then((value) {
                        if (value) {
                          widget.reload();
                          Navigator.pop(context);
                        }
                      });
                    },
                    child: const Text('Submit'),
                  ),
                ],
              ),
            )));
  }
}
