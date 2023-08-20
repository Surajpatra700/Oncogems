import 'package:flutter/material.dart';


class BloodPressureScreen extends StatefulWidget {
  @override
  _BloodPressureScreenState createState() => _BloodPressureScreenState();
}

class _BloodPressureScreenState extends State<BloodPressureScreen> {
  TextEditingController systolicController = TextEditingController();
  TextEditingController diastolicController = TextEditingController();

  String result = '';

  void calculateBloodPressure() {
    // Retrieve user input for systolic and diastolic values
    final systolic = double.tryParse(systolicController.text);
    final diastolic = double.tryParse(diastolicController.text);

    // Check if both values are valid
    if (systolic != null && diastolic != null) {
      setState(() {
        result = 'Systolic: ${systolic.toStringAsFixed(2)} mmHg\nDiastolic: ${diastolic.toStringAsFixed(2)} mmHg';
      });
    } else {
      setState(() {
        result = 'Invalid input. Please enter valid numbers.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Blood Pressure Monitor'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextField(
              controller: systolicController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Systolic (mmHg)'),
            ),
            TextField(
              controller: diastolicController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Diastolic (mmHg)'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                calculateBloodPressure();
              },
              child: Text('Calculate Blood Pressure'),
            ),
            SizedBox(height: 20),
            Text(
              'Blood Pressure Result:',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              result,
              style: TextStyle(fontSize: 24),
            ),
          ],
        ),
      ),
    );
  }
}
