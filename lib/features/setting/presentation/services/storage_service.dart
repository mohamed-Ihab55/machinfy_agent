import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:machinfy_agent/core/constants.dart';
import 'package:machinfy_agent/core/typography.dart';

class StorageService {
  /// Calculate folder size in MB
  static Future<double> _getFolderSize(Directory dir) async {
    double size = 0;
    try {
      if (await dir.exists()) {
        for (var file in dir.listSync(recursive: true, followLinks: false)) {
          if (file is File) size += await file.length();
        }
      }
    } catch (e) {
      debugPrint('Error calculating folder size: $e');
    }
    return size / (1024 * 1024);
  }

  /// Calculate storage info
  static Future<Map<String, double>> calculateStorage() async {
    final appDir = await getApplicationDocumentsDirectory();
    final cacheDir = await getTemporaryDirectory();

    final docsSize = await _getFolderSize(appDir);
    final cacheSize = await _getFolderSize(cacheDir);

    return {
      'Chat History': 0, // Add chat folder logic if needed
      'Downloaded Files': docsSize,
      'Cache': cacheSize,
      'Media': 0,
    };
  }

  /// Clear cache
  static Future<void> clearCache() async {
    final cacheDir = await getTemporaryDirectory();
    try {
      if (await cacheDir.exists()) {
        await cacheDir.delete(recursive: true);
        await cacheDir.create();
      }
    } catch (e) {
      debugPrint('Error clearing cache: $e');
    }
  }

  /// Show confirmation dialog
  static Future<bool?> showConfirmDialog(
      BuildContext context, String title, String message) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        backgroundColor: const Color(0xff0062C5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(title, style: Style.bodysmall.copyWith(color: Colors.white)),
        content: Text(message, style: Style.bodysmall.copyWith(color: Colors.white)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text('Cancel', style: Style.bodysmall.copyWith(color: Colors.white)),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(foregroundColor: kErrorColor),
            child: const Text('Continue', style: Style.bodysmall),
          ),
        ],
      ),
    );
  }
}