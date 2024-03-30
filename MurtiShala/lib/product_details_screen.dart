import 'package:flutter/material.dart';
import 'order.dart';

class ProductDetailsScreen extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String description;
  final String price;
  final String height;
  final String productId;// New field to store product ID
  //final String fcmToken;

  ProductDetailsScreen({
    required this.imageUrl,
    required this.name,
    required this.description,
    required this.price,
    required this.height,
    required this.productId, // Include productId in the constructor
    //required this. fcmToken,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Details'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.network(imageUrl),
            ),
            SizedBox(height: 20),
            Text(
              name,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text('About: ${description}'),
            SizedBox(height: 20),

            Text(
              'Price:${price}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 20),
            Text(
              'Height:${height}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

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
                    // Navigate to Order screen and pass the productId
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Order(productId: productId,
                          imageUrl: imageUrl,productDescription: description,productName: name
                          ,height: height,price: price, ),
                      ),
                    );
                  },
                  child: const Text(
                    'Order',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
