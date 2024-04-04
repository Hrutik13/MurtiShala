import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class PaymentDetails extends StatelessWidget {
  final Map<String, dynamic> paymentData;

  PaymentDetails({required this.paymentData});

  @override
  Widget build(BuildContext context) {
    Timestamp timestamp = paymentData['timestamp'];
    DateTime dateTime = timestamp.toDate();
    String formattedDateTime = DateFormat('MMM dd, yyyy - hh:mm a').format(dateTime);

    return Scaffold(
      appBar: AppBar(
        title: Text('Payment Details'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'User: ${paymentData['userName']}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8,),
            Text(
              'UserId: ${paymentData['userId']}',
              style: TextStyle(fontSize: 17),
            ),
            SizedBox(height: 8),
            Text(
              'Email: ${paymentData['userEmail']}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              'Amount: ${paymentData['amount']}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              'Time: $formattedDateTime',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
