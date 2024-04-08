// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
//
// import 'Homepage.dart';
// import 'main.dart';
//
// class Register extends StatefulWidget {
//   const Register({Key? key}) : super(key: key);
//
//   @override
//   _RegisterState createState() => _RegisterState();
// }
//
// class _RegisterState extends State<Register> {
//   final nameController = TextEditingController();
//   final passController = TextEditingController();
//   final emailController = TextEditingController();
//   final addController = TextEditingController();
//   final contController = TextEditingController();
//   final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
//
//   void createAccount() async {
//     String name = nameController.text.trim();
//     String password = passController.text.trim();
//     String email = emailController.text.trim();
//     String address = addController.text.trim();
//     String contact = contController.text.trim();
//
//     if (name == "" || password == "" || email == "" || address == "" || contact == "") {
//       Fluttertoast.showToast(msg: 'Enter valid inputs', gravity: ToastGravity.CENTER);
//       return;
//     }
//
//     try {
//       UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
//       Fluttertoast.showToast(msg: 'User created successfully', gravity: ToastGravity.CENTER);
//
//       // Retrieve FCM token
//       String? fcmToken = await _firebaseMessaging.getToken();
//
//       // Store user data in Firestore along with FCM token
//       await FirebaseFirestore.instance.collection('Users').add({
//         'name': name,
//         'email': email,
//         'password': password,
//         'address': address,
//         'contact': contact,
//         'fcmToken': fcmToken,
//       });
//
//       // Navigate to home page or next screen
//       Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
//     } on FirebaseAuthException catch (ex) {
//       Fluttertoast.showToast(msg: ex.code.toString(), gravity: ToastGravity.CENTER);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(),
//         body: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: SingleChildScrollView(
//             child: Column(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Container(
//                     decoration: BoxDecoration(),
//                     child: Text('Sign up', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: TextField(
//                     controller: nameController,
//                     decoration: InputDecoration(
//                       hintText: 'Name',
//                       focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.orange)),
//                       border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
//                       prefixIcon: Icon(Icons.person),
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: TextField(
//                     controller: passController,
//                     obscureText: true,
//                     decoration: InputDecoration(
//                       hintText: 'Password',
//                       focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.orange)),
//                       border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
//                       prefixIcon: Icon(Icons.password),
//                       suffixIcon: IconButton(onPressed: () {}, icon: Icon(Icons.remove_red_eye)),
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: TextField(
//                     controller: emailController,
//                     decoration: InputDecoration(
//                       hintText: 'Email',
//                       focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.orange)),
//                       border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
//                       prefixIcon: Icon(Icons.email),
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: TextField(
//                     controller: addController,
//                     decoration: InputDecoration(
//                       hintText: 'Address',
//                       focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.orange)),
//                       border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
//                       prefixIcon: Icon(Icons.location_on),
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: TextField(
//                     keyboardType: TextInputType.phone,
//                     controller: contController,
//                     decoration: InputDecoration(
//                       hintText: 'Contact no.',
//                       focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.orange)),
//                       border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
//                       prefixIcon: Icon(Icons.phone),
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(15),
//                   child: Container(
//                     width: 275,
//                     decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.amberAccent),
//                     child: TextButton(
//                       onPressed: createAccount,
//                       child: Text(
//                         'Submit',
//                         style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
//                       ),
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(left: 50, right: 50),
//                   child: Container(
//                     child: TextButton(
//                       onPressed: () {},
//                       child: Text('Sign up with Google'),
//                     ),
//                   ),
//                 ),
//                 Row(
//                   children: [
//                     Padding(
//                       padding: EdgeInsets.only(left: 85),
//                       child: SizedBox(child: Text("Already have an account?")),
//                     ),
//                     TextButton(
//                       onPressed: () {
//                         Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
//                       },
//                       child: const Text("Login"),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//


import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'Homepage.dart';
import 'login.dart';
import 'userHome.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final nameController = TextEditingController();
  final passController = TextEditingController();
  final emailController = TextEditingController();
  final addController = TextEditingController();
  final contController = TextEditingController();
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  bool _isObscured = true; // Flag to track password visibility


  void createAccount() async {
    String name = nameController.text.trim();
    String password = passController.text.trim();
    String email = emailController.text.trim();
    String address = addController.text.trim();
    String contact = contController.text.trim();

    if (name == "" || password == "" || email == "" || address == "" || contact == "") {
      Fluttertoast.showToast(msg: 'Enter valid inputs', gravity: ToastGravity.CENTER);
      return;
    }

    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
      Fluttertoast.showToast(msg: 'User created successfully', gravity: ToastGravity.CENTER);

      // Retrieve FCM token
      String? fcmToken = await _firebaseMessaging.getToken();

      // Store user data in Firestore along with FCM token
      await FirebaseFirestore.instance.collection('Users').doc(userCredential.user!.uid).set({
        'name': name,
        'email': email,
        'password': password,
        'address': address,
        'contact': contact,
        'userToken': fcmToken, // Store the FCM token as userToken
        'userId': userCredential.user!.uid, // Store userId
      });

      // Navigate to home page or next screen
      Navigator.push(context, MaterialPageRoute(builder: (context) => UserHome()));
    } on FirebaseAuthException catch (ex) {
      Fluttertoast.showToast(msg: ex.code.toString(), gravity: ToastGravity.CENTER);
    }
  }

  void togglePasswordVisibility() {
    setState(() {
      _isObscured = !_isObscured;
    });
  }

  // signInWithGoogle()async{
  //
  //   GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
  //   GoogleSignInAuthentication? gooleAuth = await googleUser?.authentication;
  //   AuthCredential credential= GoogleAuthProvider.credential(
  //     accessToken: gooleAuth?.accessToken,
  //     idToken: gooleAuth?.idToken,
  //
  //   );
  //   UserCredential userCredential= await FirebaseAuth.instance.signInWithCredential(credential);
  //   print(userCredential.user?.displayName);
  // }

  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      if (googleUser == null) {
        // User canceled sign-in process
        return;
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

      if (userCredential.additionalUserInfo?.isNewUser ?? false) {
        String name = userCredential.user?.displayName ?? "";
        String email = userCredential.user?.email ?? "";
        String userId = userCredential.user?.uid ?? "";

        await FirebaseFirestore.instance.collection('Users').doc(userId).set({
          'name': name,
          'email': email,
          'userId': userId,
        });

        Fluttertoast.showToast(msg: 'User signed up successfully', gravity: ToastGravity.CENTER);
      }

      Navigator.push(context, MaterialPageRoute(builder: (context) => UserHome()));
    } catch (error) {
      print("Error signing in with Google: $error");
      Fluttertoast.showToast(msg: 'Error signing in with Google', gravity: ToastGravity.CENTER);
    }
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(),
                    child: Text('Sign up', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      hintText: 'Name',
                      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.orange)),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      prefixIcon: Icon(Icons.person),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: passController,
                    obscureText: _isObscured,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.orange)),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      prefixIcon: Icon(Icons.password),
                      suffixIcon: IconButton(
                        onPressed: togglePasswordVisibility,
                        icon: Icon(_isObscured ? Icons.visibility : Icons.visibility_off),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      hintText: 'Email',
                      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.orange)),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      prefixIcon: Icon(Icons.email),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: addController,
                    decoration: InputDecoration(
                      hintText: 'Address',
                      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.orange)),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      prefixIcon: Icon(Icons.location_on),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    keyboardType: TextInputType.phone,
                    controller: contController,
                    decoration: InputDecoration(
                      hintText: 'Contact no.',
                      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.orange)),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      prefixIcon: Icon(Icons.phone),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Container(
                    width: 275,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.amberAccent),
                    child: TextButton(
                      onPressed: createAccount,
                      child: Text(
                        'Submit',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 50, right: 50),
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(EvaIcons.google),
                        TextButton(
                          onPressed:
                            signInWithGoogle,
                          child: Text('Sign up with Google'),
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 85),
                      child: SizedBox(child: Text("Already have an account?")),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
                      },
                      child: const Text("Login"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
