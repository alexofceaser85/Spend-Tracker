import 'dart:io';

import 'package:flutter/material.dart';
import 'package:spend_tracker/model/weather.dart';
import 'package:spend_tracker/service/api_services.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Weather> weather = List.empty(growable: true);
  bool loading = false;
  String? error;

  Future<void> _getWeather() async {
    setState(() {
      loading = true;
      error = null;
    });

    try {
      final services = ApiServices();
      final receivedWeather = await services.getWeather(context);
      setState(() {
        weather = receivedWeather;
        loading = false;
      });
    } catch (e) {
      setState(() {
        error = 'Error: $e';
        loading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _getWeather();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 11, 131, 0),
        title: Text(widget.title),
      ),
      body: Center(
        child: Material(
          color: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(
              color: Color.fromARGB(255, 11, 131, 0),
              width: 2,
            ),
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(8),
            onTap: () {
              print('Icon button pressed!');
            },
            hoverColor: Color.fromARGB(50, 11, 131, 0),
            splashColor: Color.fromARGB(100, 11, 131, 0),
            child: Padding(
              padding: EdgeInsets.all(12.0),
              child: Icon(
                Icons.add,
                size: screenWidth * .1 < 100 ? 100 : screenWidth * .1,
                color: Color.fromARGB(255, 11, 131, 0),
              ),
            ),
          ),
        ),
      ),
    );
  }
}