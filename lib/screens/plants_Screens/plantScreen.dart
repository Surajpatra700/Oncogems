import 'dart:async';

import 'package:achiever/screens/plants_Screens/time_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rive/rive.dart';

class PlantScreen extends StatefulWidget {
  const PlantScreen({super.key});

  @override
  State<PlantScreen> createState() => _PlantScreenState();
}

class _PlantScreenState extends State<PlantScreen> {
  String plantButtonText = "";
  late Timer _timer;
  int _treeProgress = 0;
  int _treeMaxProgress = 60;
  Artboard? _riveArtboard;
  // late StateMachineController _controller;
  SMIInput<double>? _progress;

  @override
  void initState() {
    super.initState();
    plantButtonText = "Plant";
    rootBundle.load('assets/rive/tree_demo.riv').then((value) async {
      final file = RiveFile.import(value);
      final artboard = file.mainArtboard;
      final controller = StateMachineController.fromArtboard(artboard, 'Grow');
      if (controller != null) {
        artboard.addController(controller);
        _progress = controller.findInput('input');
        setState(() {
          _riveArtboard = artboard;
        });
      }
    });
  }

  @override
  void dispose() {
    // _controller.dispose();
    super.dispose();
  }

  void startTimer() {
    const onesec = Duration(seconds: 1);
    _timer = Timer.periodic(onesec, (timer) {
      if (_treeProgress == _treeMaxProgress) {
        stopTimer();
        plantButtonText = "plant";
        _treeProgress = 0;
        _treeMaxProgress = 60;
      } else {
        setState(() {
          _treeProgress++;
          _progress?.value = _treeProgress.toDouble();
        });
      }
    });
  }

  void stopTimer() {
    setState(() {
      _timer.cancel();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 30.h),
              child: Text(
                "Stay Foccused",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 30.sp,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 50.h,
            ),
            Center(
              child: _riveArtboard == null
                  ? SizedBox()
                  : Container(
                      width: 250.w,
                      height: 250.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(250.w / 2),
                        border: Border.all(color: Colors.white12, width: 10),
                      ),
                      child: Rive(
                        artboard: _riveArtboard!,
                        alignment: Alignment.center,
                      ),
                    ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 10.h, top: 30.h),
              child: Text(
                intToTimeLeft(_treeMaxProgress - _treeProgress).toString(),
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 10.h),
              child: Text("Time left to grow a plant",
                  style: TextStyle(
                      color: Colors.white60,
                      fontSize: 10,
                      fontWeight: FontWeight.normal)),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20.h),
              child: MaterialButton(
                onPressed: () {
                  if (_treeProgress > 0) {
                    stopTimer();
                    plantButtonText = "Plant";
                    _treeProgress = 0;
                    _treeMaxProgress = 60;
                  } else {
                    plantButtonText = "Surrender";
                    startTimer();
                  }
                },
                height: 40.h,
                minWidth: 180.w,
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                color: Colors.green,
                textColor: Colors.white,
                child: Text(plantButtonText),
                splashColor: Colors.redAccent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
