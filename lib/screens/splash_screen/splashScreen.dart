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
      splashServices.action(context);
    }

  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      backgroundColor: Color(0xff50a387),
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage("assets/images/oncogems.jpg"),fit: BoxFit.cover)
          ),
        )
      ),
    );
  }
}
