import 'package:flutter_test/flutter_test.dart';
import 'package:smart_dio_client/src/cache_service.dart';

void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();

  await CacheService.init();

  test('Cache saves and retrieves data', () async {
    await CacheService.save("test", {"name": "Ajay"});
    final data = CacheService.get("test");

    expect(data["name"], "Ajay");
  });
}