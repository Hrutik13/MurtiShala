

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:idol_booking/admin_upload.dart';
import 'package:idol_booking/orderRequests.dart';
import 'package:video_player/video_player.dart';
import 'package:idol_booking/admin_profile.dart';
import 'package:idol_booking/admin_customer.dart';
import 'payment_Info.dart';
import 'admin_feedback.dart';
import 'login.dart';


class Admin_Home extends StatefulWidget {
  Admin_Home({Key? key}) : super(key: key);

  @override
  _AdminHomeState createState() => _AdminHomeState();
}

class _AdminHomeState extends State<Admin_Home> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/videos/back_video.mp4')
      ..initialize().then((_) {
        setState(() {});
        _controller.play();
        _controller.setLooping(true);
        _controller.setVolume(0);
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
          title: Text(
            'MurtiShala',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          //shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(30)),
        actions: [
          IconButton(onPressed: (){
            logoutUser(context);
          }, icon: Icon(Icons.logout)),
        ],
        ),
      drawer: Drawer(
        width: 250,
        child: ListView(
          padding:EdgeInsets.all(8.0),
          children: <Widget>[
            DrawerHeader(
              child: Text(''),
            ),
            ListTile(
              title: Text('Payments'),
              leading: Icon(Icons.payment),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>PaymentInfo()));
              },
            ),
            ListTile(
              title: Text('Feedback'),
              leading: Icon(Icons.feedback),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>FeedbackScreen()));
              }
            ),
          ],
        ),
      ),
      body: Stack(
        children: <Widget>[
          SizedBox.expand(
            child: FittedBox(
              fit: BoxFit.cover,
              child: SizedBox(
                width: _controller.value.size.width,
                height: _controller.value.size.height,
                child: VideoPlayer(_controller),
              ),
            ),
          ),
          Container(
            color: Colors.black.withOpacity(0.5), // Adjust opacity as needed
          ),
          Container(
            alignment: Alignment.bottomCenter,
             padding: EdgeInsets.only(bottom: 220),
            child: Text(
                'Hello, Admin!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
          ),

          Container(
            alignment: Alignment.bottomCenter,
            padding: EdgeInsets.only(bottom: 150),
            child: Text('MurtiShala',style: TextStyle(
                fontSize: 55,
                color:Colors.white,
                fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
              ),
            ),
          ),
          BottomAppBar(
            height: 60,
            color: Colors.white.withOpacity(0),

            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(onPressed: (){
                  Navigator.push(context,MaterialPageRoute(builder: (context)=>Admin_Home()));
                },
                    icon: Icon(Icons.home),
                color: Colors.white,

                ),

                IconButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Customers()));
                },
                    icon: Icon(Icons.people_alt),
                  color: Colors.white,
                ),
                IconButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> OrderRequests()));
                },
                  icon: Icon(Icons.production_quantity_limits),
                  color: Colors.white,
                ),
                IconButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Admin_Product()));
                },
                  icon: Icon(Icons.add_a_photo),
                  color: Colors.white,
                ),
                IconButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Admin_Profile()));
                },
                  icon: Icon(Icons.account_circle),
                  color:Colors.white,
                ),
                // PopupMenuButton<String>(
                //   icon: Icon(Icons.more_vert,color: Colors.white,),
                //   iconSize: 30,
                //   offset: Offset(0,50),
                //   itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                //     PopupMenuItem<String>(
                //       value: 'Feedback',
                //       child: Row(
                //         children: [
                //           Expanded(
                //             child: Container(
                //               alignment: Alignment.topLeft,
                //               child: Text('Feedback', style: TextStyle(fontSize: 16)),
                //             ),
                //           ),
                //           Icon(Icons.feedback, size: 24),
                //         ],
                //       ),
                //     ),
                //   ],
                //   onSelected: (String value) {
                //     // Handle the selection of the Feedback option here
                //     if (value == 'Feedback') {
                //       // Handle Feedback option
                //       // For example, you can navigate to a feedback screen
                //       Navigator.push(context, MaterialPageRoute(builder: (context) => FeedbackScreen()));
                //     }
                //   },
                // ),
              ],
            ),
          )
          // Add other widgets here as needed
        ],
      ),
    );
  }
}
