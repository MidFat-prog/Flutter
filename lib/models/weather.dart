/// Data model for a single weather reading, parsed from the
/// OpenWeatherMap "current weather" API response.
class Weather {
  final String cityName;
  final double temperature;
  final double feelsLike;
  final String condition;      // e.g. "Clouds", "Rain", "Clear"
  final String description;    // e.g. "scattered clouds"
  final String iconCode;       // e.g. "04d" -> used to build the icon URL
  final int humidity;
  final double windSpeed;

  Weather({
    required this.cityName,
    required this.temperature,
    required this.feelsLike,
    required this.condition,
    required this.description,
    required this.iconCode,
    required this.humidity,
    required this.windSpeed,
  });

  /// Builds a Weather object from the raw JSON map returned by the API.
  /// This is the "JSON Parsing" step: OpenWeatherMap nests most of what
  /// we need inside "main" and inside the first entry of the "weather" list.
  factory Weather.fromJson(Map<String, dynamic> json) {
    final mainData = json['main'] as Map<String, dynamic>;
    final weatherData = (json['weather'] as List).first as Map<String, dynamic>;
    final windData = json['wind'] as Map<String, dynamic>? ?? {};

    return Weather(
      cityName: json['name'] as String? ?? 'Unknown',
      temperature: (mainData['temp'] as num).toDouble(),
      feelsLike: (mainData['feels_like'] as num).toDouble(),
      condition: weatherData['main'] as String? ?? '',
      description: weatherData['description'] as String? ?? '',
      iconCode: weatherData['icon'] as String? ?? '01d',
      humidity: (mainData['humidity'] as num?)?.toInt() ?? 0,
      windSpeed: (windData['speed'] as num?)?.toDouble() ?? 0,
    );
  }

  /// OpenWeatherMap serves icon images directly from a code like "10d".
  /// @2x gives a sharper image for modern screens.
  String get iconUrl => 'https://openweathermap.org/img/wn/$iconCode@2x.png';
}