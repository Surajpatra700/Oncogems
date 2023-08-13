// ignore_for_file: use_build_context_synchronously, prefer_const_constructors

import 'package:achiever/screens/authentications/login.dart';
import 'package:achiever/screens/authentications/phone_auth.dart';
import 'package:achiever/screens/homeScreen.dart';
import 'package:achiever/services/storage_services.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rive/rive.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool check = false;
  bool check1 = false;
  bool hide = true;
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final auth = FirebaseAuth.instance;

  // TEDDY RIVE ANIMATION PARAMETER INITIALISATION

  Artboard? _teddyArtBoard;
  SMITrigger? successTrigger, failTrigger;
  SMIBool? isHandsUp, isChecking;
  SMINumber? numLook;

  StateMachineController? stateMachineController;

  @override
  void initState() {
    super.initState();
    rootBundle.load('assets/rive/login.riv').then((value) {
      final file = RiveFile.import(value);
      final artboard = file.mainArtboard;
      stateMachineController =
          StateMachineController.fromArtboard(artboard, "Login Machine");
      if (stateMachineController != null) {
        artboard.addController(stateMachineController!);

        stateMachineController!.inputs.forEach((element) {
          if (element.name == "trigSuccess") {
            successTrigger = element as SMITrigger;
          } else if (element.name == "trigFail") {
            failTrigger = element as SMITrigger;
          } else if (element.name == "isHandsUp") {
            isHandsUp = element as SMIBool;
          } else if (element.name == "isChecking") {
            isChecking = element as SMIBool;
          } else if (element.name == "numLook") {
            numLook = element as SMINumber;
          }
        });
      }
      setState(() {
        _teddyArtBoard = artboard;
      });
    });
  }

  void handsOnTheEyes() {
    isHandsUp?.change(true);
  }

  void lookOnTheTextField() {
    isHandsUp?.change(false);
    isChecking?.change(true);
    numLook?.change(0);
  }

  void moveEyeBalls(val) {
    numLook?.change(val.length.toDouble());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: const Color(0xffd5e2ea),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Welcome to",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.normal,
                          color: Color(0xff50a387)),
                    )),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Achiever",
                      style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff50a387)),
                    )),
              ),
              if (_teddyArtBoard != null)
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 250.h,
                  child: Rive(artboard: _teddyArtBoard!, fit: BoxFit.cover),
                ),
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        child: TextFormField(
                          onTap: () {
                            lookOnTheTextField();
                          },
                          onChanged: moveEyeBalls,
                          controller: emailController,
                          decoration: InputDecoration(
                              hintText: "Email",
                              prefixIcon: const Icon(Icons.email),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(120))),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please enter your email";
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        child: TextFormField(
                          onTap: handsOnTheEyes,
                          controller: passwordController,
                          obscureText: hide,
                          decoration: InputDecoration(
                              hintText: "Password",
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    hide = !hide;
                                  });
                                },
                                icon: hide
                                    ? const Icon(Icons.visibility_off)
                                    : const Icon(Icons.visibility),
                              ),
                              prefixIcon: const Icon(Icons.lock),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(120))),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please enter your password";
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                    ],
                  )),
              Padding(
                padding: EdgeInsets.only(top: 20.0.h),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(25.r),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          elevation: 4,
                          minimumSize: const Size(240, 48),
                          backgroundColor: const Color(0xff50a387),
                          padding: const EdgeInsets.symmetric(horizontal: 55)),
                      onPressed: () {
                        setState(() {
                          check = true;
                        });
                        if (_formKey.currentState!.validate() &&
                            (emailController.text != null &&
                                passwordController.text != null)) {
                          setState(() {});
                          auth
                              .createUserWithEmailAndPassword(
                            email: emailController.text.toString(),
                            password: passwordController.text.toString(),
                          )
                              .then((value) {
                            isChecking?.change(false);
                            isHandsUp?.change(false);
                            //Utils(check: true).toastMessage("Succesfully SignedUp");
                            auth
                                .signInWithEmailAndPassword(
                                    email: emailController.text,
                                    password: passwordController.text)
                                .then((value) async {
                              await StorageService()
                                  .setString("user_id", value.user!.uid);
                              setState(() {
                                check = false;
                              });
                              successTrigger?.fire();
                              Get.snackbar("Achiever", "Succesfully SignedIn",
                                  colorText: const Color(0xff50a387));
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: ((context) =>
                                          const HomeScreen())));
                            });
                          }).onError((error, stackTrace) {
                            setState(() {
                              check = false;
                            });
                            //print(error.toString());
                            Get.snackbar("Achiever", error.toString(),
                                colorText: Colors.red);
                            failTrigger?.fire();
                          });
                        }
                      },
                      child: check
                          ? CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : Text("Create account")),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Already have an account?",
                    style: TextStyle(fontSize: 12),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Login()));
                      },
                      child: const Text("Sign in"))
                ],
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(25.r),
                child: ElevatedButton(
                    onPressed: () async {
                      // setState(() {
                      //   check1 = true;
                      // });
                      await Get.to(VerifyNumber());
                    },
                    style: ElevatedButton.styleFrom(
                        elevation: 4,
                        minimumSize: Size(320.w, 48.h),
                        backgroundColor: const Color(0xff50a387),
                        padding: EdgeInsets.symmetric(horizontal: 30.h)),
                    child: check
                        ? CircularProgressIndicator(
                            strokeWidth: 3,
                            color: Colors.white,
                          )
                        : Text("SignIn with phone number")),
              )
            ],
          ),
        ),
      ),
    );
  }
}
