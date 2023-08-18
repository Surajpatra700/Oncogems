import 'package:achiever/services/liver_prediction%20ML%20Model/predict_service.dart';
import 'package:flutter/material.dart';

class PredictionScreen extends StatefulWidget {
  @override
  _PredictionScreenState createState() => _PredictionScreenState();
}

class _PredictionScreenState extends State<PredictionScreen> {
  final PredictionService predictionService = PredictionService();
  Map<String, dynamic> inputData = {
    "Bleed": 1,
    "Cirrhosis": 0,
    "Size": 53.355,
    "HCC_TNM_Stage": 3,
    "ICC_TNM_stage": 2,
    "Survival_from™DM": 1.20,
    "Surveillance_effectiveness": 2,
    "PS": 1,
    "Prev_known_cirrhosis": 1
  };

  Map<String, dynamic> predictionResult = {};

  @override
  void initState() {
    super.initState();
    makePrediction();
  }

  Future<void> makePrediction() async {
    try {
      final result = await predictionService.makePrediction(inputData);
      setState(() {
        predictionResult = result;
      });
    } catch (error) {
      print('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Prediction Result'),
      ),
      body: Center(
        child: predictionResult.isNotEmpty
            ? Text('Prediction Result: $predictionResult')
            : CircularProgressIndicator(),
      ),
    );
  }
}
