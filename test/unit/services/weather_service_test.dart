import 'package:flutter_test/flutter_test.dart';
import 'package:linfa/core/services/weather_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('WeatherCondition', () {
    test('should have all expected values', () {
      expect(WeatherCondition.values.length, 7);
      expect(WeatherCondition.values, contains(WeatherCondition.sunny));
      expect(WeatherCondition.values, contains(WeatherCondition.partlyCloudy));
      expect(WeatherCondition.values, contains(WeatherCondition.cloudy));
      expect(WeatherCondition.values, contains(WeatherCondition.rainy));
      expect(WeatherCondition.values, contains(WeatherCondition.stormy));
      expect(WeatherCondition.values, contains(WeatherCondition.snowy));
      expect(WeatherCondition.values, contains(WeatherCondition.foggy));
    });
  });

  group('RecommendationType', () {
    test('should have all expected values', () {
      expect(RecommendationType.values.length, 6);
      expect(RecommendationType.values, contains(RecommendationType.watering));
      expect(RecommendationType.values, contains(RecommendationType.humidity));
      expect(RecommendationType.values, contains(RecommendationType.light));
      expect(RecommendationType.values, contains(RecommendationType.temperature));
      expect(RecommendationType.values, contains(RecommendationType.protection));
      expect(RecommendationType.values, contains(RecommendationType.fertilizing));
    });
  });

  group('WeatherData', () {
    test('should create with all fields', () {
      final weather = WeatherData(
        temperature: 25.0,
        feelsLike: 26.0,
        humidity: 60,
        pressure: 1013.25,
        windSpeed: 5.5,
        cloudiness: 30,
        condition: WeatherCondition.sunny,
        description: 'Sunny',
        timestamp: DateTime.now(),
        cityName: 'Test City',
        uvIndex: 7.0,
        precipitationMm: 0.0,
      );

      expect(weather.temperature, 25.0);
      expect(weather.feelsLike, 26.0);
      expect(weather.humidity, 60);
      expect(weather.pressure, 1013.25);
      expect(weather.windSpeed, 5.5);
      expect(weather.cloudiness, 30);
      expect(weather.condition, WeatherCondition.sunny);
      expect(weather.description, 'Sunny');
      expect(weather.cityName, 'Test City');
      expect(weather.uvIndex, 7.0);
      expect(weather.precipitationMm, 0.0);
    });

    group('computed properties', () {
      test('isHumid should return true when humidity > 70', () {
        final weather = WeatherData(
          temperature: 25.0,
          feelsLike: 25.0,
          humidity: 75,
          pressure: 1013.0,
          windSpeed: 5.0,
          cloudiness: 50,
          condition: WeatherCondition.sunny,
          description: 'Sunny',
          timestamp: DateTime.now(),
        );

        expect(weather.isHumid, isTrue);
      });

      test('isHumid should return false when humidity <= 70', () {
        final weather = WeatherData(
          temperature: 25.0,
          feelsLike: 25.0,
          humidity: 65,
          pressure: 1013.0,
          windSpeed: 5.0,
          cloudiness: 50,
          condition: WeatherCondition.sunny,
          description: 'Sunny',
          timestamp: DateTime.now(),
        );

        expect(weather.isHumid, isFalse);
      });

      test('isDry should return true when humidity < 40', () {
        final weather = WeatherData(
          temperature: 25.0,
          feelsLike: 25.0,
          humidity: 35,
          pressure: 1013.0,
          windSpeed: 5.0,
          cloudiness: 50,
          condition: WeatherCondition.sunny,
          description: 'Sunny',
          timestamp: DateTime.now(),
        );

        expect(weather.isDry, isTrue);
      });

      test('isDry should return false when humidity >= 40', () {
        final weather = WeatherData(
          temperature: 25.0,
          feelsLike: 25.0,
          humidity: 45,
          pressure: 1013.0,
          windSpeed: 5.0,
          cloudiness: 50,
          condition: WeatherCondition.sunny,
          description: 'Sunny',
          timestamp: DateTime.now(),
        );

        expect(weather.isDry, isFalse);
      });

      test('isHot should return true when temperature > 28', () {
        final weather = WeatherData(
          temperature: 30.0,
          feelsLike: 30.0,
          humidity: 50,
          pressure: 1013.0,
          windSpeed: 5.0,
          cloudiness: 50,
          condition: WeatherCondition.sunny,
          description: 'Sunny',
          timestamp: DateTime.now(),
        );

        expect(weather.isHot, isTrue);
      });

      test('isHot should return false when temperature <= 28', () {
        final weather = WeatherData(
          temperature: 25.0,
          feelsLike: 25.0,
          humidity: 50,
          pressure: 1013.0,
          windSpeed: 5.0,
          cloudiness: 50,
          condition: WeatherCondition.sunny,
          description: 'Sunny',
          timestamp: DateTime.now(),
        );

        expect(weather.isHot, isFalse);
      });

      test('isCold should return true when temperature < 10', () {
        final weather = WeatherData(
          temperature: 5.0,
          feelsLike: 3.0,
          humidity: 50,
          pressure: 1013.0,
          windSpeed: 5.0,
          cloudiness: 50,
          condition: WeatherCondition.sunny,
          description: 'Cold',
          timestamp: DateTime.now(),
        );

        expect(weather.isCold, isTrue);
      });

      test('isCold should return false when temperature >= 10', () {
        final weather = WeatherData(
          temperature: 15.0,
          feelsLike: 15.0,
          humidity: 50,
          pressure: 1013.0,
          windSpeed: 5.0,
          cloudiness: 50,
          condition: WeatherCondition.sunny,
          description: 'Cool',
          timestamp: DateTime.now(),
        );

        expect(weather.isCold, isFalse);
      });

      test('isFreezing should return true when temperature <= 0', () {
        final weather = WeatherData(
          temperature: -2.0,
          feelsLike: -5.0,
          humidity: 50,
          pressure: 1013.0,
          windSpeed: 5.0,
          cloudiness: 50,
          condition: WeatherCondition.snowy,
          description: 'Freezing',
          timestamp: DateTime.now(),
        );

        expect(weather.isFreezing, isTrue);
      });

      test('isFreezing should return false when temperature > 0', () {
        final weather = WeatherData(
          temperature: 2.0,
          feelsLike: 0.0,
          humidity: 50,
          pressure: 1013.0,
          windSpeed: 5.0,
          cloudiness: 50,
          condition: WeatherCondition.cloudy,
          description: 'Cold',
          timestamp: DateTime.now(),
        );

        expect(weather.isFreezing, isFalse);
      });
    });

    group('fromJson', () {
      test('should parse weather data from JSON', () {
        final json = {
          'main': {
            'temp': 25.0,
            'feels_like': 26.0,
            'humidity': 60,
            'pressure': 1013.25,
          },
          'wind': {
            'speed': 5.5,
          },
          'clouds': {
            'all': 30,
          },
          'weather': [
            {
              'main': 'Clear',
              'description': 'Sunny',
            },
          ],
          'dt': 1700000000,
          'name': 'Test City',
        };

        final weather = WeatherData.fromJson(json);

        expect(weather.temperature, 25.0);
        expect(weather.feelsLike, 26.0);
        expect(weather.humidity, 60);
        expect(weather.pressure, 1013.25);
        expect(weather.windSpeed, 5.5);
        expect(weather.cloudiness, 30);
        expect(weather.condition, WeatherCondition.sunny);
        expect(weather.description, 'Sunny');
        expect(weather.cityName, 'Test City');
      });

      test('should handle missing clouds with null coalescing', () {
        final json = {
          'main': {
            'temp': 25.0,
            'feels_like': 26.0,
            'humidity': 60,
            'pressure': 1013.25,
          },
          'wind': {
            'speed': 5.5,
          },
          'clouds': {
            'all': null,
          },
          'weather': [
            {
              'main': 'Clear',
              'description': 'Sunny',
            },
          ],
          'dt': 1700000000,
          'name': 'Test City',
        };

        final weather = WeatherData.fromJson(json);
        expect(weather.cloudiness, 0);
      });

      test('should parse different weather conditions', () {
        // Test rain
        final rainJson = {
          'main': {'temp': 15.0, 'feels_like': 14.0, 'humidity': 80, 'pressure': 1010.0},
          'wind': {'speed': 10.0},
          'clouds': {'all': 90},
          'weather': [{'main': 'Rain', 'description': 'Rainy'}],
          'dt': 1700000000,
          'name': 'Test',
        };
        expect(WeatherData.fromJson(rainJson).condition, WeatherCondition.rainy);

        // Test snow
        final snowJson = {
          'main': {'temp': -5.0, 'feels_like': -8.0, 'humidity': 70, 'pressure': 1020.0},
          'wind': {'speed': 5.0},
          'clouds': {'all': 100},
          'weather': [{'main': 'Snow', 'description': 'Snowy'}],
          'dt': 1700000000,
          'name': 'Test',
        };
        expect(WeatherData.fromJson(snowJson).condition, WeatherCondition.snowy);

        // Test thunderstorm
        final stormJson = {
          'main': {'temp': 20.0, 'feels_like': 22.0, 'humidity': 90, 'pressure': 1005.0},
          'wind': {'speed': 20.0},
          'clouds': {'all': 100},
          'weather': [{'main': 'Thunderstorm', 'description': 'Stormy'}],
          'dt': 1700000000,
          'name': 'Test',
        };
        expect(WeatherData.fromJson(stormJson).condition, WeatherCondition.stormy);

        // Test fog
        final fogJson = {
          'main': {'temp': 10.0, 'feels_like': 8.0, 'humidity': 95, 'pressure': 1015.0},
          'wind': {'speed': 2.0},
          'clouds': {'all': 100},
          'weather': [{'main': 'Fog', 'description': 'Foggy'}],
          'dt': 1700000000,
          'name': 'Test',
        };
        expect(WeatherData.fromJson(fogJson).condition, WeatherCondition.foggy);

        // Test default (unknown condition)
        final defaultJson = {
          'main': {'temp': 15.0, 'feels_like': 15.0, 'humidity': 50, 'pressure': 1013.0},
          'wind': {'speed': 5.0},
          'clouds': {'all': 50},
          'weather': [{'main': 'Unknown', 'description': 'Unknown'}],
          'dt': 1700000000,
          'name': 'Test',
        };
        expect(WeatherData.fromJson(defaultJson).condition, WeatherCondition.partlyCloudy);
      });
    });
  });

  group('DailyForecast', () {
    test('should create with all fields', () {
      final forecast = DailyForecast(
        date: DateTime.now(),
        tempMin: 10.0,
        tempMax: 20.0,
        condition: WeatherCondition.partlyCloudy,
        description: 'Partly cloudy',
        humidity: 55,
        precipitationProbability: 0.2,
      );

      expect(forecast.date, isA<DateTime>());
      expect(forecast.tempMin, 10.0);
      expect(forecast.tempMax, 20.0);
      expect(forecast.condition, WeatherCondition.partlyCloudy);
      expect(forecast.description, 'Partly cloudy');
      expect(forecast.humidity, 55);
      expect(forecast.precipitationProbability, 0.2);
    });
  });

  group('WeatherCareRecommendation', () {
    test('should create with all fields', () {
      final recommendation = WeatherCareRecommendation(
        title: 'Test',
        description: 'Test description',
        type: RecommendationType.watering,
        priority: 2,
      );

      expect(recommendation.title, 'Test');
      expect(recommendation.description, 'Test description');
      expect(recommendation.type, RecommendationType.watering);
      expect(recommendation.priority, 2);
    });

    test('should default priority to 1', () {
      final recommendation = WeatherCareRecommendation(
        title: 'Test',
        description: 'Test description',
        type: RecommendationType.watering,
      );

      expect(recommendation.priority, 1);
    });

    group('factory constructors', () {
      test('wateringDelay should create correct recommendation', () {
        final rec = WeatherCareRecommendation.wateringDelay(reason: 'Rain expected');

        expect(rec.title, 'Delay Watering');
        expect(rec.description, 'Rain expected');
        expect(rec.type, RecommendationType.watering);
        expect(rec.priority, 2);
      });

      test('wateringReminder should create correct recommendation', () {
        final rec = WeatherCareRecommendation.wateringReminder(reason: 'Dry soil');

        expect(rec.title, 'Water Your Plants');
        expect(rec.description, 'Dry soil');
        expect(rec.type, RecommendationType.watering);
        expect(rec.priority, 1);
      });

      test('humidityBoost should create correct recommendation', () {
        final rec = WeatherCareRecommendation.humidityBoost(reason: 'Low humidity');

        expect(rec.title, 'Increase Humidity');
        expect(rec.description, 'Low humidity');
        expect(rec.type, RecommendationType.humidity);
      });

      test('protection should create correct recommendation', () {
        final rec = WeatherCareRecommendation.protection(reason: 'Frost warning');

        expect(rec.title, 'Protect from Weather');
        expect(rec.description, 'Frost warning');
        expect(rec.type, RecommendationType.protection);
      });
    });
  });

  group('WeatherService', () {
    late WeatherService service;

    setUp(() {
      service = WeatherService.instance;
    });

    group('singleton', () {
      test('should return same instance', () {
        final instance1 = WeatherService.instance;
        final instance2 = WeatherService.instance;
        expect(identical(instance1, instance2), isTrue);
      });
    });

    group('getCurrentWeather', () {
      test('should return WeatherData', () async {
        final weather = await service.getCurrentWeather();
        expect(weather, isA<WeatherData>());
      });

      test('should cache weather data', () async {
        service.clearCache();
        final weather1 = await service.getCurrentWeather();
        final weather2 = await service.getCurrentWeather();

        // Should return cached data
        expect(weather1.timestamp, weather2.timestamp);
      });
    });

    group('getForecast', () {
      test('should return list of DailyForecast', () async {
        service.clearCache();
        final forecast = await service.getForecast();

        expect(forecast, isA<List<DailyForecast>>());
        expect(forecast.length, 5);
      });

      test('should cache forecast data', () async {
        service.clearCache();
        final forecast1 = await service.getForecast();
        final forecast2 = await service.getForecast();

        expect(forecast1.length, forecast2.length);
      });
    });

    group('getCareRecommendations', () {
      test('should return list of recommendations', () async {
        service.clearCache();
        final recommendations = await service.getCareRecommendations();

        expect(recommendations, isA<List<WeatherCareRecommendation>>());
      });
    });

    group('adjustWateringFrequency', () {
      test('should return adjusted frequency', () async {
        service.clearCache();
        final frequency = await service.adjustWateringFrequency(
          baseFrequencyDays: 3,
        );

        expect(frequency, isA<int>());
        expect(frequency, greaterThanOrEqualTo(1));
        expect(frequency, lessThanOrEqualTo(30));
      });
    });

    group('clearCache', () {
      test('should clear cached data', () async {
        await service.getCurrentWeather();
        service.clearCache();

        // After clearing, should fetch new data
        final weather = await service.getCurrentWeather();
        expect(weather, isA<WeatherData>());
      });
    });
  });
}