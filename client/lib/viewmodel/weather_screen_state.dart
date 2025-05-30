import 'package:flutter/material.dart';
import 'package:spend_tracker/service/api_services.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  WeatherScreenState createState() => WeatherScreenState();
}

class WeatherScreenState extends State<WeatherScreen> {
  String weatherResult = 'Press button to fetch weather';
  
  Future<void> fetchWeather() async {
    try {
      final services = ApiServices();
      
      final weatherList = await services.getWeather(context);
      final result = weatherList.map((weather) => weather.toString()).join(', ');
      
      setState(() {
        weatherResult = result.isEmpty ? 'No weather data' : result;
      });
    } catch (e) {
      setState(() {
        weatherResult = 'Error: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Weather App')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(weatherResult),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: fetchWeather,
              child: const Text('Fetch Weather'),
            ),
          ],
        ),
      ),
    );
  }
}