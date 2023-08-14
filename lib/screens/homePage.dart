// ignore_for_file: prefer_const_constructors, unnecessary_const

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

List<String> domains = [
  "Goals",
  "Suggestions",
  "Pomedaro Timer",
  "Note Taking"
];

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff61B688).withOpacity(0.7),
      body: SingleChildScrollView(
        //scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 0),
              child: Stack(
                children: [

                  Padding(
                    padding: EdgeInsets.only(top: 200.0.h),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: Container(
                          // height: MediaQuery.of(context).size.height / 1.2,
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.only(top: 58.h, left: 15.h),
                          decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(30.r),
                                  topRight: Radius.circular(30.r))),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  "Your Daily Task ",
                                  style: TextStyle(
                                      fontSize: 23.sp,
                                      color: Colors.black54,
                                      fontWeight: FontWeight.w600),
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                Text(
                                  "almost done ",
                                  style: TextStyle(
                                      fontSize: 20.sp, color: Colors.black54),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text("Domains",
                                      style: TextStyle(
                                        fontSize: 23.sp,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black,
                                      )),
                                ),
                                // for (int i = 0; i < 4; i++)
                                GridView.builder(
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                  ),
                                  itemCount: domains.length,
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    // for (int i = 0; i < domains.length; i++)
                                    return InkWell(
                                      onTap: () {},
                                      child: Container(
                                        margin: EdgeInsets.all(10),
                                        padding:
                                            EdgeInsets.symmetric(vertical: 15),
                                        decoration: BoxDecoration(
                                            color: Colors.amber,
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.black12,
                                                  blurRadius: 4,
                                                  spreadRadius: 2),
                                            ]),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Text(
                                              domains[index],
                                              style: TextStyle(
                                                fontSize: 18.sp,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black87,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ])),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 172.0.h),
                    child: Center(
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("You 2 task yet to be done!!",style: TextStyle(color: Colors.black87,fontSize: 19.sp,fontWeight: FontWeight.w500)),
                          ],
                        ),
                        height: 75.h,
                        width: 245.w,
                        decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 12.h,)
                ],
              ),
            ),
            // SizedBox(
            //   height: 20,
            // ),
          ],
        ),
      ),
      /*Positioned(
            top: 180.sp,
            left: 90.sp,
            child: Text(
              "You Have 2 Task left",
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.black54,
                  fontWeight: FontWeight.w600),
            ),
          ),*/
    );
  }
}
