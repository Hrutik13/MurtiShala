import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserFeedbackScreen extends StatelessWidget {
  UserFeedbackScreen({Key? key}) : super(key: key);

  final TextEditingController _feedbackController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Feedback')),
      body: Column(
        children: [
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              alignment: Alignment.center,
              child: Text(
                'Feedback',
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.w700),
              ),
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(top: 8, left: 30, right: 30),
            child: Container(
              child: TextField(
                controller: _feedbackController,
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: 'Enter Your Feedback',
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.orange),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Container(
              width: 275,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.blue.shade200,
              ),
              child: TextButton(
                onPressed: () {
                  String feedback = _feedbackController.text;
                  _submitFeedback(context, feedback); // Pass context here
                },
                child: const Text(
                  'Submit',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _submitFeedback(BuildContext context, String feedback) {
    User? user= FirebaseAuth.instance.currentUser;
    CollectionReference feedbackCollection = FirebaseFirestore.instance.collection('feedback');
    feedbackCollection.add({
      'email':user?.email,
      'UserId':user?.uid,
      'feedback': feedback,
      'timestamp': DateTime.now(),
    }).then((value) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Feedback submitted successfully!'),
        duration: Duration(seconds: 2),
      ));
      _feedbackController.clear();
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to submit feedback: $error'),
        duration: Duration(seconds: 2),
      ));
    });
  }
}
