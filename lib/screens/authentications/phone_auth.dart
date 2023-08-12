// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:achiever/screens/authentications/verify_code_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VerifyNumber extends StatefulWidget {
  const VerifyNumber({super.key});

  @override
  State<VerifyNumber> createState() => _VerifyNumberState();
}

class _VerifyNumberState extends State<VerifyNumber> {
  bool check = false;
  final phoneNumberController = TextEditingController();
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white54,
        leading: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            )),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 60,
            ),
            Center(
              child: Container(
                height: 160,
                width: 300,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                          "https://img.freepik.com/premium-vector/mobile-otp-secure-verification-method-onetime-password-secure-transaction-woman-using-security-otp-one-time-password-verification-mobile-app-smartphone-screen-2step-verification_735449-280.jpg?w=2000"),
                      fit: BoxFit.cover),
                ),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Text(
              "OTP Verification",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 19),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "We will send you an  ",
                  style: TextStyle(
                      color: Colors.black54,
                      fontSize: 14,
                      fontWeight: FontWeight.w400),
                ),
                Text(
                  "One Time Password",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ],
            ),
            Text(
              "on this mobile number",
              style: TextStyle(
                  color: Colors.black54,
                  fontSize: 14,
                  fontWeight: FontWeight.w400),
            ),
            SizedBox(height: 50),
            Text(
              "Enter Mobile Number",
              style: TextStyle(
                  color: Colors.black54,
                  fontSize: 15,
                  fontWeight: FontWeight.w400),
            ),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 120.0),
              child: TextFormField(
                controller: phoneNumberController,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  hintText: "  +91-9768554136",
                  hintStyle:
                      TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                ),
                validator: (value) {
                  if (value == null) {
                    print("Enter your number");
                  } else {
                    return null;
                  }
                },
              ),
            ),
            SizedBox(
              height: 65,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      check = true;
                    });
                    auth.verifyPhoneNumber(
                      phoneNumber: phoneNumberController.text,
                      verificationCompleted: (_) {},
                      verificationFailed: (e) {
                        Get.snackbar("Achiever", e.toString());
                      },
                      codeSent: (String verificationId, int? token) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => VerifyCodeScreen(
                                      verifyId: verificationId,
                                      phoneNumber:
                                          phoneNumberController.text.toString(),
                                    )));
                      },
                      codeAutoRetrievalTimeout: (e) {
                        setState(() {
                          check = false;
                        });
                        Get.snackbar("Achiever", e.toString());
                      },
                    );
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xff50a387),
                      minimumSize: Size(double.infinity, 53)),
                  child: check
                      ? Center(
                          child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 4,
                        ))
                      : Text(
                          "Get OTP",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        )),
            ),
          ],
        ),
      ),
    );
  }
}
