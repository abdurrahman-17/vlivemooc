import 'package:vlivemooc/core/models/content/content_model/contentdetail.dart';
import 'package:vlivemooc/core/player/availability_service.dart';
import 'package:vlivemooc/core/provider/provider_constants.dart';

import '../models/content/content_model/datum.dart';

class PlayButtonState {
  static String play = "Play";
  static String resume = "Resume";
  static String subscribe = "Subscribe and watch";
  static String login = "Login and watch";
  static String buy = "Buy Now";
  static String rental = "Rent Now";
  static String notAvailable = "Video Unavailable";
  static String clearLead = "clearLead";

  Future<String> getState(Datum content, {bool clearleadCheck = true}) async {
    String buttonStatus = "";
    if (!ProviderConstants.isLoggedIn) {
      buttonStatus = login;
      buttonStatus = getClearLeadMode(content, buttonStatus, clearleadCheck);
      return buttonStatus;
    }

    AvailabilityService availabilityService = AvailabilityService();
    String mode = "";
    try {
      mode = await availabilityService.checkAvailability(content);
    } catch (err) {
      return notAvailable;
    }
    if (mode == AvailabilityService.free) {
      buttonStatus = play;
    } else if (mode == AvailabilityService.plan) {
      bool isSubscribed = await availabilityService.checkSubscription();
      if (isSubscribed) {
        buttonStatus = play;
      } else {
        buttonStatus = subscribe;
        buttonStatus = getClearLeadMode(content, buttonStatus, clearleadCheck);
      }
    } else if (mode == AvailabilityService.paid) {
      String objectId = content.objectid;
      bool hasPaid = await availabilityService.checkPurchase(objectId);
      if (hasPaid) {
        buttonStatus = play;
      } else {
        buttonStatus = buy;
        buttonStatus = getClearLeadMode(content, buttonStatus, clearleadCheck);
      }
    } else if (mode == AvailabilityService.rental) {
      buttonStatus = rental;
      buttonStatus = getClearLeadMode(content, buttonStatus, clearleadCheck);
    }

    return buttonStatus;
  }

  String getClearLeadMode(
      Datum content, String buttonStatus, bool clearleadcheck) {
    if (!clearleadcheck) {
      return buttonStatus;
    }
    Contentdetail contentdetail = content.contentdetails![0];
    int clearLeadDuration = contentdetail.clearlead ?? 0;
    if (clearLeadDuration == 0) {
      return buttonStatus;
    }
    return clearLead;
  }

  String getClearLeadText(Datum content) {
    String buttonStatus = "";
    Contentdetail contentdetail = content.contentdetails![0];
    int clearLeadDuration = contentdetail.clearlead ?? 0;
    if (clearLeadDuration < 60) {
      buttonStatus = "Watch ${(clearLeadDuration).toString()} secs free";
    } else {
      buttonStatus = "Watch ${(clearLeadDuration / 60).toString()} mins free";
    }
    return buttonStatus;
  }
}
