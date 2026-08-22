import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/weather.dart';

/// Thrown for any weather-fetch failure, with a message safe to show
/// directly to the user (no stack traces or raw exception text).
class WeatherException implements Exception {
  final String message;
  WeatherException(this.message);

  @override
  String toString() => message;
}

/// Handles all communication with the OpenWeatherMap API.
/// Kept separate from WeatherProvider (state) and WeatherScreen (UI) so
/// the networking logic has exactly one place it lives.
class WeatherService {
  // Get a free key at https://openweathermap.org/api (takes ~2 minutes,
  // no credit card needed). Paste it below.
  static const String _apiKey = '84bb8601f4c99a24bdf0e6df9c8fa1bd';

  static const String _baseUrl =
      'https://api.openweathermap.org/data/2.5/weather';

  /// Fetches current weather for [city]. Throws WeatherException with a
  /// user-friendly message on any failure (bad city, no internet, bad key).
  Future<Weather> fetchWeather(String city) async {
    if (city.trim().isEmpty) {
      throw WeatherException('Please enter a city name');
    }

    final uri = Uri.parse(
      '$_baseUrl?q=${Uri.encodeComponent(city.trim())}&appid=$_apiKey&units=metric',
    );

    http.Response response;
    try {
      response = await http.get(uri).timeout(const Duration(seconds: 10));
    } catch (_) {
      // Covers no internet connection, DNS failure, timeout, etc.
      throw WeatherException('No internet connection. Please try again.');
    }

    switch (response.statusCode) {
      case 200:
        final Map<String, dynamic> json = jsonDecode(response.body);
        return Weather.fromJson(json);
      case 404:
        throw WeatherException('City "$city" not found. Check the spelling.');
      case 401:
        throw WeatherException(
            'Invalid API key. Add your OpenWeatherMap key in weather_service.dart.');
      default:
        throw WeatherException('Something went wrong. Please try again.');
    }
  }
}