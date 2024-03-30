import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'orderRequestDetails.dart';

class YourOrderPage extends StatefulWidget {
  @override
  _YourOrderPageState createState() => _YourOrderPageState();
}

class _YourOrderPageState extends State<YourOrderPage> {
  late User? _user;
  late Stream<QuerySnapshot> _ordersStream;

  @override
  void initState() {
    super.initState();
    _user = FirebaseAuth.instance.currentUser;
    _ordersStream = FirebaseFirestore.instance
        .collection('orderRequests')
        .where('userID', isEqualTo: _user?.uid)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _ordersStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            if (snapshot.data!.docs.isEmpty) {
              return Center(
                child: Text('No orders found.'),
              );
            }
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                var order = snapshot.data!.docs[index];
                Map<String, dynamic> data = order.data() as Map<String, dynamic>;
                return Card(
                  child: ListTile(
                    title: Text(data['productName']),
                    subtitle: Text('Price: ${data['productPrice']}'),
                    trailing: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => OrderDetailsScreen(orderData:data),
                          ),
                        );
                      },
                      child: Text('Details'),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
