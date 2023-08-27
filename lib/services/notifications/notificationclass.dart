import 'package:achiever/services/notifications/notifications.dart';
import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final notificationService = NotificationsServices();
  @override
  void initState() {
    super.initState();
    notificationService.requestPermissions();
    //notificationService.isTokenRefresh();
    notificationService.firebaseInit();
    notificationService.getToken().then((value) {
      print('Device token');
      print(value);
    });   
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
