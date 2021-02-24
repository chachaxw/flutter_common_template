import 'dart:io';

import 'package:path_provider/path_provider.dart';

class CacheManager {
  static Future<String> loadCache() async {
    Directory tempDir = await getTemporaryDirectory();
    double value = await _getTotalSizeOfFilesInDir(tempDir);
    return _renderSize(value);
  }

  static Future<double> _getTotalSizeOfFilesInDir(
      final FileSystemEntity file) async {
    if (file is File) {
      int length = await file.length();
      return double.parse(length.toString());
    }

    if (file is Directory && file.existsSync()) {
      final List<FileSystemEntity>? children = file.listSync();
      double total = 0;

      if (children != null)
        for (final FileSystemEntity child in children)
          total += await _getTotalSizeOfFilesInDir(child);
      return total;
    }

    return 0;
  }

  static String _renderSize(double value) {
    List<String> unitArr = ['B', 'KB', 'MB', 'GB'];
    int index = 0;

    while (value > 1024) {
      index++;
      value = value / 1024;
    }

    String size = value.toStringAsFixed(2);
    return size + unitArr[index];
  }

  static Future<void> clearCache() async {
    Directory tempDir = await getTemporaryDirectory();
    await _deleteDir(tempDir);
  }

  static Future<Null> _deleteDir(FileSystemEntity file) async {
    if (file is Directory && file.existsSync()) {
      final List<FileSystemEntity> list = file.listSync();

      for (final FileSystemEntity item in list) {
        await _deleteDir(item);
      }
    }
    await file.delete();
  }
}
