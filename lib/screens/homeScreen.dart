// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:achiever/screens/achievement.dart';
import 'package:achiever/screens/homePage.dart';
import 'package:achiever/screens/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _index = 0;
  PageController pageController = PageController();

  List screens = [
    HomePage(),
    AchievementScreen(),
    ProfileScreen(),
  ];

  Widget buildAppBar() {
    return AppBar(
      elevation: 2.5,
      backgroundColor: Color(0xff50a387),
      automaticallyImplyLeading: false,
      title: Padding(
        padding: EdgeInsets.only(top: 4.h),
        child: Text(
          "Achiever",
          style: TextStyle(
              fontSize: 24.5.sp,
              fontWeight: FontWeight.w700,
              color: Colors.white),
        ),
      ),
      actions: [
        Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(right: 8.w,top: 8.h),
              child: InkWell(
                onTap: (){

                },
                child: CircleAvatar(
                  radius: 23,
                  backgroundColor: Colors.white,
                  child: Container(
                    margin: EdgeInsets.all(3.2),
                    child: Image.network("https://cdn-icons-png.flaticon.com/512/490/490091.png",fit: BoxFit.contain,)),
                ),
              ),
            ),
            Positioned(
              bottom: 0.5.h,
              right: 2.w,
              child: CircleAvatar(
                radius: 10,
                backgroundColor: Colors.grey.shade400,
                child: Center(
                  child: Text("3",style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600, color: Color.fromARGB(255, 6, 104, 10)),),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 680),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return Scaffold(
          appBar: PreferredSize(
              preferredSize: Size.fromHeight(63.h), child: buildAppBar()),
          body: PageView.builder(
              itemCount: 3,
              controller: pageController,
              onPageChanged: (page) {
                setState(() {
                  _index = page;
                });
              },
              itemBuilder: (context, position) {
                return Container(
                  child: screens[position],
                );
              }),
          bottomNavigationBar: SafeArea(
            child: Container(
              color: Color(0xff50a387),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5),
                child: GNav(
                  curve: Curves.fastOutSlowIn,
                  duration: Duration(milliseconds: 350),
                  backgroundColor: Color(0xff50a387),
                  tabBackgroundColor: Color.fromARGB(255, 72, 201, 76),
                  padding: EdgeInsets.all(16),
                  color: Colors.white,
                  activeColor: Colors.white,
                  gap: 8,
                  tabs: [
                    GButton(
                      icon: Icons.home,
                      text: 'Home',
                      iconActiveColor: Colors.white,
                      iconColor: Colors.white70,
                    ),
                    GButton(
                      icon: Icons.card_giftcard,
                      text: 'Achievement',
                      iconActiveColor: Colors.white,
                      iconColor: Colors.white70,
                    ),
                    GButton(
                      icon: Icons.person,
                      text: 'Profile',
                      iconActiveColor: Colors.white,
                      iconColor: Colors.white70,
                    ),
                  ],
                  selectedIndex: _index,
                  onTabChange: (index) {
                    setState(() {
                      _index = index;
                    });
                    pageController.jumpToPage(index);
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
