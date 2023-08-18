import 'dart:convert';
import 'package:http/http.dart' as http;

class PredictionService {
  final String baseUrl = 'http://surajpatra07.pythonanywhere.com';
  final String predictEndpoint = '/predict';

  Future<Map<String, dynamic>> makePrediction(Map<String, dynamic> data) async {
    final response = await http.post(
      Uri.parse('$baseUrl$predictEndpoint'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to make prediction.');
    }
  }
}
