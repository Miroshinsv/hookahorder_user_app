import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class StorageService extends GetxService {
  Future<void> writeToStorage(String key, dynamic data) async {
    GetStorage().write(key, data);
    GetStorage().save();
  }

  Future<dynamic> readFromStorage(String key) async {
    return await GetStorage().read(key);
  }

  Future<void> deleteFromStorage(String key) async {
    return await GetStorage().remove(key);
  }
}
