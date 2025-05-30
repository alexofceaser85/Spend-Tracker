import 'package:flutter/material.dart'; // For BuildContext
import 'package:spend_tracker/controller/api_controllers.dart';
import 'package:spend_tracker/model/weather.dart';

class ApiServices {
  final ApiController api;

  // Private constructor
  ApiServices._default({ApiController? api}) : api = api ?? ApiController();

  // Factory constructor
  factory ApiServices() => ApiServices._default();

  // Constructor for dependency injection (e.g., for testing)
  ApiServices.withApi({required this.api});

  Future<List<Weather>> getWeather(BuildContext context) {
    return api.getWeather(context);
  }
}