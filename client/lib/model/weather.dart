class Weather {
  final String date;
  final int temperatureC;
  final int temperatureF;
  final String summary;

  Weather({required this.date, required this.temperatureC, required this.temperatureF, required this.summary});

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      date: json['date'],
      temperatureC: json['temperatureC'],
      temperatureF: json['temperatureF'],
      summary: json['summary']
    );
  }
}