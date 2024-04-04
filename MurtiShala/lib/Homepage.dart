// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:idol_booking/product_details_screen.dart';
// import 'package:idol_booking/profile.dart';
// import 'package:idol_booking/userHome.dart';
// import 'customize.dart';
// import 'feedback.dart';
// import 'login.dart';
// import 'notification.dart';
//
// class HomePage extends StatelessWidget {
//
//   void logoutUser(BuildContext context) async {
//     try {
//       // Sign out the user from Firebase Authentication
//       await FirebaseAuth.instance.signOut();
//
//       // Navigate to the login screen
//       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login()));
//     } catch (e) {
//       // Handle any errors that occur during sign out
//       print ("Error signing out: $e");
//       Fluttertoast.showToast(msg: "Error signing out: $e");
//       // Optionally, show an error message to the user
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: PreferredSize(
//         preferredSize: const Size.fromHeight(60),
//         child: AppBar(
//           title: Text('MurtiShala', textAlign: TextAlign.justify),
//           backgroundColor: Colors.lightBlue.shade50,
//           centerTitle: true,
//           actions: [
//             IconButton(onPressed: (){
//               logoutUser(context);
//             }, icon: Icon(Icons.logout)),
//           ],
//         ),
//       ),
//       body: StreamBuilder<QuerySnapshot>(
//         stream: FirebaseFirestore.instance.collection('product').snapshots(),
//         builder: (context, snapshot) {
//           if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           }
//
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           }
//
//           List<DocumentSnapshot> products = snapshot.data!.docs;
//
//           return GridView.builder(
//             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 2, // Number of grid columns
//               crossAxisSpacing: 10, // Spacing between columns
//               mainAxisSpacing: 10, // Spacing between rows
//             ),
//             itemCount: products.length,
//             itemBuilder: (context, index) {
//               Map<String, dynamic> productData = products[index].data() as Map<String, dynamic>;
//
//               // Extract product details
//               String imageUrl = productData['imageUrl'] ?? '';
//               String name = productData['name'] ?? '';
//               String description = productData['description'] ?? '';
//               String price = productData['Price'] ?? '';
//               String height = productData['Height'] ?? '';
//
//               return GestureDetector(
//                 onTap: () {
//                   showDialog(
//                     context: context,
//                     builder: (_) => AlertDialog(
//                       content: Image.network(imageUrl), // Show full image in dialog
//                       actions: [
//                         ElevatedButton(
//                           onPressed: () {
//                             Navigator.pop(context); // Close the dialog
//                           },
//                           child: Text('Close'),
//                         ),
//                         ElevatedButton(
//                           onPressed: () {
//                             Navigator.pop(context); // Close the dialog
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => ProductDetailsScreen(
//                                   imageUrl: imageUrl,
//                                   name: name,
//                                   description: description,
//                                   price: price,
//                                   height: height,
//                                   productId: products[index].id,
//                                 ),
//                               ),
//                             );
//                           },
//                           child: Text('View Details'),
//                         ),
//                       ],
//                     ),
//                   );
//                 },
//                 child: Card(
//                   elevation: 5,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Expanded(
//                         child: Container(
//                           decoration: BoxDecoration(
//                             image: DecorationImage(
//                               image: NetworkImage(imageUrl)!, // Use null-aware operator to assert non-null
//                               fit: BoxFit.cover,
//                             ),
//                           ),
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               name,
//                               style: TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 16,
//                               ),
//                             ),
//                             SizedBox(height: 0.5),
//                             Text(
//                               description,
//                               style: TextStyle(
//                                 fontSize: 14,
//                               ),
//                             ),
//                             SizedBox(height: 8),
//                             Align(
//                               alignment: Alignment.center,
//                               child: ElevatedButton(
//                                 onPressed: () {
//                                   // Handle order button tap
//                                   Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                       builder: (context) => ProductDetailsScreen(
//                                         imageUrl: imageUrl,
//                                         name: name,
//                                         description: description,
//                                         price: price,
//                                         height: height,
//                                         productId: products[index].id,
//                                       ),
//                                     ),
//                                   );
//                                 },
//                                 child: Text('Order'),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//       bottomNavigationBar: BottomAppBar(
//         shadowColor: Colors.black,
//         height: 70,
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: [
//             IconButton(onPressed: (){
//               Navigator.push(context, MaterialPageRoute(builder: (context)=>UserHome()));
//             },
//                 icon: Icon(Icons.home)
//             ),
//             IconButton(
//               onPressed: () {
//                 Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
//               },
//               icon: Icon(Icons.shopping_cart_outlined),
//               iconSize: 26,
//               tooltip: "home",
//             ),
//             IconButton(
//               onPressed: () {
//                 Navigator.push(context, MaterialPageRoute(builder: (context) => Customize()));
//               },
//               icon: Icon(Icons.dashboard_customize_rounded),
//               iconSize: 26,
//             ),
//             IconButton(
//               onPressed: () {
//                 Navigator.push(context, MaterialPageRoute(builder: (context)=> NotificationScreenPage()));
//               },
//               icon: Icon(Icons.list_alt),
//               iconSize: 26,
//             ),
//             IconButton(
//               onPressed: () {
//                 Navigator.push(context, MaterialPageRoute(builder: (context) => Profile()));
//               },
//               icon: Icon(Icons.account_circle),
//               iconSize: 26,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:idol_booking/product_details_screen.dart';
import 'package:idol_booking/profile.dart';
import 'package:idol_booking/userHome.dart';
import 'customize.dart';
import 'login.dart';
import 'notification.dart';

class ProductDialog extends StatefulWidget {
  final String imageUrl;
  final String name;
  final String description;
  final String price;
  final String height;
  final String productId;

  const ProductDialog({
    Key? key,
    required this.imageUrl,
    required this.name,
    required this.description,
    required this.price,
    required this.height,
    required this.productId,
  }) : super(key: key);

  @override
  _ProductDialogState createState() => _ProductDialogState();
}

class _ProductDialogState extends State<ProductDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Image.network(widget.imageUrl),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context); // Close the dialog
          },
          child: Text('Close'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context); // Close the dialog
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductDetailsScreen(
                  imageUrl: widget.imageUrl,
                  name: widget.name,
                  description: widget.description,
                  price: widget.price,
                  height: widget.height,
                  productId: widget.productId,
                ),
              ),
            );
          },
          child: Text('View Details'),
        ),
      ],
    );
  }
}

class HomePage extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void logoutUser(BuildContext context) async {
    try {
      // Sign out the user from Firebase Authentication
      await FirebaseAuth.instance.signOut();

      // Navigate to the login screen
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login()));
    } catch (e) {
      // Handle any errors that occur during sign out
      print ("Error signing out: $e");
      Fluttertoast.showToast(msg: "Error signing out: $e");
      // Optionally, show an error message to the user
    }
  }

  void _showDialog(BuildContext context, String imageUrl, String name, String description, String price, String height, String productId) {
    showDialog(
      context: context,
      builder: (_) => ProductDialog(
        imageUrl: imageUrl,
        name: name,
        description: description,
        price: price,
        height: height,
        productId: productId,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          title: Text('MurtiShala', textAlign: TextAlign.justify),
          backgroundColor: Colors.lightBlue.shade50,
          centerTitle: true,
          actions: [
            IconButton(onPressed: (){
              logoutUser(context);
            }, icon: Icon(Icons.logout)),
          ],
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('product').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          List<DocumentSnapshot> products = snapshot.data!.docs;

          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // Number of grid columns
              crossAxisSpacing: 10, // Spacing between columns
              mainAxisSpacing: 10, // Spacing between rows
            ),
            itemCount: products.length,
            itemBuilder: (context, index) {
              Map<String, dynamic> productData = products[index].data() as Map<String, dynamic>;

              // Extract product details
              String imageUrl = productData['imageUrl'] ?? '';
              String name = productData['name'] ?? '';
              String description = productData['description'] ?? '';
              String price = productData['Price'] ?? '';
              String height = productData['Height'] ?? '';

              return GestureDetector(
                onTap: () {
                  _showDialog(
                    context,
                    imageUrl,
                    name,
                    description,
                    price,
                    height,
                    products[index].id,
                  );
                },
                child: Card(
                  elevation: 5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            image: imageUrl != null
                                ? DecorationImage(
                              image: NetworkImage(imageUrl),
                              fit: BoxFit.cover,
                            )
                                : null,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              name,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(height: 0.5),
                            Text(
                              price,
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                            SizedBox(height: 8),
                            Align(
                              alignment: Alignment.center,
                              child: ElevatedButton(
                                onPressed: () {
                                  // Handle order button tap
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ProductDetailsScreen(
                                        imageUrl: imageUrl,
                                        name: name,
                                        description: description,
                                        price: price,
                                        height: height,
                                        productId: products[index].id,
                                      ),
                                    ),
                                  );
                                },
                                child: Text('Order'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        shadowColor: Colors.black,
        height: 70,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>UserHome()));
            },
                icon: Icon(Icons.home)
            ),
            IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
              },
              icon: Icon(Icons.shopping_cart_outlined),
              iconSize: 26,
              tooltip: "home",
            ),
            IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Customize()));
              },
              icon: Icon(Icons.dashboard_customize_rounded),
              iconSize: 26,
            ),
            IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=> NotificationScreenPage()));
              },
              icon: Icon(Icons.notification_important),
              iconSize: 26,
            ),
            IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Profile()));
              },
              icon: Icon(Icons.account_circle),
              iconSize: 26,
            ),
          ],
        ),
      ),
    );
  }
}
