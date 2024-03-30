//
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:idol_booking/admin_home.dart';
// import 'package:idol_booking/register.dart';
// import 'userHome.dart';
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(const Login());
// }
//
// class Login extends StatelessWidget {
//   const Login({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Murtishala',
//       theme: ThemeData(useMaterial3: true),
//       home: LoginPage(),
//     );
//   }
// }
//
// class LoginPage extends StatefulWidget {
//   const LoginPage({Key? key}) : super(key: key);
//
//   @override
//   _LoginPageState createState() => _LoginPageState();
// }
//
// class _LoginPageState extends State<LoginPage> {
//   TextEditingController emailcontroller = TextEditingController();
//   TextEditingController passcontroller = TextEditingController();
//
//   bool _isObscured = true; // Flag to track password visibility
//
//   void login() async {
//     String email = emailcontroller.text.trim();
//     String password = passcontroller.text.trim();
//
//     if (email == "" || password == "") {
//       Fluttertoast.showToast(msg: 'Please fill all the fields', gravity: ToastGravity.CENTER);
//     } else {
//       try {
//         UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
//         var adminQuery = await FirebaseFirestore.instance.collection('admin').where('email', isEqualTo: email).get();
//
//         if (adminQuery.docs.isNotEmpty) {
//           Fluttertoast.showToast(msg: 'Admin Login Successfully', gravity: ToastGravity.CENTER);
//           Navigator.push(context, MaterialPageRoute(builder: (context) => Admin_Home()));
//         } else {
//           Fluttertoast.showToast(msg: 'User Login Successfully', gravity: ToastGravity.CENTER);
//           Navigator.push(context, MaterialPageRoute(builder: (context) => UserHome()));
//         }
//       } on FirebaseAuthException catch (ex) {
//         Fluttertoast.showToast(msg: ex.code.toString(), gravity: ToastGravity.CENTER);
//       }
//     }
//   }
//
//   void togglePasswordVisibility() {
//     setState(() {
//       _isObscured = !_isObscured;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(''),
//       ),
//       body: Center(
//         child: Card(
//           child: Center(
//             child: SizedBox(
//               height: 400,
//               width: 300,
//               child: SingleChildScrollView(
//                 child: Column(
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Container(
//                         alignment: Alignment.topLeft,
//                         child: const Text(
//                           'LOGIN',
//                           style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
//                         ),
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: TextField(
//                         controller: emailcontroller,
//                         decoration: InputDecoration(
//                           hintText: "Email",
//                           focusedBorder: const OutlineInputBorder(
//                             borderSide: BorderSide(color: Colors.orangeAccent),
//                           ),
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                           prefixIcon: const Icon(Icons.email),
//                         ),
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: TextField(
//                         controller: passcontroller,
//                         obscureText: _isObscured,
//                         decoration: InputDecoration(
//                           hintText: "Password",
//                           focusedBorder: const OutlineInputBorder(
//                             borderSide: BorderSide(color: Colors.orangeAccent),
//                           ),
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                           prefixIcon: const Icon(Icons.password),
//                           suffixIcon: IconButton(
//                             onPressed: togglePasswordVisibility,
//                             icon: Icon(_isObscured ? Icons.visibility : Icons.visibility_off),
//                           ),
//                         ),
//                       ),
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Container(
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(10),
//                               color: Colors.lightBlueAccent,
//                             ),
//                             alignment: Alignment.center,
//                             width: 275,
//                             child: TextButton(
//                               onPressed: () {
//                                 CircularProgressIndicator();
//                                 login();
//                               },
//                               child: const Text(
//                                 'Sign in ',
//                                 style: TextStyle(fontSize: 18),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                     Container(
//                       width: 275,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(10),
//                         color: Colors.amberAccent,
//                       ),
//                       child: TextButton(
//                         onPressed: () {
//                           Navigator.push(context, MaterialPageRoute(builder: (context) => Register()));
//                         },
//                         child: const Text(
//                           'Sign up',
//                           style: TextStyle(fontWeight: FontWeight.bold),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'login.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const MaterialApp(
        debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Login(),
      ),
    ),
  );
}
