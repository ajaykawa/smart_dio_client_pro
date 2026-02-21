import 'package:hive_flutter/hive_flutter.dart';

class CacheService {
  static const _boxName = "apiCache";

  static Future init() async {
    await Hive.initFlutter();
    await Hive.openBox(_boxName);
  }

  static dynamic get(String key) {
    return Hive.box(_boxName).get(key);
  }

  static Future save(String key, dynamic data) async {
    await Hive.box(_boxName).put(key, data);
  }
}