// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api, use_key_in_widget_constructors

import 'package:flutter/material.dart';

class WBCCountScreen extends StatefulWidget {
  @override
  _WBCCountScreenState createState() => _WBCCountScreenState();
}

class _WBCCountScreenState extends State<WBCCountScreen> {
  TextEditingController ageController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController hemoglobinController = TextEditingController();

  double wbcCount = 0.0;

  void calculateWBCCount() {
    
    
    setState(() {
      wbcCount = 6.0; 
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WBC Count Calculator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextField(
              controller: ageController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Age'),
            ),
            TextField(
              controller: genderController,
              decoration: InputDecoration(labelText: 'Gender'),
            ),
            TextField(
              controller: hemoglobinController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Hemoglobin Level'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                calculateWBCCount();
              },
              child: Text('Calculate WBC Count'),
            ),
            SizedBox(height: 20),
            Text(
              'Estimated WBC Count:',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              wbcCount.toStringAsFixed(2),
              style: TextStyle(fontSize: 24),
            ),
          ],
        ),
      ),
    );
  }
}
