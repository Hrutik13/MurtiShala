// import'package:flutter/material.dart';
// import 'package:idol_booking/admin_home.dart';
// import 'package:idol_booking/admin_profile.dart';
// import 'package:idol_booking/admin_customer.dart';
// import 'package:google_nav_bar/google_nav_bar.dart';
// import 'package:idol_booking/upload_product.dart';
//
// class Admin_Product extends StatefulWidget{
//   Admin_Product({super.key});
//   @override
//   _AdminProduct createState() => _AdminProduct();
// }
// class _AdminProduct extends State<Admin_Product>{
//   @override
//   void _press(){
//     Navigator.push(context, MaterialPageRoute(builder: (context)=> Upload_Product()));
//   }
//   Widget build(BuildContext context){
//     StreamBuilder<QuerySnapshot>(
//       stream: FirebaseFirestore.instance.collection('product').snapshots(),
//       builder: (context, snapshot) {
//         if (snapshot.hasError) {
//           return Center(child: Text('Error: ${snapshot.error}'));
//         }
//
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Center(child: CircularProgressIndicator());
//         }
//
//         List<DocumentSnapshot> products = snapshot.data!.docs;
//
//         return ListView.builder(
//           itemCount: products.length,
//           itemBuilder: (context, index) {
//             Map<String, dynamic> productData = products[index].data() as Map<String, dynamic>;
//             return ListTile(
//               leading: CircleAvatar(
//                 backgroundImage: NetworkImage(productData['imageUrl']),
//               ),
//               title: Text(productData['name']),
//               subtitle: Text(productData['description']),
//               onTap: () {
//                 // You can add navigation or further action here if needed
//               },
//             );
//           },
//         );
//       },
//     );
//   }
// }
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Your Products'),
//       ),
//       body: InkWell(
//         onTap: _press,
//         child: Container(
//           margin: EdgeInsets.only(right: 30,bottom: 30),
//           alignment: Alignment.bottomRight,
//           child: SizedBox(
//             height: 60,
//             width: 60,
//             child: Container(
//              decoration: BoxDecoration(color: Colors.lightBlue,borderRadius: BorderRadius.circular(50)),
//                 alignment: Alignment.bottomRight,
//                 child: Center(child: Icon(Icons.add,size: 30,color: Colors.white,)),
//                 ),
//           ),
//         ),
//       ),
//
//       bottomNavigationBar: BottomAppBar(
//               height: 80,
//               color: Colors.white,
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: [
//             IconButton(onPressed: (){
//               Navigator.push(context,MaterialPageRoute(builder: (context)=>Admin_Home()));
//             },
//               icon: Icon(Icons.home),
//             ),
//
//             IconButton(onPressed: (){
//               Navigator.push(context, MaterialPageRoute(builder: (context)=>Customers()));
//             },
//               icon: Icon(Icons.people_alt),
//             ),
//             IconButton(onPressed: (){},
//               icon: Icon(Icons.production_quantity_limits),
//             ),
//             IconButton(onPressed: (){
//               Navigator.push(context, MaterialPageRoute(builder: (context)=>Admin_Product()));
//             },
//               icon: Icon(Icons.add_a_photo),
//             ),
//             IconButton(onPressed: (){
//               Navigator.push(context, MaterialPageRoute(builder: (context)=>Admin_Profile()));
//             },
//               icon: Icon(Icons.account_circle),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'admin_customer.dart';
import 'admin_home.dart';
import 'admin_profile.dart';
import 'upload_product.dart';

class Admin_Product extends StatefulWidget {
  Admin_Product({Key? key}) : super(key: key);

  @override
  _AdminProductState createState() => _AdminProductState();
}

class _AdminProductState extends State<Admin_Product> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Products'),
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

          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              Map<String, dynamic> productData = products[index].data() as Map<String, dynamic>;

              // Check if imageUrl is not null before accessing it
              String? imageUrl = productData['imageUrl'] as String?;
              // Check if name is not null before accessing it
              String name = productData['name'] ?? '';
              // Check if description is not null before accessing it
              String description = productData['description'] ?? '';

              return ListTile(
                leading: CircleAvatar(
                  // Use a default image or display nothing if imageUrl is null
                  backgroundImage: imageUrl != null ? NetworkImage(imageUrl) as ImageProvider<Object>? : AssetImage('assets/default_image.jpg'),
                ),
                title: Text(name),
                subtitle: Text(description),
                onTap: () {
                  // You can add navigation or further action here if needed
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => Upload_Product()));
        },
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: BottomAppBar(
        height: 80,
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Admin_Home()));
              },
              icon: Icon(Icons.home),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Customers()));
              },
              icon: Icon(Icons.people_alt),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.production_quantity_limits),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Admin_Product()));
              },
              icon: Icon(Icons.add_a_photo),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Admin_Profile()));
              },
              icon: Icon(Icons.account_circle),
            ),
          ],
        ),
      ),
    );
  }
}
