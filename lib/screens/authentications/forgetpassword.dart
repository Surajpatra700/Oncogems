import 'package:achiever/screens/authentications/login.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class Forgetpassword extends StatefulWidget {
  const Forgetpassword({super.key});

  @override
  State<Forgetpassword> createState() => _ForgetpasswordState();
}

class _ForgetpasswordState extends State<Forgetpassword> {
  final auth = FirebaseAuth.instance;
  final emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20),
              child: TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40)),
                  hintText: "Enter email",
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20.0),
              child: ElevatedButton(
                  onPressed: () {
                    auth
                        .sendPasswordResetEmail(
                      email: emailController.text,
                    )
                        .then((_) {
                      Get.to(Login());
                    }).onError((error, stackTrace) {
                      Get.snackbar("Achiever", error.toString());
                    });
                  },
                  child: Text("Reset password")),
            )
          ],
        ),
      ),
    );
  }
}
