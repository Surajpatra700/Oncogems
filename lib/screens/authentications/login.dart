

import 'package:achiever/screens/authentications/signupPage.dart';
import 'package:achiever/screens/homeScreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rive/rive.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool check = false;
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

  // void login() {
  //   isChecking?.change(false);
  //   isHandsUp?.change(false);
  //   if(emailController)
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  child: Text("Welcome to",style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal,color: Color(0xff50a387)),)),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Login Screen",style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold,color: Color(0xff50a387)),)),
              ),
              if(_teddyArtBoard != null)
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 250.h,
                  child: Rive(artboard: _teddyArtBoard!,fit: BoxFit.cover),
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
                        height: 15,
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
                        if (_formKey.currentState!.validate() &&
                            (emailController.text != null &&
                                passwordController.text != null)) {
                          setState(() {});
                          isChecking?.change(false);
                            isHandsUp?.change(false);
                          auth
                                .signInWithEmailAndPassword(
                                    email: emailController.text,
                                    password: passwordController.text)
                              .then((_) {
                              successTrigger?.fire();
                              Get.snackbar("Achiever", "Welcome to Achiever",
                                  colorText: const Color(0xff50a387));
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: ((context) => const HomeScreen())));
                            }).onError((error, stackTrace) {
                            //print(error.toString());
                            Get.snackbar("Achiever", error.toString(),
                                colorText: Colors.red);
                            failTrigger?.fire();
                          });
                        }
                      },
                      child: const Text("Login")),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't have an account?",
                    style: TextStyle(fontSize: 12),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignUp()));
                      },
                      child: const Text("Signup"))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
