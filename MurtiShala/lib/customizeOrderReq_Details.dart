import 'package:flutter/material.dart';

class CutomizeOrderReq_DetailsScreen extends StatelessWidget {
  final Map<String, dynamic> requestData;

  const CutomizeOrderReq_DetailsScreen({required this.requestData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Request Details'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailRow('User ID', requestData['userId'] ?? 'Name not available'),
            SizedBox(height: 10),
            _buildDetailRow('Name', requestData['name'] ?? 'Description not available'),
            SizedBox(height: 10),
            _buildDetailRow('Email', requestData['userEmail'] ?? 'Description not available'),
            SizedBox(height: 10),
            _buildDetailRow('Address', requestData['address'] ?? 'Description not available'),
            SizedBox(height: 10),
            _buildDetailRow('Contact', requestData['contact'] ?? 'Description not available'),
            SizedBox(height: 10),
            _buildDetailRow('Description', requestData['description'] ?? 'Description not available'),
            SizedBox(height: 10),
            _buildDetailRow('Pincode', requestData['pincode'] ?? 'Description not available'),
            SizedBox(height: 10),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blueGrey), // Added border decoration
                  borderRadius: BorderRadius.circular(10),
                ),
                height: 200, // Adjust the height as needed
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.network(
                      requestData['imageUrl'] ?? '',
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
            // Add more details as needed
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('$label: ', style: TextStyle(fontWeight: FontWeight.bold)),
        Expanded(
          child: Text(
            value,
            style: TextStyle(color: Colors.grey[700]),
          ),
        ),
      ],
    );
  }
}
