// //Running code and msg sending by this code//
//
// //
// // import 'dart:convert';
// // import 'package:http/http.dart' as http;
// // import 'package:flutter/material.dart';
// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:intl/intl.dart';
// // import 'package:firebase_messaging/firebase_messaging.dart'; // Import FirebaseMessaging
// // import 'orderRequestDetails.dart';
// // import 'customizeOrderRequest.dart';
// //
// // class OrderRequests extends StatefulWidget {
// //   @override
// //   _OrderRequestsState createState() => _OrderRequestsState();
// // }
// //
// // class _OrderRequestsState extends State<OrderRequests> {
// //   final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         backgroundColor: Colors.lightBlue.shade50,
// //         title: Text('Order requests'),
// //         toolbarHeight: 50,
// //         bottom: PreferredSize(preferredSize: Size.fromHeight(50),
// //             child: ElevatedButton(onPressed: () {
// //               Navigator.push(context, MaterialPageRoute(
// //                   builder: (context) => CustomizeOrderRequests()));
// //             },
// //                 child: Text("Customize Orders Requests"))),
// //       ),
// //       body: StreamBuilder<QuerySnapshot>(
// //         stream: FirebaseFirestore.instance.collection('orderRequests').orderBy(
// //             'timestamp', descending: false).snapshots(),
// //         builder: (context, snapshot) {
// //           if (snapshot.connectionState == ConnectionState.waiting) {
// //             return Center(child: CircularProgressIndicator());
// //           }
// //
// //           if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
// //             return Center(child: Text('No order requests found'));
// //           }
// //
// //           return ListView.builder(
// //             reverse: true, // Display items in reverse order
// //             itemCount: snapshot.data!.docs.length,
// //             itemBuilder: (context, index) {
// //               var orderData = snapshot.data!.docs[index].data() as Map<
// //                   String,
// //                   dynamic>;
// //               Timestamp timestamp = orderData['timestamp'];
// //               DateTime dateTime = timestamp.toDate();
// //
// //               // Format date and time
// //               String formattedDateTime = DateFormat('yyyy-MM-dd HH:mm').format(
// //                   dateTime);
// //
// //               return GestureDetector(
// //                 onTap: () {
// //                   // Handle tapping on order request
// //                 },
// //                 child: Card(
// //                   margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
// //                   child: Column(
// //                     crossAxisAlignment: CrossAxisAlignment.start,
// //                     children: [
// //                       ListTile(
// //                         title: Text('Name: ${orderData['name'] ?? 'Unknown'}'),
// //                         subtitle: Column(
// //                           crossAxisAlignment: CrossAxisAlignment.start,
// //                           children: [
// //                             SizedBox(height: 4),
// //                             Text('Contact: ${orderData['contact'] ??
// //                                 'Not provided'}'),
// //                             SizedBox(height: 4),
// //                             Text('Date and Time: $formattedDateTime'),
// //                             // Display formatted date and time
// //                           ],
// //                         ),
// //                       ),
// //                       SizedBox(height: 8),
// //                       Row(
// //                         mainAxisAlignment: MainAxisAlignment.end,
// //                         children: [
// //                           ElevatedButton(
// //                             onPressed: () {
// //                               _sendNotification(orderData['userToken'],
// //                                   'Your order has been accepted.');
// //                             },
// //                             child: Text('Accept'),
// //                           ),
// //                           SizedBox(width: 8),
// //                           ElevatedButton(
// //                             onPressed: () {
// //                               _sendNotification(orderData['userToken'],
// //                                   'Your order has been rejected.');
// //                             },
// //                             child: Text('Reject'),
// //                           ),
// //                           SizedBox(width: 8),
// //                           ElevatedButton(
// //                             onPressed: () {
// //                               Navigator.push(context, MaterialPageRoute(
// //                                   builder: (context) =>
// //                                       OrderDetailsScreen(
// //                                           orderData: orderData)));
// //                             },
// //                             child: Text('Details'),
// //                           ),
// //                         ],
// //                       ),
// //                     ],
// //                   ),
// //                 ),
// //               );
// //             },
// //           );
// //         },
// //       ),
// //       bottomNavigationBar: BottomAppBar(
// //         height: 80,
// //         color: Colors.white,
// //         child: Row(
// //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// //           children: [
// //             IconButton(
// //               onPressed: () {},
// //               icon: Icon(Icons.home),
// //             ),
// //             IconButton(
// //               onPressed: () {},
// //               icon: Icon(Icons.people_alt),
// //             ),
// //             IconButton(
// //               onPressed: () {},
// //               icon: Icon(Icons.production_quantity_limits),
// //             ),
// //             IconButton(
// //               onPressed: () {},
// //               icon: Icon(Icons.add_a_photo),
// //             ),
// //             IconButton(
// //               onPressed: () {},
// //               icon: Icon(Icons.account_circle),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// //
// //   // Method to send notification
// //   Future<void> _sendNotification(String userToken, String messageBody) async {
// //     try {
// //       Map<String, dynamic> data = {
// //         'notification': {
// //           'title': 'Order Status Update',
// //           'body': messageBody,
// //         },
// //         'to': userToken,
// //       };
// //
// //       final response = await http.post(
// //         Uri.parse('https://fcm.googleapis.com/fcm/send'),
// //         headers: {
// //           'Content-Type': 'application/json',
// //           'Authorization': 'key=AAAAIJxnXhg:APA91bFuGf_4JC32qjBWc1374JrEAp5YBaoVYja_TsIPxwl5V2L6P8FvLt4xTuA04jWbh047DYkS0fgY9KUfmdp99phzs3OEc7qW2YJa9HxKuskm_POiKV4hJdnDHy2x0Sw_yFct7qOP',
// //           // Replace with your FCM server key
// //         },
// //         body: jsonEncode(data),
// //       );
// //
// //       if (response.statusCode == 200) {
// //         if (mounted) {
// //           print('Message sent successfully');
// //           // Update widget state or show message if needed
// //         }
// //       } else {
// //         print('Error sending message: ${response.body}');
// //       }
// //     } catch (e) {
// //       print('Error sending message: $e');
// //     }
// //   }
// // }
//
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:intl/intl.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'orderRequestDetails.dart';
// import 'customizeOrderRequest.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
//
// class OrderRequests extends StatefulWidget {
//   @override
//   _OrderRequestsState createState() => _OrderRequestsState();
// }
//
// class _OrderRequestsState extends State<OrderRequests> {
//   final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.lightBlue.shade50,
//         title: Text('Order requests'),
//         toolbarHeight: 50,
//         bottom: PreferredSize(
//           preferredSize: Size.fromHeight(50),
//           child: ElevatedButton(
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => CustomizeOrderRequests(),
//                 ),
//               );
//             },
//             child: Text("Customize Orders Requests"),
//           ),
//         ),
//       ),
//       body: StreamBuilder<QuerySnapshot>(
//         stream: FirebaseFirestore.instance
//             .collection('orderRequests')
//             .orderBy('timestamp', descending: false) // Newest orders first
//             .snapshots(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           }
//
//           if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//             return Center(child: Text('No order requests found'));
//           }
//
//           List<DocumentSnapshot> reversedDocs = snapshot.data!.docs.reversed.toList();
//
//           return ListView.builder(
//             itemCount: reversedDocs.length,
//             itemBuilder: (context, index) {
//               var orderData = reversedDocs[index].data() as Map<String, dynamic>;
//               Timestamp timestamp = orderData['timestamp'];
//               DateTime dateTime = timestamp.toDate();
//
//               String formattedDateTime = DateFormat('yyyy-MM-dd HH:mm').format(dateTime);
//
//               return OrderItem(
//                 orderData: orderData,
//                 orderId: reversedDocs[index].id,
//                 formattedDateTime: formattedDateTime,
//               );
//             },
//           );
//         },
//       ),
//       bottomNavigationBar: BottomAppBar(
//         height: 80,
//         color: Colors.white,
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: [
//             IconButton(
//               onPressed: () {},
//               icon: Icon(Icons.home),
//             ),
//             IconButton(
//               onPressed: () {},
//               icon: Icon(Icons.people_alt),
//             ),
//             IconButton(
//               onPressed: () {},
//               icon: Icon(Icons.production_quantity_limits),
//             ),
//             IconButton(
//               onPressed: () {},
//               icon: Icon(Icons.add_a_photo),
//             ),
//             IconButton(
//               onPressed: () {},
//               icon: Icon(Icons.account_circle),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class OrderItem extends StatelessWidget {
//   final Map<String, dynamic> orderData;
//   final String orderId;
//   final String formattedDateTime;
//
//   const OrderItem({
//     required this.orderData,
//     required this.orderId,
//     required this.formattedDateTime,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         // Handle tap
//       },
//       child: Card(
//         margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             ListTile(
//               title: Text('Name: ${orderData['name'] ?? 'Unknown'}'),
//               subtitle: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   SizedBox(height: 4),
//                   Text('Contact: ${orderData['contact'] ?? 'Not provided'}'),
//                   SizedBox(height: 4),
//                   Text('Date and Time: $formattedDateTime'),
//                 ],
//               ),
//             ),
//             SizedBox(height: 8),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 ElevatedButton(
//                   onPressed: () {
//                     _handleOrderAction(
//                       orderData['userToken'],
//                       'Your order has been accepted.',
//                       'accepted',
//                       orderId,
//                     );
//                   },
//                   child: Text('Accept'),
//                 ),
//                 SizedBox(width: 8),
//                 ElevatedButton(
//                   onPressed: () {
//                     _handleOrderAction(
//                       orderData['userToken'],
//                       "Your order has been rejected. ",
//                       'rejected',
//                       orderId,
//                     );
//                   },
//                   child: Text('Reject'),
//                 ),
//                 SizedBox(width: 8),
//                 ElevatedButton(
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) =>
//                             OrderDetailsScreen(
//                               orderData: orderData,
//                             ),
//                       ),
//                     );
//                   },
//                   child: Text('Details'),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Future<void> _handleOrderAction(String userToken, String messageBody,
//       String status, String orderId) async {
//     try {
//       Map<String, dynamic> data = {
//         'notification': {
//           'title': 'Order Status Update',
//           'body': messageBody,
//         },
//         'to': userToken,
//         // Send the notification to the specific user using their FCM token
//       };
//
//       final response = await http.post(
//         Uri.parse('https://fcm.googleapis.com/fcm/send'),
//         headers: {
//           'Content-Type': 'application/json',
//           'Authorization':
//           'key=AAAAIJxnXhg:APA91bFuGf_4JC32qjBWc1374JrEAp5YBaoVYja_TsIPxwl5V2L6P8FvLt4xTuA04jWbh047DYkS0fgY9KUfmdp99phzs3OEc7qW2YJa9HxKuskm_POiKV4hJdnDHy2x0Sw_yFct7qOP',
//         },
//         body: jsonEncode(data),
//       );
//
//       if (response.statusCode == 200) {
//         Fluttertoast.showToast(msg: 'Message sent successfully',);
//         // Update status in Firestore
//         await FirebaseFirestore.instance.collection('orderRequests').doc(
//             orderId).update({'status': status});
//       } else {
//         Fluttertoast.showToast(msg: 'Error sending message: ${response.body}');
//       }
//     } catch (e) {
//       Fluttertoast.showToast(msg: 'Error sending message: $e');
//     }
//   }
// }


import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'orderRequestDetails.dart';
import 'customizeOrderRequest.dart';
import 'package:fluttertoast/fluttertoast.dart';

class OrderRequests extends StatefulWidget {
  @override
  _OrderRequestsState createState() => _OrderRequestsState();
}

class _OrderRequestsState extends State<OrderRequests> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue.shade50,
        title: Text('Order requests'),
        toolbarHeight: 50,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CustomizeOrderRequests(),
                ),
              );
            },
            child: Text("Customize Orders Requests"),
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('orderRequests')
            .orderBy('timestamp', descending: false) // Newest orders first
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No order requests found'));
          }

          List<DocumentSnapshot> reversedDocs = snapshot.data!.docs.reversed.toList();

          return ListView.builder(
            itemCount: reversedDocs.length,
            itemBuilder: (context, index) {
              var orderData = reversedDocs[index].data() as Map<String, dynamic>;
              Timestamp timestamp = orderData['timestamp'];
              DateTime dateTime = timestamp.toDate();

              String formattedDateTime = DateFormat('yyyy-MM-dd HH:mm').format(dateTime);

              return OrderItem(
                orderData: orderData,
                orderId: reversedDocs[index].id,
                formattedDateTime: formattedDateTime,
              );
            },
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        height: 80,
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.home),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.people_alt),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.production_quantity_limits),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.add_a_photo),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.account_circle),
            ),
          ],
        ),
      ),
    );
  }
}

class OrderItem extends StatelessWidget {
  final Map<String, dynamic> orderData;
  final String orderId;
  final String formattedDateTime;

  const OrderItem({
    required this.orderData,
    required this.orderId,
    required this.formattedDateTime,
  });

  @override
  Widget build(BuildContext context) {
    bool showActionButtons = orderData['status'] == null; // Show buttons if status is not set

    return GestureDetector(
      onTap: () {
        // Handle tap
      },
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: Text('Name: ${orderData['name'] ?? 'Unknown'}'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 4),
                  Text('Contact: ${orderData['contact'] ?? 'Not provided'}'),
                  SizedBox(height: 4),
                  Text('Date and Time: $formattedDateTime'),
                ],
              ),
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Visibility(
                  visible: showActionButtons, // Only show buttons if showActionButtons is true
                  child: ElevatedButton(
                    onPressed: () {
                      _handleOrderAction(
                        orderData['userToken'],
                        'Your order has been accepted.',
                        'accepted',
                        orderId,
                      );
                    },
                    child: Text('Accept'),
                  ),
                ),
                SizedBox(width: 8),
                Visibility(
                  visible: showActionButtons, // Only show buttons if showActionButtons is true
                  child: ElevatedButton(
                    onPressed: () {
                      _handleOrderAction(
                        orderData['userToken'],
                        "Your order has been rejected. ",
                        'rejected',
                        orderId,
                      );
                    },
                    child: Text('Reject'),
                  ),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            OrderDetailsScreen(
                              orderData: orderData,
                            ),
                      ),
                    );
                  },
                  child: Text('Details'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _handleOrderAction(String userToken, String messageBody,
      String status, String orderId) async {
    try {
      Map<String, dynamic> data = {
      'notification': {
      'title': 'Order Status Update',
          'body': messageBody,
        },
        'to': userToken,
        // Send the notification to the specific user using their FCM token
      };

      final response = await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization':
          'key=AAAAIJxnXhg:APA91bFuGf_4JC32qjBWc1374JrEAp5YBaoVYja_TsIPxwl5V2L6P8FvLt4xTuA04jWbh047DYkS0fgY9KUfmdp99phzs3OEc7qW2YJa9HxKuskm_POiKV4hJdnDHy2x0Sw_yFct7qOP',
        },
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        Fluttertoast.showToast(msg: 'Message sent successfully',);
        // Update status in Firestore
        await FirebaseFirestore.instance.collection('orderRequests').doc(
            orderId).update({'status': status});
      } else {
        Fluttertoast.showToast(msg: 'Error sending message: ${response.body}');
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'Error sending message: $e');
    }
  }
}


