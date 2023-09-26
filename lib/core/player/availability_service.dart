import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:vlivemooc/core/models/availability/availability_model/availability_model.dart';
import 'package:vlivemooc/core/models/content/content_model/datum.dart'
    as contentmodel;

import 'package:vlivemooc/core/network/network_handler.dart';
import 'package:vlivemooc/core/storage/device_storage.dart';

import '../models/availability/availability_model/datum.dart';

class AvailabilityService {
  static String free = "FREE";
  static String plan = "PLAN";
  static String paid = "PAID";
  static String rental = "RENTAL";
  static String notsubscribed = "NOTSUBSCRIBED";

  Future<String> initializeAvailability() async {
    //print("initializing availability...");
    SharedPreferences sharedPreferences = await DeviceStorage().getInstance();
    String savedAvailability =
        sharedPreferences.getString(DeviceStorage.availabilityData) ?? "";
    if (savedAvailability.isNotEmpty) {
      return savedAvailability;
    }
    //print("before fetching availability...");

    AvailabilityModel data = await NetworkHandler.fetchAvailability();
    String dataString = jsonEncode(data.toMap());
    sharedPreferences.setString(DeviceStorage.availabilityData, dataString);
    return dataString;
  }

  Future<String> checkAvailability(contentmodel.Datum content) async {
    SharedPreferences sharedPreferences = await DeviceStorage().getInstance();
    String availabilityData =
        sharedPreferences.getString(DeviceStorage.availabilityData) ?? "";
    if (availabilityData.isEmpty) {
      availabilityData = await initializeAvailability();
    }
    //print(availabilityData);
    var availabilityJSON = jsonDecode(availabilityData);
    AvailabilityModel availabilityModel =
        AvailabilityModel.fromMap(availabilityJSON);
    List<Datum> availabilitySet = availabilityModel.data!;
    String model = "";
    String availabilityID =
        content.contentdetails![1].availabilityset![0].toString();
    for (var i = 0; i < availabilitySet.length; i++) {
      Datum availability = availabilitySet[i];
      String availabilityInModel = availability.availabilityid!;
      if (availabilityInModel == availabilityID) {
        model = availability.pricemodel!;
        break;
      }
    }
    return model;
  }

  Future<String> getPurchaseList() async {
    SharedPreferences sharedPreferences = await DeviceStorage().getInstance();
    String purchaseListData =
        sharedPreferences.getString(DeviceStorage.purchaseListData) ?? "";

    if (purchaseListData.isEmpty) {
      try {
        var response = await NetworkHandler.getPurchaseList();
        purchaseListData = jsonEncode(response);
        await sharedPreferences.setString(
            DeviceStorage.purchaseListData, purchaseListData);
      } catch (error) {
        purchaseListData = "";
      }
    }
    return purchaseListData;
  }

  Future<bool> checkPurchase(String objectId) async {
    String purchaseListData = await getPurchaseList();
    if (purchaseListData == "") {
      return false;
    }
    var data = jsonDecode(purchaseListData);
    //the response contains a purchase list, parse it and check if the objectid exists
    var purchaseList = data['data'];
    for (var i = 0; i < purchaseList.length; i++) {
      var purchaseItem = purchaseList[i];
      var objectIdInPurchase = purchaseItem['objectid'].toString();
      if (objectIdInPurchase == objectId) {
        return true;
      }
    }
    return false;
  }

  Future<bool> checkSubscription() async {
    SharedPreferences sharedPreferences = await DeviceStorage().getInstance();
    String subscriptionData =
        sharedPreferences.getString(DeviceStorage.subscriptionData) ?? "";

    if (subscriptionData.isEmpty) {
      try {
        subscriptionData = await NetworkHandler.getSubcription();
      } catch (error) {
        subscriptionData = notsubscribed;
      }
    }
    await sharedPreferences.setString(
        DeviceStorage.subscriptionData, subscriptionData);
    if (subscriptionData == notsubscribed) {
      return false;
    }
    return true;
  }

  Future<dynamic> fetchSubscriptionData() async {
    SharedPreferences sharedPreferences = await DeviceStorage().getInstance();
    String subscriptionData =
        sharedPreferences.getString(DeviceStorage.subscriptionData) ?? "";

    if (subscriptionData.isEmpty) {
      try {
        subscriptionData = await NetworkHandler.getSubcription();
      } catch (error) {
        subscriptionData = notsubscribed;
      }
    }
    await sharedPreferences.setString(
        DeviceStorage.subscriptionData, subscriptionData);
    return subscriptionData;
  }
}
