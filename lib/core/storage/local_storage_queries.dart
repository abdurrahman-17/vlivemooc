import 'package:shared_preferences/shared_preferences.dart';

import 'device_storage.dart';

class LocalStorageQueries {
  //THis is used to check
  Future<bool> isValueStoredInSharedPrefs(String key) async {
    SharedPreferences sharedPreferences = await DeviceStorage().getInstance();
    String? valueInStorage = sharedPreferences.getString(key);
    return valueInStorage != null || valueInStorage != "";
  }
}
