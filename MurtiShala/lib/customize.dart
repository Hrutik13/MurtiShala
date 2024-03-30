
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Customize extends StatefulWidget {
  Customize({Key? key}) : super(key: key);

  @override
  _CustomizeState createState() => _CustomizeState();
}

class _CustomizeState extends State<Customize> {
  File? _imageFile;
  TextEditingController _nameController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _pincodeController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _contactController = TextEditingController();

  Future<void> _pickImageFromGallery() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedImage != null) {
        _imageFile = File(pickedImage.path);
      } else {
        Fluttertoast.showToast(msg: 'No image selected.',gravity: ToastGravity.CENTER);
      }
    });
  }

  Future<String?> uploadImageToFirebaseStorage(File imageFile) async {
    try {
      String fileName = imageFile.path.split('/').last;
      Reference firebaseStorageRef =
      FirebaseStorage.instance.ref().child('images/$fileName');
      await firebaseStorageRef.putFile(imageFile);
      String imageUrl = await firebaseStorageRef.getDownloadURL();
      return imageUrl;
    } catch (e) {
      Fluttertoast.showToast(msg: 'Error uploading image to Firebase Storage: $e');
      return null;
    }
  }

  Future<void> storeImageAndDescriptionInFirestore(
      String imageUrl, String description,String name,String pincode, String address,String contact) async {
    try {
      // Get the current user
      User? user = FirebaseAuth.instance.currentUser;
      String? fcmToken = await FirebaseMessaging.instance.getToken();
      if (user != null) {
        // Store user information along with the image URL and description
        await FirebaseFirestore.instance.collection('images').add({
          'userId': user.uid, // User ID
          'name': name, // User name
          'userEmail': user.email ?? '', // User email
          'imageUrl': imageUrl,
          'description': description,
          'pincode': pincode,
          'address': address,
          'contact':contact,
          'userToken':fcmToken,
        });
        Fluttertoast.showToast(msg: 'Image and description stored successfully  ');
      } else {
        Fluttertoast.showToast(msg: 'No user signed in.');
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'Error storing image and description in Firestore: $e');
    }
  }

  Future<void> _submitForm() async {
    if (_imageFile == null) {
      Fluttertoast.showToast(msg: 'No image selected.');
      return;
    }

    String? imageUrl = await uploadImageToFirebaseStorage(_imageFile!);
    if (imageUrl != null) {
      String name = _nameController.text; // Get the user's name from the TextField
      String description = _descriptionController.text; // Get the description from the TextField
      String pincode =_pincodeController.text;
      String address = _addressController.text;
      String contact = _contactController.text;
      await storeImageAndDescriptionInFirestore(imageUrl, description,name,pincode ,address,contact);

      // Clear form fields and reset state
      _nameController.clear();
      _descriptionController.clear();
      _pincodeController.clear();
      _addressController.clear();
      _contactController.clear();
      setState(() {
        _imageFile = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text('Customizations'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 10),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      alignment: Alignment.topLeft,
                      child: Image.asset(
                        'assets/images/art-icon-1094.png',
                        height: 100,
                        width: 100,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        width: 250,
                        decoration: BoxDecoration(),
                        child: const Text(
                          'Make Your Own Customization',
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        )),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 30, right: 30, top: 8, bottom: 8),
              child: Container(
                child: TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    hintText: 'Enter your name *',
                    focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.orange)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8, left: 30, right: 30),
              child: Container(
                child: TextField(
                  controller: _descriptionController,
                  maxLines: 5,
                  decoration: InputDecoration(
                    hintText: 'Enter Description about Idol',
                    focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.orange)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8, left: 30, right: 30),
              child: Container(
                child: TextField(
                  controller: _addressController,
                  maxLines: 5,
                  decoration: InputDecoration(
                    hintText: 'Enter Delivery Address',
                    focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.orange)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 8, left: 30, right: 30),
              child: Container(
                child: TextField(
                  controller: _contactController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    hintText: 'Enter Your Contact No.',
                    focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.orange)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 8, left: 30, right: 30),
              child: Container(
                child: TextField(
                  controller: _pincodeController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Enter Your Pincode',
                    focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.orange)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: ElevatedButton(
                  onPressed: _pickImageFromGallery,
                  child: Text('Upload Image'),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 250,
                child: _imageFile != null
                    ? Image.file(_imageFile!)
                    : Text('No image selected.'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Container(
                width: 275,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.amberAccent,
                ),
                child: TextButton(
                  onPressed: _submitForm,
                  child: const Text(
                    'Submit',
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


