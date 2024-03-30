// import 'package:flutter/material.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
//
// class NotificationScreenPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Notification Demo',
//       home: NotificationPage(),
//     );
//   }
// }
//
// class NotificationPage extends StatefulWidget {
//   @override
//   _NotificationPageState createState() => _NotificationPageState();
// }
//
// class _NotificationPageState extends State<NotificationPage> {
//   late FirebaseMessaging _firebaseMessaging;
//   String? _messageText;
//
//   @override
//   void initState() {
//     super.initState();
//     _initializeFirebaseMessaging();
//   }
//
//   void _initializeFirebaseMessaging() {
//     _firebaseMessaging = FirebaseMessaging.instance;
//
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       setState(() {
//         _messageText = message.notification?.body;
//       });
//       print("Foreground Message: ${message.notification?.body}");
//       // Handle incoming messages while the app is in the foreground
//     });
//
//     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//       setState(() {
//         _messageText = message.notification?.body;
//       });
//       print("Background/Foreground Message: ${message.notification?.body}");
//       // Handle when a user taps on the notification and the app is in the background or terminated
//     });
//
//     _firebaseMessaging.getToken().then((String? userToken) {
//       if (userToken != null) {
//         print("FCM Token: $userToken");
//         // Send this token to your server if needed
//       } else {
//         print("FCM Token is null.");
//       }
//     }).catchError((error) {
//       print("Failed to get FCM token: $error");
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Notification Page'),
//       ),
//       body: Center(
//         child: Padding(
//           padding: EdgeInsets.all(20.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               if (_messageText != null)
//                 Text(
//                   'Received message: $_messageText',
//                   style: TextStyle(fontSize: 18.0),
//                 )
//               else
//                 Text(
//                   'No message received yet.',
//                   style: TextStyle(fontSize: 18.0),
//                 ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'payment.dart';

class NotificationScreenPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationScreenPage> {
  late FirebaseMessaging _firebaseMessaging;
  String? _messageText;
  bool _requestAccepted = false;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    _initializeFirebaseMessaging();
    _initializeLocalNotifications();
  }

  void _initializeFirebaseMessaging() {
    _firebaseMessaging = FirebaseMessaging.instance;

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      _displayNotification(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      // Handle when the app is opened from a notification
    });

    _firebaseMessaging.getToken().then((String? userToken) {
      if (userToken != null) {
        print("FCM Token: $userToken");
        // Here you can send this token to your server for targeting users
      } else {
        print("FCM Token is null.");
      }
    }).catchError((error) {
      print("Failed to get FCM token: $error");
    });
  }

  void _initializeLocalNotifications() {
    final AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');
    final InitializationSettings initializationSettings =
    InitializationSettings(android: initializationSettingsAndroid);
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> _displayNotification(RemoteMessage message) async {
    String? notificationBody = message.notification?.body;
    String? notificationTitle = message.notification?.title;

    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
      'order_notifications',
      'Order Notifications',
      channelDescription: 'Channel for order notifications',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );

    const NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      0,
      notificationTitle,
      notificationBody,
      platformChannelSpecifics,
      payload: 'item X',
    );

    setState(() {
      _messageText = notificationBody;
      _updateRequestStatus(_messageText);
    });
  }

  void _updateRequestStatus(String? messageText) {
    if (messageText != null &&
        (messageText.contains('Your customize order has been accepted') ||
            messageText.contains('Your order has been accepted'))) {
      _requestAccepted = true;
    } else {
      _requestAccepted = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notification Page'),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (_messageText != null)
                Text(
                  'Received message: $_messageText',
                  style: TextStyle(fontSize: 18.0),
                )
              else
                Text(
                  'No message received yet.',
                  style: TextStyle(fontSize: 18.0),
                ),
              SizedBox(height: 20),
              if (_requestAccepted)
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> PaymentPage()));
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.payment),
                      SizedBox(width: 10),
                      Text('Make Payment'),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
