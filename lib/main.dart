// ignore_for_file: await_only_futures, prefer_const_constructors

import 'package:achiever/screens/onboarding%20Screens/onboarding_home_screen.dart';
import 'package:achiever/screens/splash_screen/splashScreen.dart';
import 'package:achiever/services/storage_services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await StorageService().init();
  await Get.put(WelcomeController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(360, 680),
      splitScreenMode: true,
      minTextAdapt: true,
      builder: (context, child) {
        return GetMaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.green,
          ),
          home: SplashScreen(),
        );
      },
    );
  }
}