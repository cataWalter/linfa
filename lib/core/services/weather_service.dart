import 'dart:convert';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

/// Weather data model
class WeatherData {
  final double temperature;
  final double feelsLike;
  final int humidity;
  final double pressure;
  final double windSpeed;
  final int cloudiness;
  final WeatherCondition condition;
  final String description;
  final DateTime timestamp;
  final String? cityName;
  final double? uvIndex;
  final double? precipitationMm;

  WeatherData({
    required this.temperature,
    required this.feelsLike,
    required this.humidity,
    required this.pressure,
    required this.windSpeed,
    required this.cloudiness,
    required this.condition,
    required this.description,
    required this.timestamp,
    this.cityName,
    this.uvIndex,
    this.precipitationMm,
  });

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
      temperature: (json['main']['temp'] as num).toDouble(),
      feelsLike: (json['main']['feels_like'] as num).toDouble(),
      humidity: json['main']['humidity'] as int,
      pressure: (json['main']['pressure'] as num).toDouble(),
      windSpeed: (json['wind']['speed'] as num).toDouble(),
      cloudiness: (json['clouds']['all'] as int?) ?? 0,
      condition: _parseCondition(json['weather'][0]['main'] as String),
      description: json['weather'][0]['description'] as String,
      timestamp: DateTime.fromMillisecondsSinceEpoch((json['dt'] as int) * 1000),
      cityName: json['name'] as String?,
    );
  }

  static WeatherCondition _parseCondition(String condition) {
    switch (condition.toLowerCase()) {
      case 'clear':
        return WeatherCondition.sunny;
      case 'clouds':
        return WeatherCondition.cloudy;
      case 'rain':
      case 'drizzle':
        return WeatherCondition.rainy;
      case 'snow':
        return WeatherCondition.snowy;
      case 'thunderstorm':
        return WeatherCondition.stormy;
      case 'mist':
      case 'fog':
      case 'haze':
        return WeatherCondition.foggy;
      default:
        return WeatherCondition.partlyCloudy;
    }
  }

  bool get isHumid => humidity > 70;
  bool get isDry => humidity < 40;
  bool get isHot => temperature > 28;
  bool get isCold => temperature < 10;
  bool get isFreezing => temperature <= 0;
}

enum WeatherCondition {
  sunny,
  partlyCloudy,
  cloudy,
  rainy,
  stormy,
  snowy,
  foggy,
}

/// Forecast data for a single day
class DailyForecast {
  final DateTime date;
  final double tempMin;
  final double tempMax;
  final WeatherCondition condition;
  final String description;
  final int humidity;
  final double? precipitationProbability;

  DailyForecast({
    required this.date,
    required this.tempMin,
    required this.tempMax,
    required this.condition,
    required this.description,
    required this.humidity,
    this.precipitationProbability,
  });
}

/// Care recommendation based on weather
class WeatherCareRecommendation {
  final String title;
  final String description;
  final RecommendationType type;
  final int priority;

  WeatherCareRecommendation({
    required this.title,
    required this.description,
    required this.type,
    this.priority = 1,
  });

  factory WeatherCareRecommendation.wateringDelay({
    required String reason,
    int priority = 2,
  }) {
    return WeatherCareRecommendation(
      title: 'Delay Watering',
      description: reason,
      type: RecommendationType.watering,
      priority: priority,
    );
  }

  factory WeatherCareRecommendation.wateringReminder({
    required String reason,
    int priority = 1,
  }) {
    return WeatherCareRecommendation(
      title: 'Water Your Plants',
      description: reason,
      type: RecommendationType.watering,
      priority: priority,
    );
  }

  factory WeatherCareRecommendation.humidityBoost({
    required String reason,
  }) {
    return WeatherCareRecommendation(
      title: 'Increase Humidity',
      description: reason,
      type: RecommendationType.humidity,
    );
  }

  factory WeatherCareRecommendation.protection({
    required String reason,
  }) {
    return WeatherCareRecommendation(
      title: 'Protect from Weather',
      description: reason,
      type: RecommendationType.protection,
    );
  }
}

enum RecommendationType {
  watering,
  humidity,
  light,
  temperature,
  protection,
  fertilizing,
}

/// Weather service for plant care recommendations
class WeatherService {
  WeatherService._();

  static final WeatherService instance = WeatherService._();

  static const String _baseUrl = 'https://api.openweathermap.org/data/2.5';
  static const String _forecastUrl = '$_baseUrl/forecast';
  static const String _currentUrl = '$_baseUrl/weather';

  // Mock data for demo purposes (no API key required)
  WeatherData? _cachedWeather;
  List<DailyForecast>? _cachedForecast;

  /// Get current weather data
  /// In production, replace with real API calls using an API key
  Future<WeatherData> getCurrentWeather({
    double? latitude,
    double? longitude,
    String? city,
  }) async {
    // Return cached data if available and recent
    if (_cachedWeather != null &&
        DateTime.now().difference(_cachedWeather!.timestamp).inMinutes < 30) {
      return _cachedWeather!;
    }

    // Generate realistic mock data based on season
    final weather = _generateMockWeather();
    _cachedWeather = weather;
    return weather;
  }

  /// Get 5-day forecast
  Future<List<DailyForecast>> getForecast({
    double? latitude,
    double? longitude,
    String? city,
  }) async {
    if (_cachedForecast != null) {
      return _cachedForecast!;
    }

    // Generate mock forecast
    final forecast = _generateMockForecast();
    _cachedForecast = forecast;
    return forecast;
  }

  /// Get care recommendations based on current weather
  Future<List<WeatherCareRecommendation>> getCareRecommendations({
    double? latitude,
    double? longitude,
  }) async {
    final weather = await getCurrentWeather(
      latitude: latitude,
      longitude: longitude,
    );

    final recommendations = <WeatherCareRecommendation>[];

    // Check for rain - delay watering
    if (weather.condition == WeatherCondition.rainy ||
        weather.condition == WeatherCondition.stormy) {
      recommendations.add(WeatherCareRecommendation.wateringDelay(
        reason:
            'Rain expected. Natural watering will take care of outdoor plants. Consider delaying scheduled watering by 1-2 days.',
        priority: 3,
      ));
    }

    // Check for dry conditions
    if (weather.isDry && weather.condition == WeatherCondition.sunny) {
      recommendations.add(WeatherCareRecommendation.wateringReminder(
        reason:
            'Low humidity (${weather.humidity}%) and sunny conditions. Plants may need extra water. Check soil moisture more frequently.',
        priority: 2,
      ));
    }

    // Check for high humidity
    if (weather.isHumid) {
      recommendations.add(WeatherCareRecommendation(
        title: 'Watch for Fungal Issues',
        description:
            'High humidity (${weather.humidity}%) can promote fungal growth. Ensure good air circulation and avoid overhead watering.',
        type: RecommendationType.protection,
      ));
    }

    // Check for freezing temperatures
    if (weather.isFreezing) {
      recommendations.add(WeatherCareRecommendation.protection(
        reason:
            'Freezing temperatures (${weather.temperature.toStringAsFixed(1)}°C). Bring sensitive plants indoors or cover outdoor plants.',
      ));
    }

    // Check for hot weather
    if (weather.isHot) {
      recommendations.add(WeatherCareRecommendation(
        title: 'Heat Protection Needed',
        description:
            'High temperatures (${weather.temperature.toStringAsFixed(1)}°C). Move plants out of direct afternoon sun and increase watering frequency.',
        type: RecommendationType.protection,
      ));
    }

    // Check for cold but not freezing
    if (weather.isCold && !weather.isFreezing) {
      recommendations.add(WeatherCareRecommendation(
        title: 'Reduce Watering',
        description:
            'Cool temperatures (${weather.temperature.toStringAsFixed(1)}°C) slow plant growth. Reduce watering frequency and avoid fertilizing.',
        type: RecommendationType.watering,
      ));
    }

    // Check for cloudy conditions
    if (weather.cloudiness > 80) {
      recommendations.add(WeatherCareRecommendation(
        title: 'Low Light Alert',
        description:
            'Overcast conditions (${weather.cloudiness}% cloud cover). Consider moving light-loving plants closer to windows or using grow lights.',
        type: RecommendationType.light,
      ));
    }

    // Sort by priority
    recommendations.sort((a, b) => b.priority.compareTo(a.priority));

    return recommendations;
  }

  /// Adjust watering schedule based on weather
  Future<int> adjustWateringFrequency({
    required int baseFrequencyDays,
    double? latitude,
    double? longitude,
  }) async {
    final weather = await getCurrentWeather(
      latitude: latitude,
      longitude: longitude,
    );

    int adjustment = 0;

    // Rainy conditions - extend interval
    if (weather.condition == WeatherCondition.rainy ||
        weather.condition == WeatherCondition.stormy) {
      adjustment += 2;
    }

    // High humidity - extend interval
    if (weather.isHumid) {
      adjustment += 1;
    }

    // Dry conditions - shorten interval
    if (weather.isDry) {
      adjustment -= 1;
    }

    // Cold weather - extend interval (slower evaporation)
    if (weather.isCold) {
      adjustment += 2;
    }

    // Hot weather - shorten interval (faster evaporation)
    if (weather.isHot) {
      adjustment -= 1;
    }

    return (baseFrequencyDays + adjustment).clamp(1, 30);
  }

  /// Generate mock weather data for demo
  WeatherData _generateMockWeather() {
    final now = DateTime.now();
    final month = now.month;

    // Seasonal temperature ranges (Northern Hemisphere)
    double baseTemp;
    if (month >= 3 && month <= 5) {
      baseTemp = 15.0 + Random().nextInt(10); // Spring
    } else if (month >= 6 && month <= 8) {
      baseTemp = 25.0 + Random().nextInt(10); // Summer
    } else if (month >= 9 && month <= 11) {
      baseTemp = 12.0 + Random().nextInt(10); // Autumn
    } else {
      baseTemp = 5.0 + Random().nextInt(10); // Winter
    }

    final conditions = [
      WeatherCondition.sunny,
      WeatherCondition.partlyCloudy,
      WeatherCondition.cloudy,
      WeatherCondition.rainy,
    ];

    return WeatherData(
      temperature: baseTemp,
      feelsLike: baseTemp + Random().nextDouble() * 2 - 1,
      humidity: 40 + Random().nextInt(40),
      pressure: 1013 + Random().nextInt(20) - 10,
      windSpeed: 2 + Random().nextDouble() * 5,
      cloudiness: Random().nextInt(100),
      condition: conditions[Random().nextInt(conditions.length)],
      description: 'Partly cloudy',
      timestamp: now,
      cityName: 'Your Location',
    );
  }

  /// Generate mock forecast data
  List<DailyForecast> _generateMockForecast() {
    final forecasts = <DailyForecast>[];
    final now = DateTime.now();

    for (int i = 0; i < 5; i++) {
      final baseTemp = 15.0 + Random().nextInt(15);
      forecasts.add(DailyForecast(
        date: now.add(Duration(days: i)),
        tempMin: baseTemp - 5 - Random().nextInt(5),
        tempMax: baseTemp + Random().nextInt(5),
        condition: [
          WeatherCondition.sunny,
          WeatherCondition.partlyCloudy,
          WeatherCondition.cloudy,
          WeatherCondition.rainy,
        ][Random().nextInt(4)],
        description: 'Variable conditions',
        humidity: 40 + Random().nextInt(40),
        precipitationProbability: Random().nextInt(100).toDouble() / 100,
      ));
    }

    return forecasts;
  }

  /// Clear cached data
  void clearCache() {
    _cachedWeather = null;
    _cachedForecast = null;
  }
}