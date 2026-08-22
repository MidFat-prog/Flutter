import 'package:flutter/foundation.dart';
import '../models/weather.dart';
import '../services/weather_service.dart';

enum WeatherStatus { initial, loading, loaded, error }

/// Holds the current weather state (initial / loading / loaded / error)
/// so WeatherScreen can just react to whichever one is current, instead
/// of managing FutureBuilder/setState wiring itself.
class WeatherProvider extends ChangeNotifier {
  final WeatherService _service = WeatherService();

  WeatherStatus _status = WeatherStatus.initial;
  Weather? _weather;
  String _errorMessage = '';
  String _lastSearchedCity = '';

  WeatherStatus get status => _status;
  Weather? get weather => _weather;
  String get errorMessage => _errorMessage;

  Future<void> fetchWeather(String city) async {
    _lastSearchedCity = city;
    _status = WeatherStatus.loading;
    notifyListeners();

    try {
      _weather = await _service.fetchWeather(city);
      _status = WeatherStatus.loaded;
    } on WeatherException catch (e) {
      _errorMessage = e.message;
      _status = WeatherStatus.error;
    } catch (_) {
      _errorMessage = 'Unexpected error. Please try again.';
      _status = WeatherStatus.error;
    }
    notifyListeners();
  }

  /// Re-runs the last search — used by the "Try Again" button on the
  /// error state, so the user doesn't have to retype the city.
  void retry() {
    if (_lastSearchedCity.isNotEmpty) {
      fetchWeather(_lastSearchedCity);
    }
  }
}