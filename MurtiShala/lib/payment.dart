// import 'package:flutter/material.dart';
// import 'package:eva_icons_flutter/eva_icons_flutter.dart';
// class PaymentPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Payment'),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(20.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             Text(
//               'Total Amount:',
//               style: TextStyle(fontSize: 20),
//             ),
//             SizedBox(height: 10),
//             // Text(
//             //   '\u20B91000.00', // Placeholder for total amount
//             //   style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//             //   textAlign: TextAlign.center,
//             // ),
//             TextField(
//               keyboardType: TextInputType.number,
//               decoration: InputDecoration(
//                 prefixText: '\u20B9',
//                 hintText: 'Enter Price',
//                 focusedBorder: const OutlineInputBorder(
//                     borderSide: BorderSide(color: Colors.orange)),
//                 border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(10)),
//               ),
//             ),
//             SizedBox(height: 30),
//             ElevatedButton(
//               onPressed: () {
//                 // Placeholder action for payment processing
//                 _processPayment(context);
//               },
//               child: Text('Pay Now'),
//             ),
//             ElevatedButton.icon(
//               onPressed: () {
//                 // Placeholder action for payment processing
//                 _googlePay(context);
//               },
//               icon: Icon(EvaIcons.google) ,
//               label: Text('Google Pay'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   void _processPayment(BuildContext context) {
//     // Placeholder function for simulating payment processing
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text('Payment Confirmation'),
//         content: Text('Your payment has been processed successfully.'),
//         actions: [
//           TextButton(
//             onPressed: () {
//               Navigator.pop(context);
//             },
//             child: Text('OK'),
//           ),
//         ],
//       ),
//     );
//   }
//   void _googlePay(BuildContext context) {
//     // Placeholder function for simulating payment processing
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text('Pay with Google Pay'),
//         content: Text('Comming Soon...!'),
//         actions: [
//           TextButton(
//             onPressed: () {
//               Navigator.pop(context);
//             },
//             child: Text('OK'),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';

class PaymentPage extends StatelessWidget {
  final TextEditingController _amountController = TextEditingController();

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
            TextField(
              controller: _amountController,
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
                _processPayment(context);
              },
              child: Text('Pay Now'),
            ),
            SizedBox(height: 10,),
            ElevatedButton.icon(onPressed: (){
              _googlePay(context);
            },
                icon: Icon(EvaIcons.google),
                label: Text('Google Pay'))
          ],
        ),
      ),
    );
  }

  void _processPayment(BuildContext context) async {
    double amount = double.tryParse(_amountController.text) ?? 0.0;
    if (amount <= 0) {
      // Handle invalid input
       Fluttertoast.showToast(msg: 'enter valid amount');
       return;
    }

    // Get current user
    User? user = FirebaseAuth.instance.currentUser;

    // If user is authenticated
    if (user != null) {
      // Get user ID
      String userId = user.uid;

      try {
        // Reference to the user document in Firestore
        DocumentReference userRef =
        FirebaseFirestore.instance.collection('Users').doc(userId);

        // Check if the user document exists
        DocumentSnapshot<Map<String, dynamic>> userSnapshot =
        await userRef.get() as DocumentSnapshot<Map<String, dynamic>>;

        if (userSnapshot.exists) {
          // Get the user's display name and email
          String? userName = userSnapshot.data()?['name'];
          String? userEmail = userSnapshot.data()?['email'];

          // If name or email is not available, fallback to defaults
          userName ??= 'Unknown';
          userEmail ??= 'Unknown';

          // Store payment information in Firestore
          await FirebaseFirestore.instance.collection('payments').add({
            'userId': userId,
            'userName': userName,
            'userEmail': userEmail,
            'amount': amount,
            'timestamp': FieldValue.serverTimestamp(), // Server timestamp
          });
          _amountController.clear();
          _showConfirmationDialog(context);
        } else {
          // User document doesn't exist
          print('User document not found in Firestore for user ID: $userId');
          // Handle this case, maybe prompt the user to complete their profile or take appropriate action
        }
      } catch (e) {
        // Error fetching user data
        print('Error fetching user data from Firestore: $e');
        // Handle this error, maybe show a snackbar or take appropriate action
      }
    } else {
      // User is not authenticated
      print('User is not authenticated');
      // Handle this case, maybe prompt the user to log in or take appropriate action
    }
  }

  void _showConfirmationDialog(BuildContext context) {
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

  void _googlePay (BuildContext context){
    showDialog(
        context: context,
        builder: (context)=> AlertDialog(
          title: Text('Pay with Google..'),
          content: Text('Comming Soon...'),
          icon: Icon(EvaIcons.smilingFace),
          actions: [
            TextButton(onPressed: (){
              Navigator.pop(context);
            },
                child: Text('OK')),
          ],

        )
    );
  }
}
