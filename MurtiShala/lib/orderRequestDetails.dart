import 'package:flutter/material.dart';

class OrderDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> orderData;

  const OrderDetailsScreen({Key? key, required this.orderData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Details'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                alignment: Alignment.topCenter,
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  'User Details',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
                ),
              ),
            ),
            SizedBox(height: 8),
            _buildDetailItem('User Id:', orderData['userID'] ?? 'Unknown'),
            _buildDetailItem('Name:', orderData['name'] ?? 'Not provided'),
            _buildDetailItem('Email:', orderData['email'] ?? 'Not provided'),
            _buildDetailItem('Address:', orderData['address'] ?? 'Not provided'),
            _buildDetailItem('Contact:', orderData['contact'] ?? 'Not provided'),
            //_buildDetailItem('User ID:', orderData['userID'] ?? 'Not provided'),
            _buildDetailItem('Pincode:', orderData['pincode'] ?? 'Not provided'),
            SizedBox(height: 25),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                alignment: Alignment.topCenter,
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  'Product Details',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
                ),
              ),
            ),
            SizedBox(height: 8),
            _buildDetailItem('Product ID:', orderData['productId'] ?? 'Not provided'),
            _buildDetailItem('Product Name:', orderData['productName'] ?? 'Not provided'),
            _buildDetailItem('Description:', orderData['productDescription'] ?? 'Not provided'),
            _buildDetailItem('Height:', orderData['height'] ?? 'Not provided'),
            _buildDetailItem('Price:', orderData['productPrice'] ?? 'Not provided'),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blueGrey),
                  borderRadius: BorderRadius.circular(10),
                ),
                height: 200, // Adjust the height as needed
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.network(
                      orderData['image'] ?? '',
                      fit: BoxFit.cover,
                      loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) {
                          return child;
                        } else {
                          return CircularProgressIndicator();
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              value,
              style: TextStyle(color: Colors.grey.shade700),
            ),
          ),
        ],
      ),
    );
  }
}
