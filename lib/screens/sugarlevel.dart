import 'package:flutter/material.dart';


class BloodSugarScreen extends StatefulWidget {
  @override
  _BloodSugarScreenState createState() => _BloodSugarScreenState();
}

class _BloodSugarScreenState extends State<BloodSugarScreen> {
  TextEditingController sugarLevelController = TextEditingController();

  String result = '';

  void analyzeSugarLevel() {
    // Retrieve user input for blood sugar level
    final sugarLevel = double.tryParse(sugarLevelController.text);

    // Check if the value is valid
    if (sugarLevel != null) {
      setState(() {
        if (sugarLevel < 70) {
          result = 'Low blood sugar (Hypoglycemia)';
        } else if (sugarLevel >= 70 && sugarLevel <= 180) {
          result = 'Normal blood sugar';
        } else {
          result = 'High blood sugar (Hyperglycemia)';
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
        title: Text('Blood Sugar Tracker'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextField(
              controller: sugarLevelController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Blood Sugar Level (mg/dL)'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                analyzeSugarLevel();
              },
              child: Text('Analyze Blood Sugar Level'),
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
          ],
        ),
      ),
    );
  }
}
