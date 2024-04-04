import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'payment_Info_details.dart';

class PaymentInfo extends StatelessWidget {
  PaymentInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Users payments'),
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: FirebaseFirestore.instance.collection('payments').get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            List<QueryDocumentSnapshot> paymentDocs = snapshot.data!.docs;
            return ListView.builder(
              itemCount: paymentDocs.length,
              itemBuilder: (context, index) {
                var paymentData = paymentDocs[index].data() as Map<String, dynamic>;
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  elevation: 4,
                  child: ListTile(
                    title: Text(
                      'Name: ${paymentData['userName']}',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),

                    trailing: Icon(Icons.payment, color: Colors.blue),
                    onTap: (){
                      Navigator.push(context,MaterialPageRoute(builder: (context)=>PaymentDetails(paymentData: paymentData)) );
                    },
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
