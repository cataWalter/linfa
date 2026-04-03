import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:linfa/core/services/performance_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('PerformanceMetrics', () {
    test('should create with all fields', () {
      final metrics = PerformanceMetrics(
        appStartupTime: const Duration(seconds: 2),
        screenLoadTime: const Duration(milliseconds: 500),
        memoryUsageKB: 1024,
        cpuUsage: 45.5,
        frameDrops: 3,
        averageFrameTime: 16.5,
      );

      expect(metrics.appStartupTime, const Duration(seconds: 2));
      expect(metrics.screenLoadTime, const Duration(milliseconds: 500));
      expect(metrics.memoryUsageKB, 1024);
      expect(metrics.cpuUsage, 45.5);
      expect(metrics.frameDrops, 3);
      expect(metrics.averageFrameTime, 16.5);
    });

    test('should create with required fields only', () {
      final metrics = PerformanceMetrics(
        appStartupTime: const Duration(seconds: 1),
      );

      expect(metrics.appStartupTime, const Duration(seconds: 1));
      expect(metrics.screenLoadTime, isNull);
      expect(metrics.memoryUsageKB, isNull);
      expect(metrics.cpuUsage, isNull);
      expect(metrics.frameDrops, isNull);
      expect(metrics.averageFrameTime, isNull);
    });
  });

  group('PerformanceService', () {
    late PerformanceService service;

    setUp(() {
      service = PerformanceService.instance;
    });

    group('singleton', () {
      test('should return same instance', () {
        final instance1 = PerformanceService.instance;
        final instance2 = PerformanceService.instance;
        expect(identical(instance1, instance2), isTrue);
      });
    });

    group('init', () {
      test('should initialize without throwing', () {
        expect(() => service.init(), returnsNormally);
      });
    });

    group('startTimer and stopTimer', () {
      test('should start and stop timer', () {
        service.startTimer('test');
        final duration = service.stopTimer('test');

        expect(duration, isA<Duration>());
      });

      test('should return null for non-existent timer', () {
        final duration = service.stopTimer('nonexistent');
        expect(duration, isNull);
      });

      test('should measure elapsed time correctly', () async {
        service.startTimer('measure');
        await Future.delayed(const Duration(milliseconds: 50));
        final duration = service.stopTimer('measure');

        expect(duration!.inMilliseconds, greaterThanOrEqualTo(50));
      });
    });

    group('appStartupTime', () {
      test('should return positive duration after init', () async {
        service.init();
        await Future.delayed(const Duration(milliseconds: 10));

        expect(service.appStartupTime.inMilliseconds, greaterThan(0));
      });
    });

    group('getMetrics', () {
      test('should return PerformanceMetrics', () {
        final metrics = service.getMetrics();
        expect(metrics, isA<PerformanceMetrics>());
      });

      test('should include screenLoadTime when provided', () {
        final screenLoadTime = const Duration(milliseconds: 100);
        final metrics = service.getMetrics(screenLoadTime: screenLoadTime);

        expect(metrics.screenLoadTime, screenLoadTime);
      });
    });

    group('logMetrics', () {
      test('should not throw in debug mode', () {
        expect(() => service.logMetrics(), returnsNormally);
      });

      test('should not throw with label', () {
        expect(() => service.logMetrics(label: 'Test'), returnsNormally);
      });
    });

    group('reset', () {
      test('should reset without throwing', () {
        service.init();
        service.startTimer('test');
        expect(() => service.reset(), returnsNormally);
      });
    });

    group('isLowEndDevice', () {
      test('should return false by default', () {
        expect(service.isLowEndDevice(), isFalse);
      });
    });

    group('getAnimationDuration', () {
      test('should return normal duration by default', () {
        final normal = const Duration(milliseconds: 300);
        final fast = const Duration(milliseconds: 150);

        final result = service.getAnimationDuration(normal: normal, fast: fast);

        expect(result, normal);
      });
    });

    group('debounce', () {
      test('should return a Timer', () async {
        var called = false;
        final timer = PerformanceService.debounce(() {
          called = true;
        }, const Duration(milliseconds: 10));

        expect(timer, isNotNull);
        await Future.delayed(const Duration(milliseconds: 20));
        expect(called, isTrue);
      });
    });

    group('throttle', () {
      test('should return a Timer', () {
        var called = false;
        final timer = PerformanceService.throttle(() {
          called = true;
        }, const Duration(milliseconds: 100));

        expect(timer, isNotNull);
        expect(called, isTrue);
      });
    });
  });

  group('ImageCacheManager', () {
    late ImageCacheManager manager;

    setUp(() {
      manager = ImageCacheManager.instance;
    });

    group('singleton', () {
      test('should return same instance', () {
        final instance1 = ImageCacheManager.instance;
        final instance2 = ImageCacheManager.instance;
        expect(identical(instance1, instance2), isTrue);
      });
    });

    group('clearCache', () {
      test('should not throw', () {
        expect(() => manager.clearCache(), returnsNormally);
      });
    });

    group('getCacheSize', () {
      test('should return non-negative value', () {
        final size = manager.getCacheSize();
        expect(size, greaterThanOrEqualTo(0));
      });
    });

    group('getCacheStats', () {
      test('should return map with expected keys', () {
        final stats = manager.getCacheStats();

        expect(stats, isA<Map<String, dynamic>>());
        expect(stats.containsKey('currentSize'), isTrue);
        expect(stats.containsKey('maximumSize'), isTrue);
        expect(stats.containsKey('pendingImages'), isTrue);
        expect(stats.containsKey('liveImages'), isTrue);
      });
    });
  });

  group('MemoryManager', () {
    late MemoryManager manager;

    setUp(() {
      manager = MemoryManager.instance;
    });

    group('singleton', () {
      test('should return same instance', () {
        final instance1 = MemoryManager.instance;
        final instance2 = MemoryManager.instance;
        expect(identical(instance1, instance2), isTrue);
      });
    });

    group('gc', () {
      test('should not throw', () {
        expect(() => manager.gc(), returnsNormally);
      });
    });

    group('getMemoryInfo', () {
      test('should return map with expected keys', () async {
        final info = await manager.getMemoryInfo();

        expect(info, isA<Map<String, dynamic>>());
        expect(info.containsKey('estimated'), isTrue);
        expect(info['estimated'], isTrue);
      });
    });

    group('optimize', () {
      test('should not throw', () {
        expect(() => manager.optimize(), returnsNormally);
      });
    });
  });

  // PerformanceOverlay widget is tested in integration tests due to naming conflict
  // with Flutter's built-in PerformanceOverlay widget
}