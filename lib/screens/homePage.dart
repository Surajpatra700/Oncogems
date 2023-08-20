// ignore_for_file: prefer_const_constructors, unnecessary_const

import 'package:achiever/screens/Form%20Page/formpage.dart';
import 'package:achiever/screens/bloodPressure.dart';
import 'package:achiever/screens/doctor_screens/doctor_form.dart';
import 'package:achiever/screens/pulserate.dart';
import 'package:achiever/screens/sugarlevel.dart';
import 'package:achiever/screens/testing.dart';
import 'package:achiever/screens/wbcCount.dart';
import 'package:achiever/services/oralCancer_prediction/oralPrediction.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';

List<String> domains = [
  "Scan",
  "form",
  // "Report",
];
List<String> measurement = [
  "Pulse rate",
  "WBC Count",
  "Blood Pressure",
  "Sugar"
];
List domainimage = [
  "scan.jpg",
  "forms.jpg",
  // "report.jpg",
];
List image = [
  "pulserate.png",
  "wbc.png",
  "heart.png",
  "sugar.png",
];

List<DoctorInfo> doctordata = [
  DoctorInfo(
      "https://www.woodlandshospital.in/images/doctor-img/Soutik-Panda-New1.jpg",
      "Dr. Samridhi Singh",
      "Great Renowened oncologist on AIIMS bhubaneswar with 12 years of experience"),
  DoctorInfo(
      "https://www.woodlandshospital.in/images/doctor-img/Soutik-Panda-New1.jpg",
      "Dr. Jitendra Nath",
      "Great Renowened oncologist on AIIMS bhubaneswar with 12 years of experience"),
  DoctorInfo(
      "https://www.woodlandshospital.in/images/doctor-img/Soutik-Panda-New1.jpg",
      "Dr. Ravish Kapoor",
      "Great Renowened oncologist on AIIMS bhubaneswar with 12 years of experience"),
  DoctorInfo(
      "https://www.woodlandshospital.in/images/doctor-img/Soutik-Panda-New1.jpg",
      "Dr. Sekhar Ojha",
      "Great Renowened oncologist on AIIMS bhubaneswar with 12 years of experience"),
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
      backgroundColor: Colors.grey.shade200,
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: 7.5.sp),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 15.w, top: 13.h, bottom: 13.h),
                child: Text(
                  "Good evening",
                  style: TextStyle(
                    fontSize: 20.5,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Row(
                children: [
                  Stack(
                    children: [
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.notifications,
                            size: 28,
                          )),
                      Positioned(
                          left: 13.w,
                          top: 13.h,
                          child: CircleAvatar(
                            radius: 4,
                            backgroundColor: Colors.green,
                          ))
                    ],
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.settings,
                        size: 28,
                      ))
                ],
              ),
            ],
          ),

          SizedBox(
            height: 300.h,
            child: ScrollSnapList(
              itemBuilder: _buildListItem,
              itemCount: doctordata.length,
              itemSize: 300.h,
              onItemFocus: (index) {},
              dynamicItemSize: true,
              scrollDirection: Axis.horizontal,
            ),
          ),

          // SizedBox(
          //     height: 210.h,
          //     child: ListView.builder(
          //         itemCount: 4,
          //         scrollDirection: Axis.horizontal,
          //         itemBuilder: (context, index) {
          //           return InkWell(
          //             onTap: () {},
          //             child: Container(
          //               margin: EdgeInsets.all(15.00.sp),
          //               padding: EdgeInsets.symmetric(vertical: 12.sp),
          //               decoration: BoxDecoration(
          //                   gradient: LinearGradient(
          //                     colors: [Colors.green, Colors.white],
          //                     begin: Alignment.bottomLeft,
          //                     end: Alignment.topRight,
          //                   ),
          //                   borderRadius: BorderRadius.circular(10.r),
          //                   boxShadow: [
          //                     BoxShadow(
          //                       color: Colors.black26,
          //                       blurRadius: 4.sp,
          //                       spreadRadius: 2.r,
          //                     ),
          //                   ]),
          //               child: SizedBox(
          //                 width: MediaQuery.of(context).size.width / 1.18,
          //                 child: Column(
          //                   children: [
          //                     ListTile(
          //                       leading: CircleAvatar(
          //                         radius: 40.sp,
          //                         backgroundImage:
          //                             AssetImage("assets/images/oncogems.jpg"),
          //                       ),
          //                       title: Text(
          //                         "Dr. Doctor",
          //                         style: TextStyle(
          //                           fontSize: 28.sp,
          //                           fontWeight: FontWeight.bold,
          //                         ),
          //                       ),
          //                     ),
          //                     SizedBox(
          //                       height: 30.h,
          //                     ),
          //                     Padding(
          //                       padding:
          //                           EdgeInsets.symmetric(horizontal: 10.sp),
          //                       child: Text(
          //                         maxLines: 2,
          //                         "A very great and professional Doctor.Many many thanks to the doctor",
          //                         style: TextStyle(color: Colors.black),
          //                       ),
          //                     )
          //                   ],
          //                 ),
          //               ),
          //             ),
          //           );
          //         })),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {},
                child: Text("Talk to your care taker",
                    style: TextStyle(
                        fontSize: 15.5.sp,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff50a387))),
              ),
              TextButton(
                onPressed: () {},
                child: Text("See all",
                    style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.blue)),
              ),
            ],
          ),
          SizedBox(
            height: 0,
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 15.sp,
            ),
            child: Text(
              "Recommendations",
              style: TextStyle(
                fontSize: 20.5.sp,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ),
          SizedBox(
            height: 170.h,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: domains.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    if (index == 1) {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => formpage()));
                    } else if (index == 0) {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => OralPrediction()));
                    }
                  },
                  child: Container(
                    width: 170.w,
                    margin:
                        EdgeInsets.symmetric(vertical: 10.h, horizontal: 5.w),
                    padding: EdgeInsets.symmetric(horizontal: 15.sp),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.green, Color(0xff26BBAC)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(10.sp),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 4.sp,
                          spreadRadius: 2.sp,
                          color: Colors.black12,
                        ),
                      ],
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CircleAvatar(
                            radius: 45.sp,
                            backgroundImage: AssetImage(
                                "assets/images/${domainimage[index]}"),
                          ),
                          Text(
                            domains[index],
                            style: TextStyle(
                              fontSize: 17.sp,
                              fontWeight: FontWeight.w500,
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(
            height: 15.h,
          ),
          Padding(
            padding: EdgeInsets.only(left: 16),
            child: Text("Measurements",
                style: TextStyle(
                  fontSize: 20.5.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                )),
          ),
          GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemCount: measurement.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  if (index == 0) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => PulseRateScreen()));
                  }else if(index == 1){
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => WBCCountScreen()));
                  }else if(index == 2){
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => BloodPressureScreen()));
                  }else if(index == 3){
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => BloodSugarScreen()));
                  }
                },
                child: Container(
                  margin: EdgeInsets.all(10.sp),
                  padding: EdgeInsets.symmetric(vertical: 15.sp),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                        //colors: [Colors.green, Colors.white],
                        colors: [Colors.green, Color(0xff26BBAC)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(18.r),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black12,
                            blurRadius: 4.sp,
                            spreadRadius: 4.sp),
                      ]),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CircleAvatar(
                        radius: 40.sp,
                        backgroundImage:
                            AssetImage("assets/images/${image[index]}"),
                      ),
                      Text(
                        measurement[index],
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ]),
      ),
      drawer: Drawer(
        backgroundColor: Colors.grey.shade200,
      ),
    );
  }
}
/*Widget _buildListItem(BuildContext context, int index) {
 return  InkWell(
    onTap: () {

    },
    child: Container(
      margin: EdgeInsets.all(15.00.sp),
      padding: EdgeInsets.symmetric(vertical: 12.sp),
      decoration: BoxDecoration(
          gradient: LinearGradient(colors:[Colors.green,Colors.white] ,begin: Alignment.bottomLeft,
            end: Alignment.topRight,),
          borderRadius: BorderRadius.circular(10.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 4.sp,
              spreadRadius: 2.r,
            ),
          ]),
      child: SizedBox(
        width: MediaQuery.of(context).size.width / 1.18,
        child: Column(
          children: [
            ListTile(
              leading: CircleAvatar(
                radius: 40.sp,
                backgroundImage: AssetImage(
                    "assets/images/oncogems"),
              ),
              title: Text(
                "Dr. Doctor",
                style: TextStyle(
                  fontSize:28.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 30.h,
            ),
            Padding(
              padding:
              EdgeInsets.symmetric(horizontal: 10.sp),
              child: Text(
                maxLines: 2,
                "A very great and professional Doctor.Many many thanks to the doctor",
                style: TextStyle(color: Colors.black),
              ),
            )
          ],
        ),
      ),
    ),
  );
}*/

Widget _buildListItem(BuildContext context, int index) {
  DoctorInfo info = doctordata[index];
  return ClipRRect(
    borderRadius: BorderRadius.all(Radius.circular(14)),
    child: SizedBox(
      height: 290,
      width: 220.w,
      child: Card(
        color: Colors.grey.shade200,
        elevation: 12,
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Padding(
              //   padding: EdgeInsets.symmetric(horizontal: 12.w),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       CircleAvatar(radius: 35,child: Image.network(info.imagePath,fit: BoxFit.cover,),),
              //       Text(info.name),
              //     ],
              //   ),
              // ),
              ClipRRect(
                borderRadius: BorderRadius.vertical(
                    top: Radius.elliptical(13.5.r, 13.5.r)),
                child: Container(
                  height: 200.h,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.vertical(
                          top: Radius.elliptical(10.r, 10.r))),
                  child: Padding(
                    padding: EdgeInsets.only(top: 4.h),
                    child: Image.network(
                      info.imagePath,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.only(top: 8.h),
                child: Center(
                    child: Text(
                  info.name,
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                  ),
                )),
              ),

              Padding(
                padding: EdgeInsets.only(top: 8.h),
                child: Center(
                    child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text(
                    info.description,
                    style: TextStyle(
                        fontSize: 13.5.sp, fontWeight: FontWeight.normal),
                  ),
                )),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

class DoctorInfo {
  final String imagePath;
  final String name;
  final String description;
  DoctorInfo(this.imagePath, this.name, this.description);
}
