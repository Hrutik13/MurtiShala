import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'customizeOrderReq_Details.dart';
import 'orderRequestDetails.dart';

class MyCustomizeOrderPage extends StatefulWidget {
  @override
  _MyCusto_orderPageState createState() => _MyCusto_orderPageState();
}

class _MyCusto_orderPageState extends State<MyCustomizeOrderPage> {
  late User? _user;
  late Stream<QuerySnapshot> _ordersStream;

  @override
  void initState() {
    super.initState();
    _user = FirebaseAuth.instance.currentUser;
    _ordersStream = FirebaseFirestore.instance
        .collection('images')
        .where('userId', isEqualTo: _user?.uid)
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
                Map<String, dynamic> data =
                order.data() as Map<String, dynamic>;
                String productName =
                    data['name'] ?? 'Name Not Available';
                String productPrice =
                    data['productPrice'] ?? 'Product Price Not Available';
               // String time= data['timeStamp']?? 'not available';
                return Card(
                  child: ListTile(
                    title: Text(productName),
                    subtitle: Text('Price: $productPrice'),
                    trailing: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CutomizeOrderReq_DetailsScreen(requestData: data)
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
