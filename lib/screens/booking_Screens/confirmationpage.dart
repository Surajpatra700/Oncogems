import 'package:achiever/screens/homeScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class confirmationpage extends StatefulWidget {

  const confirmationpage({super.key});

  @override
  State<confirmationpage> createState() => _confirmationpageState();
}

class _confirmationpageState extends State<confirmationpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: 600.h,
        child: PageView.builder(
            itemCount: 1,
            itemBuilder: (context, index) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset(

                           "assets/animations/successful.json",

                      height: 300.h,
                      reverse: true,
                      repeat: true,
                      fit: BoxFit.cover),
                  SizedBox(
                    height: 25.h,
                  ),
                  Text(
                     "Your Booking has been Confirmed",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20.w, right: 20, top: 15.h),
                    child: Text(

                           "Please go 1 hour before your booked time slot.",

                      style: TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 15.5),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20.h),
                    child: Card(
                        elevation: 5,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                maximumSize: Size(100, 45),
                                backgroundColor: Colors.grey.shade200),
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
