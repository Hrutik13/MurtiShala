//
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:fluttertoast/fluttertoast.dart';
//
// class Upload_Product extends StatefulWidget {
//   Upload_Product({Key? key}) : super(key: key);
//
//   @override
//   _UploadProductState createState() => _UploadProductState();
// }
//
// class _UploadProductState extends State<Upload_Product> {
//   File? _imageFile;
//   TextEditingController _nameController = TextEditingController();
//   TextEditingController _descriptionController = TextEditingController();
//   TextEditingController _typeController =TextEditingController();
//   TextEditingController _heightController = TextEditingController();
//   TextEditingController _priceController = TextEditingController();
//
//   Future<void> _pickImageFromGallery() async {
//     final picker = ImagePicker();
//     final pickedImage =
//     await picker.pickImage(source: ImageSource.gallery);
//
//     setState(() {
//       if (pickedImage != null) {
//         _imageFile = File(pickedImage.path);
//       } else {
//         Fluttertoast.showToast(msg: 'No image selected.',gravity: ToastGravity.CENTER);
//       }
//     });
//   }
//
//   Future<String?> uploadImageToFirebaseStorage(File imageFile) async {
//     try {
//       String fileName = imageFile.path.split('/').last;
//       Reference firebaseStorageRef =
//       FirebaseStorage.instance.ref().child('product/$fileName');
//       await firebaseStorageRef.putFile(imageFile);
//       String imageUrl = await firebaseStorageRef.getDownloadURL();
//       return imageUrl;
//     } catch (e) {
//       Fluttertoast.showToast(msg: 'Error uploading image to Firebase Storage: $e');
//       return null;
//     }
//   }
//
//   Future<void> storeImageAndDescriptionInFirestore(
//       String imageUrl, String description,String name,String type,String height,String price) async {
//     try {
//       // Get the current user
//       User? user = FirebaseAuth.instance.currentUser;
//       if (user != null) {
//         // Store user information along with the image URL and description
//         await FirebaseFirestore.instance.collection('product').add({
//           'userId': user.uid, // User ID
//           'name': name, // User name
//           'userEmail': user.email ?? '', // User email
//           'imageUrl': imageUrl,
//           'description': description,
//           'Type':type,
//           'Height':height,
//           'Price':price,
//         });
//         Fluttertoast.showToast(msg: 'Image and description stored successfully  ');
//       } else {
//         Fluttertoast.showToast(msg: 'No user signed in.');
//       }
//     } catch (e) {
//       Fluttertoast.showToast(msg: 'Error storing image and description in Firestore: $e');
//     }
//   }
//
//   Future<void> _submitForm() async {
//     if (_imageFile == null) {
//       Fluttertoast.showToast(msg: 'No image selected.');
//       return;
//     }
//
//     String? imageUrl = await uploadImageToFirebaseStorage(_imageFile!);
//     if (imageUrl != null) {
//       String name = _nameController.text; // Get the user's name from the TextField
//       String description = _descriptionController.text; // Get the description from the TextField
//       await storeImageAndDescriptionInFirestore(imageUrl, description,name,price,height,type);
//
//       // Clear form fields and reset state
//       _nameController.clear();
//       _descriptionController.clear();
//       _typeController.clear();
//       _priceController.clear();
//       _heightController.clear();
//       setState(() {
//         _imageFile = null;
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back),
//           onPressed: () {
//             Navigator.of(context).pop();
//           },
//         ),
//         title: Text('Customizations'),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.only(top: 20, left: 10),
//               child: Row(
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Container(
//                       alignment: Alignment.topLeft,
//                       child: Image.asset(
//                         'assets/images/art-icon-1094.png',
//                         height: 100,
//                         width: 100,
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Container(
//                         width: 250,
//                         decoration: BoxDecoration(),
//                         child: const Text(
//                           'Make Your Own Customization',
//                           style: TextStyle(
//                               fontSize: 30, fontWeight: FontWeight.bold),
//                         )),
//                   ),
//                 ],
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(
//                   left: 30, right: 30, top: 8, bottom: 8),
//               child: Container(
//                 child: TextField(
//                   controller: _nameController,
//                   decoration: InputDecoration(
//                     hintText: ' title',
//                     focusedBorder: const OutlineInputBorder(
//                         borderSide: BorderSide(color: Colors.orange)),
//                     border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(10)),
//                   ),
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(top: 8, left: 30, right: 30),
//               child: Container(
//                 child: TextField(
//                   controller: _descriptionController,
//                   maxLines: 5,
//                   decoration: InputDecoration(
//                     hintText: 'Enter Description about Idol',
//                     focusedBorder: const OutlineInputBorder(
//                         borderSide: BorderSide(color: Colors.orange)),
//                     border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(10)),
//                   ),
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(
//                   left: 30, right: 30, top: 8, bottom: 8),
//               child: Container(
//                 child: TextField(
//                   controller: _typeController,
//                   decoration: InputDecoration(
//                     hintText: 'Enter sculpture type',
//                     focusedBorder: const OutlineInputBorder(
//                         borderSide: BorderSide(color: Colors.orange)),
//                     border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(10)),
//                   ),
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(
//                   left: 30, right: 30, top: 8, bottom: 8),
//               child: Container(
//                 child: TextField(
//                   controller: _heightController,
//                   decoration: InputDecoration(
//                     hintText: 'Enter height of sculpture',
//                     focusedBorder: const OutlineInputBorder(
//                         borderSide: BorderSide(color: Colors.orange)),
//                     border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(10)),
//                   ),
//                 ),
//               ),
//             ),
//
//             Padding(
//               padding: const EdgeInsets.only(
//                   left: 30, right: 30, top: 8, bottom: 8),
//               child: Container(
//                 child: TextField(
//                   controller: _priceController,
//                   decoration: InputDecoration(
//                     hintText: 'Enter price ',
//                     focusedBorder: const OutlineInputBorder(
//                         borderSide: BorderSide(color: Colors.orange)),
//                     border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(10)),
//                   ),
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Container(
//                 child: ElevatedButton(
//                   onPressed: _pickImageFromGallery,
//                   child: Text('Upload Image'),
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Container(
//                 height: 250,
//                 child: _imageFile != null
//                     ? Image.file(_imageFile!)
//                     : Text('No image selected.'),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(15),
//               child: Container(
//                 width: 275,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(10),
//                   color: Colors.amberAccent,
//                 ),
//                 child: TextButton(
//                   onPressed: _submitForm,
//                   child: const Text(
//                     'Upload',
//                     style: TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Upload_Product extends StatefulWidget {
  Upload_Product({Key? key}) : super(key: key);

  @override
  _UploadProductState createState() => _UploadProductState();
}

class _UploadProductState extends State<Upload_Product> {
  File? _imageFile;
  TextEditingController _nameController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _typeController = TextEditingController();
  TextEditingController _heightController = TextEditingController();
  TextEditingController _priceController = TextEditingController();

  Future<void> _pickImageFromGallery() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedImage != null) {
        _imageFile = File(pickedImage.path);
      } else {
        Fluttertoast.showToast(msg: 'No image selected.', gravity: ToastGravity.CENTER);
      }
    });
  }

  Future<String?> uploadImageToFirebaseStorage(File imageFile) async {
    try {
      String fileName = imageFile.path.split('/').last;
      Reference firebaseStorageRef =
      FirebaseStorage.instance.ref().child('product/$fileName');
      await firebaseStorageRef.putFile(imageFile);
      String imageUrl = await firebaseStorageRef.getDownloadURL();
      return imageUrl;
    } catch (e) {
      Fluttertoast.showToast(
          msg: 'Error uploading image to Firebase Storage: $e');
      return null;
    }
  }

  Future<void> storeImageAndDescriptionInFirestore(
      String imageUrl, String description, String name, String type,
      String height, String price) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await FirebaseFirestore.instance.collection('product').add({
          'userId': user.uid,
          'name': name,
          'userEmail': user.email ?? '',
          'imageUrl': imageUrl,
          'description': description,
          'Type': type,
          'Height': height,
          'Price': price,
        });
        Fluttertoast.showToast(msg: 'Image and description stored successfully');
      } else {
        Fluttertoast.showToast(msg: 'No user signed in.');
      }
    } catch (e) {
      Fluttertoast.showToast(
          msg: 'Error storing image and description in Firestore: $e');
    }
  }

  Future<void> _submitForm() async {
    if (_imageFile == null) {
      Fluttertoast.showToast(msg: 'No image selected.');
      return;
    }

    String? imageUrl = await uploadImageToFirebaseStorage(_imageFile!);
    if (imageUrl != null) {
      String name = _nameController.text;
      String description = _descriptionController.text;
      String type = _typeController.text;
      String height = _heightController.text;
      String price = _priceController.text;
      await storeImageAndDescriptionInFirestore(
          imageUrl, description, name, type, height, price);

      _nameController.clear();
      _descriptionController.clear();
      _typeController.clear();
      _heightController.clear();
      _priceController.clear();
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
        title: Text('Upload'),
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
                          'Upload Your Master Piece',
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        )),
                  ),
                ],
              ),
            ),
            Padding(
              padding:
              const EdgeInsets.only(left: 30, right: 30, top: 8, bottom: 8),
              child: Container(
                child: TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    hintText: ' title',
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
              padding:
              const EdgeInsets.only(left: 30, right: 30, top: 8, bottom: 8),
              child: Container(
                child: TextField(
                  controller: _typeController,
                  decoration: InputDecoration(
                    hintText: 'Enter sculpture type',
                    focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.orange)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ),
            ),
            Padding(
              padding:
              const EdgeInsets.only(left: 30, right: 30, top: 8, bottom: 8),
              child: Container(
                child: TextField(
                  controller: _heightController,
                  decoration: InputDecoration(
                    hintText: 'Enter height of sculpture',
                    focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.orange)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ),
            ),
            Padding(
              padding:
              const EdgeInsets.only(left: 30, right: 30, top: 8, bottom: 8),
              child: Container(
                child: TextField(
                  controller: _priceController,
                  decoration: InputDecoration(
                    hintText: 'Enter price ',
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
                    'Upload',
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

