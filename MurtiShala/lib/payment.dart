import 'package:flutter/material.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
class PaymentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Total Amount:',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 10),
            // Text(
            //   '\u20B91000.00', // Placeholder for total amount
            //   style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            //   textAlign: TextAlign.center,
            // ),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                prefixText: '\u20B9',
                hintText: 'Enter Price',
                focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.orange)),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                // Placeholder action for payment processing
                _processPayment(context);
              },
              child: Text('Pay Now'),
            ),
            ElevatedButton.icon(
              onPressed: () {
                // Placeholder action for payment processing
                _googlePay(context);
              },
              icon: Icon(EvaIcons.google) ,
              label: Text('Google Pay'),
            ),
          ],
        ),
      ),
    );
  }

  void _processPayment(BuildContext context) {
    // Placeholder function for simulating payment processing
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Payment Confirmation'),
        content: Text('Your payment has been processed successfully.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }
  void _googlePay(BuildContext context) {
    // Placeholder function for simulating payment processing
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Pay with Google Pay'),
        content: Text('Comming Soon...!'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }
}
