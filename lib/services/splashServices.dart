import 'dart:async';

import 'package:achiever/screens/homeScreen.dart';
import 'package:achiever/screens/onboarding%20Screens/onboarding_home_screen.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SplashServices {
  final auth = FirebaseAuth.instance;
  void action() {
    if (auth.currentUser != null) {
      Timer(Duration(seconds: 3), () => Get.to(HomeScreen()));
    } else {
      Get.to(UnboardingPage());
    }
  }
}
