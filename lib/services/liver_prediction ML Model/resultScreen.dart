import 'package:achiever/screens/homeScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class ResultScreen extends StatefulWidget {
  final value;
  const ResultScreen({super.key, required this.value});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: PageView.builder(
            itemCount: 1,
            itemBuilder: (context, index) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset(widget.value == "0"? "assets/animations/successful.json" : "assets/animations/detected.json",
                      height: 300.h,
                      reverse: true,
                      repeat: true,
                      fit: BoxFit.cover),
                  SizedBox(
                    height: 25.h,
                  ),
                  Text(
                    widget.value == "0"?"All Right!": "Cancer detected!",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20.w, right: 20, top: 15.h),
                    child: Text(
                      widget.value == "0"? "No cancerogenic cell found.": "Please have a checkup in a nearby hospital",
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 15.5),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20.h),
                    child: Card(
                        elevation: 5,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(maximumSize: Size(100, 45),backgroundColor: Colors.grey.shade200),
                            onPressed: () {
                              Get.to(HomeScreen());
                            },
                            child: Center(
                              child: Icon(
                                Icons.arrow_right_alt,
                                size: 30,
                                color: Colors.black,
                              ),
                            ))),
                  )
                ],
              );
            }),
      ),
    );
  }
}