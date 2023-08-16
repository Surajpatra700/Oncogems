// ignore_for_file: prefer_const_constructors, unnecessary_const

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';

List<String> domains = [
  "Scan","form","Report",
];
List<String> measurement = [
  "Pulse rate",
  "WBC Count",
  "Blood Pressure",
  "Sugar"
];
List domainimage=[
  "scan.jpg",
  "forms.jpg",
  "report.jpg",
];
List image=[
  "pulserate.png",
  "wbc.png",
  "heart.png",
  "sugar.png",
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
         /* SizedBox(
            height: 210.h,
            child: ScrollSnapList(
              itemBuilder: _buildListItem,
              itemCount: 4,
              itemSize: 210.h,
              onItemFocus: (index) {},
              dynamicItemSize: true,
              scrollDirection: Axis.horizontal,
            ),
          ),*/
          SizedBox(
              height: 210.h,
              child: ListView.builder(
                  itemCount: 4,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return InkWell(
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
                  })),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {
                
              },
              child: Text("See all",
                  style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF7165D6))),
            ),
          ),
          SizedBox(
            height: 0,
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 15.sp,
            ),
            child: Text(
             "Features",
              style: TextStyle(
                fontSize: 22.sp,
                fontWeight: FontWeight.w600,
                color: Colors.black54,
              ),
            ),
          ),
          SizedBox(
            height: 125.h,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: domains.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 9.sp, horizontal: 10.sp),
                  padding: EdgeInsets.symmetric(horizontal: 25.sp),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors:[Colors.green,Colors.white] ,begin: Alignment.bottomLeft,
                      end: Alignment.topRight,),
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
                          radius: 35.sp,
                          backgroundImage:
                          AssetImage("assets/images/${domainimage[index]}"),
                        ),
                        Text(
                          domains[index],
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.black54,
                          ),
                        ),
                      ],
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
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black54,
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

                },
                child: Container(
                  margin: EdgeInsets.all(10.sp),
                  padding: EdgeInsets.symmetric(vertical: 15.sp),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors:[Colors.green,Colors.white] ,begin: Alignment.bottomLeft,
                        end: Alignment.topRight,),
                      borderRadius: BorderRadius.circular(30.sp),
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
                          color: Colors.black54,
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
