import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Performance metrics data
class PerformanceMetrics {
  final Duration appStartupTime;
  final Duration? screenLoadTime;
  final int? memoryUsageKB;
  final double? cpuUsage;
  final int? frameDrops;
  final double? averageFrameTime;

  PerformanceMetrics({
    required this.appStartupTime,
    this.screenLoadTime,
    this.memoryUsageKB,
    this.cpuUsage,
    this.frameDrops,
    this.averageFrameTime,
  });
}

/// Performance optimization service
class PerformanceService {
  PerformanceService._();

  static final PerformanceService instance = PerformanceService._();

  final Map<String, DateTime> _timers = {};
  final List<Duration> _frameTimes = [];
  DateTime? _appStartTime;
  int _frameDrops = 0;

  /// Initialize performance monitoring
  void init() {
    _appStartTime = DateTime.now();

    if (kDebugMode) {
      // Monitor frame rate in debug mode
      WidgetsBinding.instance.addPostFrameCallback(_measureFrameTime);
    }
  }

  /// Start a timer for performance measurement
  void startTimer(String key) {
    _timers[key] = DateTime.now();
  }

  /// Stop a timer and return duration
  Duration? stopTimer(String key) {
    final start = _timers.remove(key);
    if (start == null) return null;
    return DateTime.now().difference(start);
  }

  /// Get app startup time
  Duration get appStartupTime {
    if (_appStartTime == null) return Duration.zero;
    return DateTime.now().difference(_appStartTime!);
  }

  /// Measure frame time for performance monitoring
  void _measureFrameCallback(Duration timestamp) {
    // Schedule next frame measurement
    WidgetsBinding.instance.addPostFrameCallback(_measureFrameCallback);

    // Target 60fps = 16.67ms per frame
    const targetFrameTime = Duration(microseconds: 16667);

    if (_frameTimes.isNotEmpty) {
      final lastFrameTime = _frameTimes.last;
      if (lastFrameTime > targetFrameTime * 1.5) {
        _frameDrops++;
      }
    }
  }

  /// Measure frame time
  void _measureFrameTime(Duration timestamp) {
    WidgetsBinding.instance.addPostFrameCallback(_measureFrameTime);
  }

  /// Get current performance metrics
  PerformanceMetrics getMetrics({
    Duration? screenLoadTime,
  }) {
    return PerformanceMetrics(
      appStartupTime: appStartupTime,
      screenLoadTime: screenLoadTime,
    );
  }

  /// Log performance metrics (debug only)
  void logMetrics({String? label}) {
    if (!kDebugMode) return;

    final metrics = getMetrics();
    debugPrint('''
=== Performance Metrics ${label != null ? '- $label' : ''} ===
App Startup Time: ${metrics.appStartupTime.inMilliseconds}ms
Screen Load Time: ${metrics.screenLoadTime?.inMilliseconds ?? 'N/A'}ms
Frame Drops: $_frameDrops
========================================''');
  }

  /// Reset performance counters
  void reset() {
    _appStartTime = DateTime.now();
    _frameDrops = 0;
    _frameTimes.clear();
    _timers.clear();
  }

  /// Check if device is low-end (basic heuristic)
  bool isLowEndDevice() {
    // This is a basic check - in production, use more sophisticated methods
    return false; // Default to false
  }

  /// Get recommended animation duration based on device performance
  Duration getAnimationDuration({
    Duration normal = const Duration(milliseconds: 300),
    Duration fast = const Duration(milliseconds: 150),
  }) {
    final isLowEnd = isLowEndDevice();
    return isLowEnd ? fast : normal;
  }

  /// Debounce function for performance optimization
  static Timer? debounce(VoidCallback action, Duration delay) {
    Timer? timer;
    timer = Timer(delay, () {
      action();
      timer?.cancel();
    });
    return timer;
  }

  /// Throttle function for performance optimization
  static Timer? throttle(VoidCallback action, Duration interval) {
    Timer? timer;
    if (timer == null || !timer.isActive) {
      action();
      timer = Timer(interval, () {});
    }
    return timer;
  }
}

/// Widget for measuring screen load performance
class PerformanceOverlay extends StatelessWidget {
  final Widget child;
  final String screenName;

  const PerformanceOverlay({
    super.key,
    required this.child,
    required this.screenName,
  });

  @override
  Widget build(BuildContext context) {
    return _PerformanceTracker(
      screenName: screenName,
      child: child,
    );
  }
}

class _PerformanceTracker extends StatefulWidget {
  final Widget child;
  final String screenName;

  const _PerformanceTracker({
    required this.child,
    required this.screenName,
  });

  @override
  State<_PerformanceTracker> createState() => _PerformanceTrackerState();
}

class _PerformanceTrackerState extends State<_PerformanceTracker> {
  @override
  void initState() {
    super.initState();
    PerformanceService.instance.startTimer(widget.screenName);
  }

  @override
  Widget build(BuildContext context) {
    return WidgetsBinding.instance.window.onReportTimings != null
        ? Builder(
            builder: (context) {
              final loadTime =
                  PerformanceService.instance.stopTimer(widget.screenName);
              if (loadTime != null) {
                PerformanceService.instance.logMetrics(
                  label: widget.screenName,
                );
              }
              return widget.child;
            },
          )
        : widget.child;
  }
}

/// Image caching strategy for performance
class ImageCacheManager {
  ImageCacheManager._();

  static final ImageCacheManager instance = ImageCacheManager._();

  /// Maximum cache size (in MB)
  static const int maxCacheSizeMB = 100;

  /// Clear image cache
  void clearCache() {
    PaintingBinding.instance.imageCache.clear();
    PaintingBinding.instance.imageCache.clearLiveImages();
  }

  /// Get current cache size
  int getCacheSize() {
    return PaintingBinding.instance.imageCache.currentSizeBytes;
  }

  /// Get cache statistics
  Map<String, dynamic> getCacheStats() {
    return {
      'currentSize': PaintingBinding.instance.imageCache.currentSizeBytes,
      'maximumSize': PaintingBinding.instance.imageCache.maximumSizeBytes,
      'pendingImages': PaintingBinding.instance.imageCache.pendingImageCount,
      'liveImages': PaintingBinding.instance.imageCache.liveImageCount,
    };
  }
}

/// Memory management utilities
class MemoryManager {
  MemoryManager._();

  static final MemoryManager instance = MemoryManager._();

  /// Trigger garbage collection (debug only)
  void gc() {
    if (kDebugMode) {
      // Note: Dart doesn't have a direct GC call
      // This is a hint to the runtime
      debugPrint('Memory management: GC suggested');
    }
  }

  /// Get memory usage estimate
  Future<Map<String, dynamic>> getMemoryInfo() async {
    // This would require platform-specific code for accurate readings
    return {
      'estimated': true,
      'note': 'Use platform channels for accurate memory info',
    };
  }

  /// Optimize memory usage
  void optimize() {
    // Clear image cache
    ImageCacheManager.instance.clearCache();

    // Suggest GC
    gc();
  }
}