
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:idol_booking/admin_home.dart';
import 'package:idol_booking/register.dart';
import 'userHome.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Murtishala',
      theme: ThemeData(useMaterial3: true),
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passcontroller = TextEditingController();

  bool _isObscured = true; // Flag to track password visibility
  bool _isLoading = false;

  void login() async {
    String email = emailcontroller.text.trim();
    String password = passcontroller.text.trim();

    if (email == "" || password == "") {
      Fluttertoast.showToast(msg: 'Please fill all the fields', gravity: ToastGravity.CENTER);
    } else {
      setState(() {
        _isLoading= true;
      });
      try {
        UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
        var adminQuery = await FirebaseFirestore.instance.collection('admin').where('email', isEqualTo: email).get();

        if (adminQuery.docs.isNotEmpty) {
          Fluttertoast.showToast(msg: 'Admin Login Successfully', gravity: ToastGravity.CENTER);
          Navigator.push(context, MaterialPageRoute(builder: (context) => Admin_Home()));
        } else {
          Fluttertoast.showToast(msg: 'User Login Successfully', gravity: ToastGravity.CENTER);
          Navigator.push(context, MaterialPageRoute(builder: (context) => UserHome()));
        }
      } on FirebaseAuthException catch (ex) {
        Fluttertoast.showToast(msg: ex.code.toString(), gravity: ToastGravity.CENTER);
      }
      finally{
        setState(() {
          _isLoading= false;
        });
      }
    }
  }

  void togglePasswordVisibility() {
    setState(() {
      _isObscured = !_isObscured;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: Center(
            child: SizedBox(
              height: 400,
              width: 300,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        alignment: Alignment.topLeft,
                        child: const Text(
                          'LOGIN',
                          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: emailcontroller,
                        decoration: InputDecoration(
                          hintText: "Email",
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.orangeAccent),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          prefixIcon: const Icon(Icons.email),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: passcontroller,
                        obscureText: _isObscured,
                        decoration: InputDecoration(
                          hintText: "Password",
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.orangeAccent),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          prefixIcon: const Icon(Icons.password),
                          suffixIcon: IconButton(
                            onPressed: togglePasswordVisibility,
                            icon: Icon(_isObscured ? Icons.visibility : Icons.visibility_off),
                          ),
                        ),
                      ),
                    ),

                    Container(
                      width: 275,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.lightBlueAccent,
                      ),
                      child: TextButton(
                        onPressed: () {
                          login();
                        },
                        child: _isLoading
                            ? CircularProgressIndicator() // Show CircularProgressIndicator if loading
                            : const Text(
                          'Sign in',
                          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),

                    Container(
                      width: 275,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.amberAccent,
                      ),
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Register()));
                        },
                        child: const Text(
                          'Sign up',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

    );
  }
}
