import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:spend_tracker/model/weather.dart';

class ApiController {
  static const String baseUrl = 'http://localhost:5070';
  static const String getWeatherUrl = 'weatherforecast';

  Future<List<Weather>> getWeather(BuildContext context) async {
    try {
      final url = Uri.parse('$baseUrl/$getWeatherUrl');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as List;
        return data.map((json) => Weather.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
