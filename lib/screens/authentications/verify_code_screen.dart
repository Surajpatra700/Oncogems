// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_import, prefer_typing_uninitialized_variables

import 'package:achiever/screens/homeScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class VerifyCodeScreen extends StatefulWidget {
  final verifyId;
  final phoneNumber;
  const VerifyCodeScreen(
      {super.key, required this.verifyId, required this.phoneNumber});

  @override
  State<VerifyCodeScreen> createState() => _VerifyCodeScreenState();
}

class _VerifyCodeScreenState extends State<VerifyCodeScreen> {
  final int1 = TextEditingController();
  final int2 = TextEditingController();
  final int3 = TextEditingController();
  final int4 = TextEditingController();
  final int5 = TextEditingController();
  final int6 = TextEditingController();
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
                          "https://assets.materialup.com/uploads/0ee0cb42-f785-4667-8ffc-201857cbfbf9/preview.jpg"),
                      fit: BoxFit.cover),
                ),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Text(
              "Verification Code",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 19),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "We will sent the code verification to",
                  style: TextStyle(
                      color: Colors.black54,
                      fontSize: 14,
                      fontWeight: FontWeight.w400),
                ),
              ],
            ),
            Text(
              "${widget.phoneNumber}",
              style: TextStyle(
                  color: Colors.black54,
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 50),
            Text(
              "Enter Your OTP Code",
              style: TextStyle(
                  color: Colors.black54,
                  fontSize: 15,
                  fontWeight: FontWeight.w400),
            ),
            SizedBox(
              height: 15,
            ),
            Form(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 58,
                      width: 55,
                      child: TextFormField(
                        controller: int1,
                        onChanged: (value) {
                          if (value.length == 1) {
                            FocusScope.of(context).nextFocus();
                          }
                        },
                        obscureText: true,
                        //obscuringCharacter: "*",
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 2, color: Colors.green)),
                        ),
                        style: Theme.of(context).textTheme.titleLarge,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(1),
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 58,
                      width: 55,
                      child: TextFormField(
                        controller: int2,
                        onChanged: (value) {
                          if (value.length == 1) {
                            FocusScope.of(context).nextFocus();
                          }
                        },
                        obscureText: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 2, color: Colors.green)),
                        ),
                        style: Theme.of(context).textTheme.titleLarge,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(1),
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 58,
                      width: 55,
                      child: TextFormField(
                        controller: int3,
                        onChanged: (value) {
                          if (value.length == 1) {
                            FocusScope.of(context).nextFocus();
                          }
                        },
                        obscureText: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 2, color: Colors.green)),
                        ),
                        style: Theme.of(context).textTheme.titleLarge,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(1),
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 58,
                      width: 55,
                      child: TextFormField(
                        controller: int4,
                        onChanged: (value) {
                          if (value.length == 1) {
                            FocusScope.of(context).nextFocus();
                          }
                        },
                        obscureText: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 2, color: Colors.green)),
                        ),
                        style: Theme.of(context).textTheme.titleLarge,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(1),
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 58,
                      width: 55,
                      child: TextFormField(
                        controller: int5,
                        onChanged: (value) {
                          if (value.length == 1) {
                            FocusScope.of(context).nextFocus();
                          }
                        },
                        obscureText: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 2, color: Colors.green)),
                        ),
                        style: Theme.of(context).textTheme.titleLarge,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(1),
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 58,
                      width: 55,
                      child: TextFormField(
                        controller: int6,
                        onChanged: (value) {
                          if (value.length == 1) {
                            FocusScope.of(context).nextFocus();
                          }
                        },
                        obscureText: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 2, color: Colors.green)),
                        ),
                        style: Theme.of(context).textTheme.titleLarge,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(1),
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 65,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: ElevatedButton(
                  onPressed: () async {
                    final credential = PhoneAuthProvider.credential(
                      verificationId: widget.verifyId,
                      smsCode: (int1.text.toString() +
                              int2.text.toString() +
                              int3.text.toString() +
                              int4.text.toString() +
                              int5.text.toString() +
                              int6.text.toString())
                          .toString(),
                    );

                    await auth.signInWithCredential(credential).then((value) {
                      Get.snackbar("Achiever", "Successfully LoggedIn");
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => HomeScreen())));
                    }).onError((error, stackTrace) {
                      Get.snackbar("Achiever", error.toString());
                    });
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xff50a387),
                      minimumSize: Size(double.infinity, 53)),
                  child: Text(
                    "Submit",
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
