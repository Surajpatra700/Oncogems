// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'package:achiever/screens/homeScreen.dart';
import 'package:achiever/screens/onboarding%20Screens/onboarding_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SplashServices {
  final auth = FirebaseAuth.instance;
  void action(BuildContext context) {
    final user = auth.currentUser;
    if (user == null) {
      Timer(
          Duration(seconds: 0),
          () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => UnboardingPage())));
    } else {
      Timer(
          Duration(seconds: 3),
          () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => HomeScreen())));
    }
  }
}
