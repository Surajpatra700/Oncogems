// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:achiever/services/splashServices.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final splashServices = SplashServices();

  @override
  void initState() {
    super.initState();
    splashServices.action();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff50a387),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Oncogems",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: "poppins",
                  fontSize: 40,
                  color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
