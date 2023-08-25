// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'dart:async';

import 'package:achiever/screens/authentications/signupPage.dart';
import 'package:achiever/screens/doctor_screens/doctor_form.dart';
import 'package:achiever/screens/homeScreen.dart';
import 'package:achiever/services/storage_services.dart';
import 'package:achiever/services/toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class VerifyEmailPage extends StatefulWidget { 
  const VerifyEmailPage({super.key, required this.proffesion});
  final proffesion;

  @override
  State<VerifyEmailPage> createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {
  bool isEmailVerified = false;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    if (!isEmailVerified) {
      sendVerificationEmail();
      timer = Timer.periodic(
        Duration(seconds: 3),
        (_) => checkEmailVerified(),
      );
    }
  }

  @override
  void dispose() {
    timer!.cancel();
    super.dispose();
  }

  Future checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser!.reload();
    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });
    if (isEmailVerified) {
      await StorageService()
          .setString("user_id", FirebaseAuth.instance.currentUser!.uid);
      Utils().toastMessage("Succesfully SignedIn", true);
      timer!.cancel();
      // if (widget.proffesion == "Doctor") {
      //   Navigator.push(
      //       context, MaterialPageRoute(builder: ((context) => DoctorForm())));
      // } else {
      //   Navigator.push(context,
      //       MaterialPageRoute(builder: ((context) => const HomeScreen())));
      // }
    }
  }

  Future sendVerificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();
    } catch (e) {
      Utils().toastMessage(e.toString(), false);
    }
  }

  @override
  Widget build(BuildContext context) => isEmailVerified
      ? (widget.proffesion == 'Doctor' ? DoctorForm() : HomeScreen())
      : SignUp();
}
