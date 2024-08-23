import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:task_todo/app/core/keys.dart';

class StorageService extends GetxService {
  late GetStorage _box;

  Future<StorageService> init() async {
    _box = GetStorage();
    //await _box.write(Keys.taskKey, []);
    await _box.writeIfNull(Keys.taskKey, []);
    return this;
  }

  T read<T>(String key) {
    return _box.read(key);
  }

  void write<T>(String key, T value) async {
    await _box.write(key, value);
  }
}
