import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/wine_response.dart';

class ApiService {
  Future<WineResponse> loadWines() async {
    final String response = await rootBundle.loadString('assets/v3.json');
    final Map<String, dynamic> data = json.decode(response);
    return WineResponse.fromJson(data);
  }
}
