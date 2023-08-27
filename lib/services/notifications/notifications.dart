// ignore_for_file: unused_import

import 'dart:math';

import 'package:achiever/services/storage_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

// 1. request Permission
// 2. get Token
// 3. init info

class NotificationsServices {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  final flutterLocalNotificationPlugin = FlutterLocalNotificationsPlugin();

  void requestPermissions() async {
    // FirebaseMessaging message = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission();
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print("User granted permission");
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print("User granted provinsional permission");
    } else {
      print("No permission granted");
    }
  }

  Future<String> getToken() async {
    String? token = await messaging.getToken();
    return token!;
  }

  void isTokenRefresh() async {
    messaging.onTokenRefresh.listen((event) {
      event.toString();
      print('refresh');
    });
  }

  void initLocalNotifications(BuildContext context, RemoteMessage message) async {
    var androidInitializationSettings =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettings = InitializationSettings(
      android: androidInitializationSettings,
    );
    await flutterLocalNotificationPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: (payload) {});
  }

  void firebaseInit() {
    FirebaseMessaging.onMessage.listen((message) {
      if (kDebugMode) {
        print(message.notification!.title.toString());
        print(message.notification!.body.toString());
      }
      showNotifications(message);
    });
  }

  Future<void> showNotifications(RemoteMessage message) async {
    AndroidNotificationChannel channel = AndroidNotificationChannel(
      Random.secure().nextInt(10000).toString(),
      'High Important Channel',
      importance: Importance.max,
    );

    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      channel.id.toString(),
      channel.name.toString(),
      channelDescription: 'Your channel description',
      importance: Importance.high,
      priority: Priority.high,
      ticker: 'ticker',
    );

    NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);

    if (message != null) {
      Future.delayed(Duration.zero, () {
      flutterLocalNotificationPlugin.show(
        2,
        message.notification!.title.toString(),
        message.notification!.body.toString(),
        notificationDetails,
      );
    });
    } else {
      print('Message is NULL');
    }   
  }
}

// class NotificationService extends StatefulWidget {
//   const NotificationService({super.key});

//   @override
//   State<NotificationService> createState() => _NotificationServiceState();
// }

// class _NotificationServiceState extends State<NotificationService> {
//   String? mtoken = "";
//   final flutterLocalNotificationPlugin = FlutterLocalNotificationsPlugin();

//   @override
//   void initState() {
//     requestPermissions();
//     getToken();
//     super.initState();
//   }

//   void requestPermissions() async {
//     FirebaseMessaging message = FirebaseMessaging.instance;
//     NotificationSettings settings = await message.requestPermission();
//     if (settings.authorizationStatus == AuthorizationStatus.authorized) {
//       print("User granted permission");
//     } else if (settings.authorizationStatus ==
//         AuthorizationStatus.provisional) {
//       print("User granted provinsional permission");
//     } else {
//       print("No permission granted");
//     }
//   }

//   void getToken() async {
//     await FirebaseMessaging.instance.getToken().then((token) {
//       setState(() {
//         mtoken = token;
//         print("My token is $mtoken");
//       });
//       saveToken(token!);
//     });
//   }

//   void saveToken(String token) async {
//     final id = StorageService().getString('user_id');
//     await FirebaseFirestore.instance.collection("UserTokens").doc(id).set({
//       'token': token,
//     });
//   }

//   initinfo(){
//     // initialise flutter local notification
//     var androidInitialization = const AndroidInitializationSettings('@mipmap/ic_launcher');
//     var initializationSettings = InitializationSettings(android: androidInitialization);
//     flutterLocalNotificationPlugin.initialize(initializationSettings, onDidReceiveNotificationResponse: (payload) async{
//       try{
//         if(payload != null){

//         }
//       }catch(e){

//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold();
//   }
// }