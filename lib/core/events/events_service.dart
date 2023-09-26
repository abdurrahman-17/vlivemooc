import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vlivemooc/core/network/network_handler.dart';
import 'package:vlivemooc/ui/routes/routes.dart';

import '../../ui/components/helpers/cross_platform_web_view.dart';
import '../../ui/components/helpers/link_launcher_web.dart';
import '../models/coaches/events_model/response.dart';
import '../payments/payments_service.dart';

class EventsService {
  EventsService();

  Map<String, String> _generateParams(Response event) {
    Map<String, String> params = {};
    if (event.purchasetype == "FREE") {
      params = {
        'eventid': event.idevent!,
        'hostid': event.instructorid!,
      };
    } else {
      params = {
        'eventid': event.idevent!,
        'hostid': event.instructorid!,
        'purchaseid': "1hgwtrd",
        'starttime': "2023-10-17 19",
        'endtime': "2023-10-17 23",
      };
    }
    return params;
  }

  bookEvent(
      {required Response event,
      required Function onCompletedCallback,
      required Function onError}) async {
    Map<String, String> params = _generateParams(event);
    var data = await NetworkHandler.initializeSession(params);
    if (data.containsKey('errorcode')) {
      onCompletedCallback(data['reason'], false);
      return;
    }

    if (event.purchasetype == "FREE") {
      onCompletedCallback("", true);
    } else {
      String sessionid;
      if (!data.containsKey('success')) {
        onError("");
        return;
      }
      sessionid = data['success'];
      String amount = event.amount.toString();
      // try {
      //   int amt = int.parse(amount);
      //   amt = amt * 100;
      //   amount = amt.toString();
      // } catch (notaNumber) {
      //   //implement error logic
      // }
      var objectData = {
        'amount': amount,
        'hostid': event.instructorid!.toString(),
        'eventid': event.idevent!.toString(),
        'sessionid': sessionid
      };
      String checkoutUrl = await generateCheckoutUrl(objectData);
      onCompletedCallback(checkoutUrl, true);
    }
  }

  onCheckoutUrl(BuildContext context, String checkoutUrl) {
    if (kIsWeb) {
      LinkLauncherWeb().launchUrlWeb(checkoutUrl);
    } else {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => CrossPlatformWebView(
                  url: checkoutUrl,
                  onResponse: (response) {
                    onPaymentMade(response, context);
                  })));
    }
  }

  onPaymentMade(response, BuildContext context) {
    context.go(AppRouter.home);
  }

  Future<String> generateCheckoutUrl(var objectData) async {
    PaymentsService paymentsService = PaymentsService();
    var checkoutParams =
        await paymentsService.generateGatewayInitParams(objectData, "EVENT");
    var checkoutData = await NetworkHandler.initializePayment(checkoutParams);
    var checkoutUrl = checkoutData['referencedata']['checkoutUrl'];
    return checkoutUrl;
  }
}
