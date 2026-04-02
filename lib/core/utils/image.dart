import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

/// Image utility functions for Linfa
class ImageUtils {
  ImageUtils._();

  /// Get the directory for storing plant photos
  static Future<Directory> getPhotosDirectory() async {
    final appDir = await getApplicationDocumentsDirectory();
    final photosDir = Directory(path.join(appDir.path, 'photos'));
    if (!await photosDir.exists()) {
      await photosDir.create(recursive: true);
    }
    return photosDir;
  }

  /// Generate a unique file path for a new photo
  static Future<String> generatePhotoPath(String plantId, {String? extension = 'jpg'}) async {
    final photosDir = await getPhotosDirectory();
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    return path.join(photosDir.path, '${plantId}_$timestamp.$extension');
  }

  /// Generate a unique file path for a growth entry photo
  static Future<String> generateGrowthPhotoPath(String plantId, String entryId, {String? extension = 'jpg'}) async {
    final photosDir = await getPhotosDirectory();
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    return path.join(photosDir.path, '${plantId}_${entryId}_$timestamp.$extension');
  }

  /// Delete a photo file
  static Future<void> deletePhoto(String filePath) async {
    final file = File(filePath);
    if (await file.exists()) {
      await file.delete();
    }
  }

  /// Copy a photo to the app's storage
  static Future<String?> copyPhotoToStorage(String sourcePath, String plantId) async {
    try {
      final destPath = await generatePhotoPath(plantId);
      final sourceFile = File(sourcePath);
      await sourceFile.copy(destPath);
      return destPath;
    } catch (e) {
      debugPrint('Error copying photo: $e');
      return null;
    }
  }

  /// Get file size in human-readable format
  static String getFileSize(File file) {
    final bytes = file.lengthSync();
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
  }

  /// Get default plant icon based on plant type
  static IconData getPlantIcon(String? species) {
    if (species == null || species.isEmpty) {
      return Icons.eco_outlined;
    }
    final lower = species.toLowerCase();
    if (lower.contains('succulent') || lower.contains('cactus') || lower.contains('cacto')) {
      return Icons.park_outlined;
    }
    if (lower.contains('fern') || lower.contains('felce')) {
      return Icons.grass;
    }
    if (lower.contains('flower') || lower.contains('fiore')) {
      return Icons.local_florist;
    }
    if (lower.contains('tree') || lower.contains('albero')) {
      return Icons.park;
    }
    return Icons.eco_outlined;
  }

  /// Get color based on plant health
  static Color getHealthColor(int? healthRating) {
    if (healthRating == null) return Colors.grey;
    if (healthRating >= 4) return const Color(0xFF66BB6A); // Green
    if (healthRating >= 3) return const Color(0xFFFFA726); // Orange
    return const Color(0xFFEF5350); // Red
  }
}
