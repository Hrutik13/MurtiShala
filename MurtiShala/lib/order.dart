//
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
//
// class Order extends StatelessWidget {
//   final String productId; // New field to store product ID
//   Order({Key? key, required this.productId}) : super(key: key);
//
//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _addressController = TextEditingController();
//   final TextEditingController _pincodeController = TextEditingController();
//   final TextEditingController _contactController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.lightBlue.shade50,
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             SizedBox(height: 30),
//             Padding(
//               padding: const EdgeInsets.only(left: 30, right: 30, top: 8, bottom: 8),
//               child: TextField(
//                 controller: _nameController,
//                 decoration: InputDecoration(
//                   hintText: 'Enter your name *',
//                   focusedBorder: const OutlineInputBorder(
//                       borderSide: BorderSide(color: Colors.orange)),
//                   border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10)),
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(left: 30, right: 30, top: 8, bottom: 8),
//               child: TextField(
//                 controller: _addressController,
//                 maxLines: 5,
//                 decoration: InputDecoration(
//                   hintText: 'Delivery Address',
//                   focusedBorder: const OutlineInputBorder(
//                       borderSide: BorderSide(color: Colors.orange)),
//                   border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10)),
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(left: 30, right: 30, top: 8, bottom: 8),
//               child: TextField(
//                 controller: _pincodeController,
//                 keyboardType: TextInputType.number,
//                 decoration: InputDecoration(
//                   hintText: 'Pincode',
//                   focusedBorder: const OutlineInputBorder(
//                       borderSide: BorderSide(color: Colors.orange)),
//                   border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10)),
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(left: 30, right: 30, top: 8, bottom: 8),
//               child: TextField(
//                 controller: _contactController,
//                 keyboardType: TextInputType.phone,
//                 decoration: InputDecoration(
//                   hintText: 'Contact no.',
//                   focusedBorder: const OutlineInputBorder(
//                       borderSide: BorderSide(color: Colors.orange)),
//                   border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10)),
//                 ),
//               ),
//             ),
//             SizedBox(height: 30),
//             Padding(
//               padding: const EdgeInsets.all(15),
//               child: Container(
//                 width: 275,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(10),
//                   color: Colors.blue.shade100,
//                 ),
//                 child: TextButton(
//                   onPressed: () {
//                     // Create order request
//                     _sendOrderRequest(context);
//                   },
//                   child: const Text(
//                     'Book Now',
//                     style: TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   void _sendOrderRequest(BuildContext context) async {
//     // Retrieve order details from text controllers
//     String name = _nameController.text;
//     String address = _addressController.text;
//     String pincode = _pincodeController.text;
//     String contact = _contactController.text;
//
//     User? user = FirebaseAuth.instance.currentUser;
//     // Validate if required fields are filled
//     if (name.isNotEmpty && address.isNotEmpty && pincode.isNotEmpty && contact.isNotEmpty) {
//       // Add order request to Firestore
//       await FirebaseFirestore.instance.collection('orderRequests').add({
//         'userID': user?.uid,
//         'productId': productId, // Store product ID
//         'image':imageUrl,
//         'name': name,
//         'email':user?.email,
//         'address': address,
//         'pincode': pincode,
//         'contact': contact,
//         'timestamp': DateTime.now(),
//       });
//
//       // Show confirmation message
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         content: Text('Order request sent successfully!'),
//         duration: Duration(seconds: 3),
//       ));
//
//       // Clear text controllers
//       _nameController.clear();
//       _addressController.clear();
//       _pincodeController.clear();
//       _contactController.clear();
//     } else {
//       // Show error message if required fields are empty
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         content: Text('Please fill all required fields.'),
//         duration: Duration(seconds: 2),
//       ));
//     }
//   }
// }

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class Order extends StatelessWidget {
  final String productId; // New field to store product ID
  final String imageUrl; // New field to store product image URL
  final String productName; // New field to store product name
  final String productDescription; // New field to store product description
  final String height;
  final String price;

  Order({
    Key? key,
    required this.productId,
    required this.imageUrl,
    required this.productName,
    required this.productDescription,
    required this.height,
    required this.price,
  }) : super(key: key);

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _pincodeController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue.shade50,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30, top: 8, bottom: 8),
              child: TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  hintText: 'Enter your name *',
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.orange),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30, top: 8, bottom: 8),
              child: TextField(
                controller: _addressController,
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: 'Delivery Address',
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.orange),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30, top: 8, bottom: 8),
              child: TextField(
                controller: _pincodeController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Pincode',
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.orange),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30, top: 8, bottom: 8),
              child: TextField(
                controller: _contactController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  hintText: 'Contact no.',
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.orange),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Container(
                width: 275,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.blue.shade100,
                ),
                child: TextButton(
                  onPressed: () {
                    // Create order request
                    _sendOrderRequest(context);
                  },
                  child: const Text(
                    'Book Now',
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
      ),
    );
  }

  void _sendOrderRequest(BuildContext context) async {
    // Retrieve order details from text controllers
    String name = _nameController.text;
    String address = _addressController.text;
    String pincode = _pincodeController.text;
    String contact = _contactController.text;

    User? user = FirebaseAuth.instance.currentUser;
    // Validate if required fields are filled
    if (name.isNotEmpty && address.isNotEmpty && pincode.isNotEmpty && contact.isNotEmpty) {
      // Retrieve FCM token
      String? fcmToken = await FirebaseMessaging.instance.getToken();

      // Add order request to Firestore
      try {
        DocumentReference orderRef = await FirebaseFirestore.instance.collection('orderRequests').add({
          'userID': user?.uid,
          'productId': productId, // Store product ID
          'image': imageUrl, // Store product image URL
          'productName': productName, // Store product name
          'productDescription': productDescription, // Store product description
          'productPrice': price,
          'height': height,
          'name': name,
          'email': user?.email,
          'address': address,
          'pincode': pincode,
          'contact': contact,
          'timestamp': DateTime.now(),
          'userToken': fcmToken, // Store FCM token
        });

        // Get the orderId from the document reference
        String orderId = orderRef.id;

        // Update the order document with the orderId
        await orderRef.update({'orderId': orderId});

        // Show confirmation message
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Order request sent successfully!'),
          duration: Duration(seconds: 3),
        ));

        // Clear text controllers
        _nameController.clear();
        _addressController.clear();
        _pincodeController.clear();
        _contactController.clear();
      } catch (e) {
        print('Error adding order request: $e');
        // Show error message
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Failed to send order request. Please try again.'),
          duration: Duration(seconds: 2),
        ));
      }
      }
  }
}

