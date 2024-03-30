// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:idol_booking/profile.dart';
// import 'package:video_player/video_player.dart';
// import 'Homepage.dart';
// import 'feedback.dart';
// import 'customize.dart';
// import 'login.dart';
// import 'notification.dart';
// import 'package:url_launcher/url_launcher.dart';
//
// class UserHome extends StatefulWidget {
//   UserHome({Key? key}) : super(key: key);
//
//   @override
//   _UserHomeState createState() => _UserHomeState();
// }
//
// class _UserHomeState extends State<UserHome> {
//   late VideoPlayerController _controller;
//   var name = FirebaseAuth.instance.currentUser;
//   @override
//   void initState() {
//     super.initState();
//     _controller = VideoPlayerController.asset('assets/videos/back_video.mp4')
//       ..initialize().then((_) {
//         setState(() {});
//         _controller.play();
//         _controller.setLooping(true);
//         _controller.setVolume(0);
//       });
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
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
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar:  AppBar(
//         backgroundColor: Colors.lightBlue.shade50,
//         title: Text(
//           'MurtiShala',
//           style: TextStyle(
//             fontSize: 25,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         centerTitle: true,
//         automaticallyImplyLeading: false,
//         actions: [
//           IconButton(onPressed: (){
//             logoutUser(context);
//           }, icon: Icon(Icons.logout)),
//         ],
//       ),
//       body: Stack(
//         children: <Widget>[
//           SizedBox.expand(
//             child: FittedBox(
//               fit: BoxFit.cover,
//               child: SizedBox(
//                 width: _controller.value.size.width,
//                 height: _controller.value.size.height,
//                 child: VideoPlayer(_controller),
//               ),
//             ),
//           ),
//           Container(
//             color: Colors.black.withOpacity(0.5),
//           ),
//           Container(
//             alignment: Alignment.bottomCenter,
//             padding: EdgeInsets.only(bottom: 220),
//             child: Text(
//               'Hello!',
//               style: TextStyle(
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.white,
//               ),
//             ),
//           ),
//           Container(
//             alignment: Alignment.bottomCenter,
//             padding: EdgeInsets.only(bottom: 150),
//             child: Text('MurtiShala',style: TextStyle(
//               fontSize: 55,
//               color:Colors.white,
//               fontWeight: FontWeight.bold,
//               fontStyle: FontStyle.italic,
//             ),
//             ),
//           ),
//
//           Container(
//             alignment: Alignment.bottomCenter,
//             padding: EdgeInsets.only(bottom: 80),
//             child: GestureDetector(
//               onTap: () {
//                 //_launchInstagramURL();
//               },
//               child: Text(
//                 'Follow us on Instagram : _MurtiShala_',
//                 style: TextStyle(
//                   fontSize: 16,
//                   color: Colors.white,
//                   //decoration: TextDecoration.underline,
//
//                 ),
//               ),
//             ),
//           ),
//
//                   Container(
//                     alignment: Alignment.bottomCenter,
//                     padding: EdgeInsets.only(bottom: 40),
//                     child: Row(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Icon(Icons.phone,color: Colors.white,),
//                         ),
//                         Text(
//                           'Contact No: 7875349880',
//                           style: TextStyle(
//                             fontSize: 16,
//                             color: Colors.white,
//                           ),
//
//                         ),
//                       ],
//                     ),
//
//                   ),
//                   SizedBox(height: 8),
//
//
//           BottomAppBar(
//             height: 60,
//             color: Colors.white.withOpacity(0),
//
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 IconButton(onPressed: (){
//                   Navigator.push(context, MaterialPageRoute(builder: (context)=>UserHome()));
//                 },
//                   icon: Icon(Icons.home),
//                   color: Colors.white,
//                   iconSize: 26,
//                 ),
//                 IconButton(
//                   onPressed: () {
//                     Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
//                   },
//                   icon: Icon(Icons.shopping_cart_outlined),
//                   iconSize: 26,
//                   tooltip: "home",
//                   color: Colors.white,
//                 ),
//                 IconButton(
//                   onPressed: () {
//                     Navigator.push(context, MaterialPageRoute(builder: (context) => Customize()));
//                   },
//                   icon: Icon(Icons.dashboard_customize_rounded),
//                   color: Colors.white,
//                   iconSize: 26,
//                 ),
//                 IconButton(
//                   onPressed: () {
//                     Navigator.push(context, MaterialPageRoute(builder: (context)=> NotificationScreenPage()));
//                   },
//                   icon: Icon(Icons.list_alt),
//                   color: Colors.white,
//                   iconSize: 26,
//                 ),
//                 IconButton(
//                   onPressed: () {
//                     Navigator.push(context, MaterialPageRoute(builder: (context) => Profile()));
//                   },
//                   icon: Icon(Icons.account_circle),
//                   color: Colors.white,
//                   iconSize: 26,
//                 ),
//                 PopupMenuButton<String>(
//                   icon: Icon(Icons.more_vert,color: Colors.white,),
//                   iconSize: 26,
//                   offset: Offset(10,50),
//                   itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
//                     PopupMenuItem<String>(
//                       value: 'Feedback',
//                       child: Row(
//                         children: [
//                           Expanded(
//                             child: Container(
//                               alignment: Alignment.topLeft,
//                               child: Text('Feedback', style: TextStyle(fontSize: 16)),
//                             ),
//                           ),
//                           Icon(Icons.feedback, size: 24),
//                         ],
//                       ),
//                     ),
//                   ],
//                   onSelected: (String value) {
//                     // Handle the selection of the Feedback option here
//                     if (value == 'Feedback') {
//                       // Handle Feedback option
//                       // For example, you can navigate to a feedback screen
//                       Navigator.push(context, MaterialPageRoute(builder: (context) => UserFeedbackScreen()));
//                     }
//                   },
//                 ),
//               ],
//             ),
//           ),
//
//         ],
//       ),
//     );
//   }
//   // Future<void> _launchInstagramURL() async {
//   //   const url = 'www.google.com';
//   //   final Uri instagramUrl = Uri.parse(url);
//   //   if (await canLaunchUrl(instagramUrl)) {
//   //     await launchUrl(instagramUrl);
//   //   } else {
//   //     throw 'Could not launch $url';
//   //   }
//   // }
// }
//


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:idol_booking/profile.dart';
import 'package:video_player/video_player.dart';
import 'Homepage.dart';
import 'feedback.dart';
import 'customize.dart';
import 'login.dart';
import 'notification.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'yourOrder.dart';
import 'myCustomizeOrderPage.dart';

class UserHome extends StatefulWidget {
  UserHome({Key? key}) : super(key: key);

  @override
  _UserHomeState createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  late VideoPlayerController _controller;
  var name = FirebaseAuth.instance.currentUser;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.lightBlue.shade50,
        title: Text(
          'MurtiShala',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            _scaffoldKey.currentState!.openDrawer();
          },
        ),
        actions: [
          IconButton(
            onPressed: () {
              logoutUser(context);
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      drawer: Drawer(
        width: 250,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.lightBlue.shade200,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: Text('My Orders'),
              leading: Icon(EvaIcons.list),
              onTap: () {
                // Navigate to the feedback screen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => YourOrderPage()),
                );
              },
            ),
            ListTile(
              title: Text('My Customize Orders'),
              leading: Icon(Icons.format_paint),
              onTap: () {
                // Navigate to the feedback screen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyCustomizeOrderPage()),
                );
              },
            ),
            ListTile(
              title: Text('Feedback'),
              leading: Icon(Icons.feedback),
              onTap: () {
                // Navigate to the feedback screen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UserFeedbackScreen()),
                );
              },
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
            color: Colors.black.withOpacity(0.5),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            padding: EdgeInsets.only(bottom: 220),
            child: Text(
              'Hello!',
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

          Container(
            alignment: Alignment.bottomCenter,
            padding: EdgeInsets.only(bottom: 80),
            child: GestureDetector(
              onTap: () {
                //_launchInstagramURL();
              },
              child: Text(
                'Follow us on Instagram : _MurtiShala_',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  //decoration: TextDecoration.underline,

                ),
              ),
            ),
          ),

          Container(
            alignment: Alignment.bottomCenter,
            padding: EdgeInsets.only(bottom: 40),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(Icons.phone,color: Colors.white,),
                ),
                Text(
                  'Contact No: 7875349880',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),

                ),
              ],
            ),

          ),
          SizedBox(height: 8),

          BottomAppBar(
            height: 60,
            color: Colors.white.withOpacity(0),

            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>UserHome()));
                },
                  icon: Icon(Icons.home),
                  color: Colors.white,
                  iconSize: 26,
                ),
                IconButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
                  },
                  icon: Icon(Icons.shopping_cart_outlined),
                  iconSize: 26,
                  tooltip: "home",
                  color: Colors.white,
                ),
                IconButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Customize()));
                  },
                  icon: Icon(Icons.dashboard_customize_rounded),
                  color: Colors.white,
                  iconSize: 26,
                ),
                IconButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> NotificationScreenPage()));
                  },
                  icon: Icon(Icons.notification_important),
                  color: Colors.white,
                  iconSize: 26,
                ),
                IconButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Profile()));
                  },
                  icon: Icon(Icons.account_circle),
                  color: Colors.white,
                  iconSize: 26,
                ),
                // PopupMenuButton<String>(
                //   icon: Icon(Icons.more_vert,color: Colors.white,),
                //   iconSize: 26,
                //   offset: Offset(10,50),
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
                //       Navigator.push(context, MaterialPageRoute(builder: (context) => UserFeedbackScreen()));
                //     }
                //   },
                // ),
              ],
            ),

          ),
        ],
      ),
    );
  }
}


