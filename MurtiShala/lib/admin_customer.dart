
 import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:idol_booking/admin_profile.dart';
import 'package:idol_booking/admin_home.dart';
import 'package:idol_booking/admin_upload.dart';
import 'orderRequests.dart';

class Customers extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Data'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('Users').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No user data found'));
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var userData = snapshot.data!.docs[index].data() as Map<String, dynamic>;
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UserDetailsScreen(userData: userData),
                    ),
                  );
                },
                child: ListTile(

                  title:
                      Text('Name: ${userData['name'] ?? 'Name not available'}'),



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
            IconButton(onPressed: (){
              Navigator.push(context,MaterialPageRoute(builder: (context)=>Admin_Home()));
            },
              icon: Icon(Icons.home),
            ),

            IconButton(onPressed: (){},
              icon: Icon(Icons.people_alt),
            ),
            IconButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>OrderRequests()));
            },
              icon: Icon(Icons.production_quantity_limits),
            ),
            IconButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>Admin_Product()));
            },
              icon: Icon(Icons.add_a_photo),
            ),
            IconButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>Admin_Profile()));
            },
              icon: Icon(Icons.account_circle),
            ),
          ],
        ),
      ),
    );
  }
}

class UserDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> userData;

  const UserDetailsScreen({required this.userData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Details'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                enabled:false,
                decoration: InputDecoration(
                    label: Text('${userData['name']}', style: TextStyle(color: Colors.black),),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)
                    ),
                    prefixIcon: const Icon(Icons.person)
                ),
              ),
            ),
           // Text('Name: ${userData['name'] ?? 'Name not available'}'),
            //SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                enabled:false,
                decoration: InputDecoration(
                    label: Text('${userData['email']}', style: TextStyle(color: Colors.black),),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)
                    ),
                    prefixIcon: const Icon(Icons.email)
                ),
              ),
            ),
            //Text('Email: ${userData['email'] ?? 'Email not available'}'),
            //SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                enabled:false,
                decoration: InputDecoration(
                    label: Text('${userData['contact']}', style: TextStyle(color: Colors.black),),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)
                    ),
                    prefixIcon: const Icon(Icons.phone)
                ),
              ),
            ),
           // Text('Contact: ${userData['contact'] ?? 'Contact not available'}'),
            //izedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                enabled:false,
                maxLines: 3,
                decoration: InputDecoration(
                    label: Text('${userData['address']}', style: TextStyle(color: Colors.black),),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)
                    ),
                    prefixIcon: const Icon(Icons.location_on)
                ),
              ),
            ),
            //Text('Address: ${userData['address'] ?? 'Address not available'}'),
          ],
        ),
      ),
    );
  }
}
