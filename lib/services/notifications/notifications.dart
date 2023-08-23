import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

class NotificationsHandling {
  void requestPermissions() async {
    FirebaseMessaging message = FirebaseMessaging.instance;
    NotificationSettings settings = await message.requestPermission();
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print("User granted permission");
    }else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
      print("User granted provinsional permission");
    }else{
      print("No permission granted");
    }
  }
}
