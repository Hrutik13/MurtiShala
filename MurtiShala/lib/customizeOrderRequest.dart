// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:idol_booking/admin_profile.dart';
// import 'package:idol_booking/admin_home.dart';
// import 'package:idol_booking/admin_upload.dart';
// import 'customizeOrderReq_Details.dart';
//
// class CustomizeOrderRequests extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Customize Order Requests'),
//       ),
//       body: StreamBuilder<QuerySnapshot>(
//         stream: FirebaseFirestore.instance.collection('images').snapshots(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           }
//
//           if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//             return Center(child: Text('No customize order requests found'));
//           }
//
//           return ListView.builder(
//             itemCount: snapshot.data!.docs.length,
//             itemBuilder: (context, index) {
//               var requestData = snapshot.data!.docs[index].data() as Map<String, dynamic>;
//               return Card(
//                 elevation: 3,
//                 margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//                 child: Column(
//                   children: [
//                     ListTile(
//                       title: Text('Name: ${requestData['name'] ?? 'Name not available'}'),
//                       subtitle: Text('Description: ${requestData['description'] ?? 'Description not available'}'),
//                     ),
//                     ButtonBar(
//                       alignment: MainAxisAlignment.center,
//                       children: [
//                         ElevatedButton(
//                           onPressed: () {
//                             // Handle accept action
//                           },
//                           child: Text('Accept'),
//                         ),
//                         ElevatedButton(
//                           onPressed: () {
//                             // Handle reject action
//                           },
//                           child: Text('Reject'),
//                         ),
//                         ElevatedButton(
//                           onPressed: () {
//                             Navigator.push(context, MaterialPageRoute(builder: (context)=>CutomizeOrderReq_DetailsScreen(requestData: requestData)));
//                           },
//                           child: Text('Details'),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
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
//               onPressed: () {
//                 Navigator.push(context, MaterialPageRoute(builder: (context) => Admin_Home()));
//               },
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
//               onPressed: () {
//                 Navigator.push(context, MaterialPageRoute(builder: (context) => Admin_Product()));
//               },
//               icon: Icon(Icons.add_a_photo),
//             ),
//             IconButton(
//               onPressed: () {
//                 Navigator.push(context, MaterialPageRoute(builder: (context) => Admin_Profile()));
//               },
//               icon: Icon(Icons.account_circle),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
//

//
// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'customizeOrderReq_Details.dart';
// import 'package:http/http.dart' as http;
//
// class CustomizeOrderRequests extends StatelessWidget {
//   final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Customize Order Requests'),
//       ),
//       body: StreamBuilder<QuerySnapshot>(
//         stream: FirebaseFirestore.instance.collection('images').snapshots(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           }
//
//           if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//             return Center(child: Text('No customize order requests found'));
//           }
//
//           return ListView.builder(
//             itemCount: snapshot.data!.docs.length,
//             itemBuilder: (context, index) {
//               var requestData = snapshot.data!.docs[index].data() as Map<String, dynamic>;
//               return Card(
//                 elevation: 3,
//                 margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//                 child: Column(
//                   children: [
//                     ListTile(
//                       title: Text('Name: ${requestData['name'] ?? 'Name not available'}'),
//                       subtitle: Text('Description: ${requestData['description'] ?? 'Description not available'}'),
//                     ),
//                     ButtonBar(
//                       alignment: MainAxisAlignment.center,
//                       children: [
//                         ElevatedButton(
//                           onPressed: () {
//                             _handleOrderAction(requestData['userToken'], 'Your customize order has been accepted.', 'accepted', 'orderId'); // Make sure to replace 'orderId' with the actual orderId
//                           },
//                           child: Text('Accept'),
//                         ),
//                         ElevatedButton(
//                           onPressed: () {
//                             _handleOrderAction(requestData['userToken'], 'Your customize order has been rejected.', 'rejected', 'orderId'); // Make sure to replace 'orderId' with the actual orderId
//                           },
//                           child: Text('Reject'),
//                         ),
//                         ElevatedButton(
//                           onPressed: () {
//                             Navigator.push(context, MaterialPageRoute(builder: (context)=>CutomizeOrderReq_DetailsScreen(requestData: requestData)));
//                           },
//                           child: Text('Details'),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
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
//
//   Future<void> _handleOrderAction(String? userToken, String messageBody, String status, String orderId) async {
//     try {
//       if (userToken == null) {
//         print('User token not available');
//         return;
//       }
//
//       Map<String, dynamic> data = {
//         'notification': {
//           'title': 'Order Status Update',
//           'body': messageBody,
//         },
//         'to': userToken,
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
//         print('Message sent successfully');
//         // Update status in Firestore
//         await FirebaseFirestore.instance.collection('images').doc(orderId).update({'status': status});
//       } else {
//         print('Error sending message: ${response.body}');
//       }
//     } catch (e) {
//       print('Error sending message: $e');
//     }
//   }
// }


import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'customizeOrderReq_Details.dart';

class CustomizeOrderRequests extends StatelessWidget {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Customize Order Requests'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('images').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No customize order requests found'));
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var requestData = snapshot.data!.docs[index].data() as Map<String, dynamic>;
              String? status = requestData['status'];

              return Card(
                elevation: 3,
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Column(
                  children: [
                    ListTile(
                      title: Text('Name: ${requestData['name'] ?? 'Name not available'}'),
                      subtitle: Text('Description: ${requestData['description'] ?? 'Description not available'}'),
                    ),
                    ButtonBar(
                      alignment: MainAxisAlignment.center,
                      children: [
                        if (status == null) ...[
                          ElevatedButton(
                            onPressed: () {
                              _handleOrderAction(requestData['userToken'], 'Your customize order has been accepted.', 'accepted', snapshot.data!.docs[index].id);
                            },
                            child: Text('Accept'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              _handleOrderAction(requestData['userToken'], 'Your customize order has been rejected.', 'rejected', snapshot.data!.docs[index].id);
                            },
                            child: Text('Reject'),
                          ),
                        ],
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => CutomizeOrderReq_DetailsScreen(requestData: requestData)));
                          },
                          child: Text('Details'),
                        ),
                      ],
                    ),
                  ],
                ),
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

  Future<void> _handleOrderAction(String? userToken, String messageBody, String status, String orderId) async {
    try {
      if (userToken == null) {
        print('User token not available');
        return;
      }

      Map<String, dynamic> data = {
        'notification': {
          'title': 'Order Status Update',
          'body': messageBody,
        },
        'to': userToken,
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
        print('Message sent successfully');
        // Update status in Firestore
        await FirebaseFirestore.instance.collection('images').doc(orderId).update({'status': status});
      } else {
        print('Error sending message: ${response.body}');
      }
    } catch (e) {
      print('Error sending message: $e');
    }
  }
}
