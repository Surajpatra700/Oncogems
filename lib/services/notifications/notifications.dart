// ignore_for_file: unused_import

import 'package:achiever/services/storage_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

// 1. request Permission
// 2. get Token
// 3. init info

// class NotificationsHandling {
//   void requestPermissions() async {
//     FirebaseMessaging message = FirebaseMessaging.instance;
//     NotificationSettings settings = await message.requestPermission();
//     if (settings.authorizationStatus == AuthorizationStatus.authorized) {
//       print("User granted permission");
//     } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
//       print("User granted provinsional permission");
//     } else{
//       print("No permission granted");
//     }
//   }

//   void getToken() async{
//     await FirebaseMessaging.instance.getToken().then((token){
//       setSta
//     })
//   }
// }

class NotificationService extends StatefulWidget {
  const NotificationService({super.key});

  @override
  State<NotificationService> createState() => _NotificationServiceState();
}

class _NotificationServiceState extends State<NotificationService> {
  String? mtoken = "";
  final flutterLocalNotificationPlugin = FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    requestPermissions();
    getToken();
    super.initState();
  }

  void requestPermissions() async {
    FirebaseMessaging message = FirebaseMessaging.instance;
    NotificationSettings settings = await message.requestPermission();
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print("User granted permission");
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print("User granted provinsional permission");
    } else {
      print("No permission granted");
    }
  }

  void getToken() async {
    await FirebaseMessaging.instance.getToken().then((token) {
      setState(() {
        mtoken = token;
        print("My token is $mtoken");
      });
      saveToken(token!);
    });
  }

  void saveToken(String token) async {
    final id = StorageService().getString('user_id');
    await FirebaseFirestore.instance.collection("UserTokens").doc(id).set({
      'token': token,
    });
  }

  initinfo(){
    // initialise flutter local notification
    var androidInitialization = const AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettings = InitializationSettings(android: androidInitialization);
    flutterLocalNotificationPlugin.initialize(initializationSettings, onDidReceiveNotificationResponse: (payload) async{
      try{
        if(payload != null){

        }
      }catch(e){

      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
