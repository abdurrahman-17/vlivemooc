import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:vlivemooc/core/network/network_handler.dart';
import 'package:vlivemooc/core/provider/provider_constants.dart';

import '../models/content/content_model/datum.dart';
// import 'package:http/http.dart' as http;

class PaymentsService {
  generateSubscriptionObjectData(var datum) {
    var objectData = {};
    objectData['price'] = datum.amount!.toString();
    objectData['currency'] = datum.currency!;
    objectData['availabilityid'] = datum.availabilityset![0];
    objectData['planid'] = datum.planid!;
    return objectData;
  }

  generateGatewayInitParams(
    var objectData,
    String mode,
  ) async {
    late Map<String, String> params;
    // String node = "";
    // String nodeId = "";

    if (mode == "PURCHASE") {
      Datum content = objectData as Datum;

      String availabilityId =
          content.contentdetails![0].availabilityset![0].toString();

      var data = await NetworkHandler.getPriceClass(availabilityId);

      String priceClassId =
          data['priceclassdetail'][0]['priceclassid'].toString();
      String currency = data['priceclassdetail'][0]['currency'].toString();
      String price = data['priceclassdetail'][0]['price'].toString();

      params = {
        'devicetype': 'WEB',
        'amount': price,
        'currency': currency,
        'transactionpurpose': 'PURCHASE',
        'transactionmode': 'CC',
        'availabilityid': availabilityId,
        'objectid': content.objectid,
        'priceclassid': priceClassId,
      };
    } else if (mode == "SUBSCRIPTION") {
      String price = objectData['price'];
      String currency = objectData['currency'];
      String availabilityId = objectData['availabilityid'];
      String planid = objectData['planid'];
      params = {
        'devicetype': 'WEB',
        'amount': price,
        'currency': currency,
        'transactionpurpose': 'SUBSCRIPTION',
        'transactionmode': 'CC',
        'availabilityid': availabilityId,
        'planid': planid,
      };
    } else if (mode == "EVENT") {
      // nodeId = objectData['hostid'];
      // node = "coach";
      String amount = objectData['amount'];
      String instructorId = objectData['hostid'];
      String idevent = objectData['eventid'];
      String sessionid = objectData['sessionid'];
      var purchaseMetadata = {
        'hostid': instructorId,
        'eventid': idevent,
        'sessionid': sessionid
      };

      params = {
        'devicetype': 'WEB',
        'amount': amount,
        'currency': 'INR',
        'transactionpurpose': 'PURCHASE',
        'transactionmode': 'CC',
        'availabilityid': 'QAF0HEPH',
        'objectid': 'iryXkXDrdzcH',
        'priceclassid': '9UGLQ5PK',
        'purchasetype': 'SESSION',
        'purchasemetadata': jsonEncode(purchaseMetadata),
      };
    }

    String callbackUrl;
    if (kIsWeb) {
      try {
        // if (mode != "EVENT") {
        //   if (objectData.objecttype == ContentModel.content) {
        //     node = "videos";
        //   } else {
        //     node = "courses";
        //   }
        // }
        // nodeId = objectData.objectid;
        // String title = "redirected";

        // callbackUrl = '${AppUrls.redirectUrl}/$node/$nodeId/$title';
        callbackUrl = ProviderConstants.redirectUrl;
      } catch (objectidError) {
        callbackUrl = ProviderConstants.redirectUrl;
      }
    } else {
      callbackUrl = "https://payment-success-enrichtv.web.app";
    }

    params['callbackUrl'] = callbackUrl;
    return params;
  }

  Future<String> generateCheckoutUrl(var gatewayParams, String mode) async {
    Map<String, String> params = await generateGatewayInitParams(
      gatewayParams,
      mode,
    );
    var response = await NetworkHandler.initializePayment(params);
    var checkoutUrl = response['referencedata']['checkoutUrl'];
    return checkoutUrl;
  }
}
