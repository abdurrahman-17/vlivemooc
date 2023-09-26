import 'package:shared_preferences/shared_preferences.dart';

class DeviceStorage {
  static SharedPreferences? sharedPreferences;
  static initialize() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  Future<SharedPreferences> getInstance() async {
    sharedPreferences ??= await SharedPreferences.getInstance();
    SharedPreferences prefs = sharedPreferences!;
    return prefs;
  }

  static const String deviceToken = "device_token";
  static const String sessionToken = "session_token";
  static const String refreshToken = "refresh_token";
  static const String deviceData = "device_data";
  static const String countryInfo = "country_info";
  static const String availabilityData = "availability_data";
  static const String purchaseListData = "purchase_list_data";
  static const String subscriptionData = "subscription_data";
  static const String subscriberData = "subscriber_data";
  static const String plans = "plans";
}
