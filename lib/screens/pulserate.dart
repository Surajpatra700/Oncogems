import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:math';

import 'package:flutter_screenutil/flutter_screenutil.dart';

// class PulseRateScreen extends StatefulWidget {
//   @override
//   _PulseRateScreenState createState() => _PulseRateScreenState();
// }

// class _PulseRateScreenState extends State<PulseRateScreen> {
  // double pulseRate = 70; // Initial simulated pulse rate
  // bool measuring = false;
  // late Timer timer;

  // @override
  // void initState() {
  //   super.initState();
  //   // Start simulating pulse rate measurement
  //   startMeasuring();
  // }

  // @override
  // void dispose() {
  //   // Stop the timer when the screen is disposed
  //   timer.cancel();
  //   super.dispose();
  // }

  // void startMeasuring() {
  //   // Simulate pulse rate measurement by generating random values
  //   measuring = true;
  //   timer = Timer.periodic(Duration(seconds: 2), (Timer t) {
  //     setState(() {
  //       pulseRate = Random().nextInt(30) + 60; // Simulated pulse rate between 60 and 90 bpm
  //     });
  //   });
  // }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Pulse Rate Measurement'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
            // Text(
            //   'Pulse Rate:',
            //   style: TextStyle(fontSize: 24),
            // ),
            // Text(
            //   measuring ? pulseRate.toStringAsFixed(0) + ' bpm' : 'Measuring...',
            //   style: TextStyle(fontSize: 36),
            // ),
//           ],
//         ),
//       ),
//     );
//   }
// }


// import 'package:flutter/material.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Pulse Rate Tracker',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: PulseRateScreen(),
//     );
//   }
// }

class PulseRateScreen extends StatefulWidget {
  @override
  _PulseRateScreenState createState() => _PulseRateScreenState();
}

class _PulseRateScreenState extends State<PulseRateScreen> {
  TextEditingController pulseRateController = TextEditingController();
    double pulseRate = 70; // Initial simulated pulse rate
  bool measuring = false;
  late Timer timer;

  @override
  void initState() {
    super.initState();
    // Start simulating pulse rate measurement
    startMeasuring();
  }

  @override
  void dispose() {
    // Stop the timer when the screen is disposed
    timer.cancel();
    super.dispose();
  }

  void startMeasuring() {
    // Simulate pulse rate measurement by generating random values
    measuring = true;
    timer = Timer.periodic(Duration(seconds: 2), (Timer t) {
      setState(() {
        pulseRate = Random().nextInt(30) + 60; // Simulated pulse rate between 60 and 90 bpm
      });
    });
  }

  String result = '';

  void analyzePulseRate() {
    // Retrieve user input for pulse rate
    final pulseRate = int.tryParse(pulseRateController.text);

    // Check if the value is valid
    if (pulseRate != null) {
      setState(() {
        if (pulseRate < 60) {
          result = 'Low pulse rate (Bradycardia)';
        } else if (pulseRate >= 60 && pulseRate <= 100) {
          result = 'Normal pulse rate';
        } else {
          result = 'High pulse rate (Tachycardia)';
        }
      });
    } else {
      setState(() {
        result = 'Invalid input. Please enter a valid number.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pulse Rate Tracker'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextField(
                controller: pulseRateController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Pulse Rate (bpm)'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  analyzePulseRate();
                },
                child: Text('Analyze Pulse Rate'),
              ),
              SizedBox(height: 20),
              Text(
                'Analysis Result:',
                style: TextStyle(fontSize: 18),
              ),
              Text(
                result,
                style: TextStyle(fontSize: 24),
              ),
              SizedBox(height: 60.h,),
              Center(
                child: Text(
                  'Pulse Rate:',
                  style: TextStyle(fontSize: 24),
                ),
              ),
              Center(
                child: Text(
                  measuring ? pulseRate.toStringAsFixed(0) + ' bpm' : 'Measuring...',
                  style: TextStyle(fontSize: 36,color: Color(0xff50a387)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
