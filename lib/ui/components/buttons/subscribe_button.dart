import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vlivemooc/core/models/plans/plans_model/datum.dart';
import 'package:vlivemooc/core/payments/payments_service.dart';
import 'package:vlivemooc/ui/routes/Routes.dart';

import '../../../core/storage/device_storage.dart';
import '../helpers/cross_platform_web_view.dart';
import '../helpers/link_launcher_web.dart';
import 'circular_loading_button.dart';

class SubscribeButton extends StatefulWidget {
  final Datum plan;
  const SubscribeButton({super.key, required this.plan});

  @override
  State<SubscribeButton> createState() => _SubscribeButtonState();
}

class _SubscribeButtonState extends State<SubscribeButton> {
  bool isLoading = false;

  subscribeUser() {
    setState(() {
      isLoading = true;
    });

    initializePayment((bool hasInitialized, String checkoutUrl) {
      if (hasInitialized) {
        _launchUrl(checkoutUrl, context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Something went wrong, please try again later...")));
      }
      setState(() {
        isLoading = false;
      });
    });
  }

  initializePayment(callback) async {
    PaymentsService paymentsService = PaymentsService();
    var subscriptionObjData =
        paymentsService.generateSubscriptionObjectData(widget.plan);
    try {
      String checkoutUrl = await paymentsService.generateCheckoutUrl(
          subscriptionObjData, "SUBSCRIPTION");
      callback(true, checkoutUrl);
    } catch (error) {
      callback(false, "");
    }
  }

  _launchUrl(String url, BuildContext context) async {
    if (kIsWeb) {
      SharedPreferences sharedPreferences = await DeviceStorage().getInstance();
      await sharedPreferences.setString(DeviceStorage.subscriptionData, "");
      await sharedPreferences.setString(DeviceStorage.plans, "");
      LinkLauncherWeb().launchUrlWeb(url);
    } else {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => CrossPlatformWebView(
                  url: url,
                  onResponse: (response) {
                    onPaymentMade(response, context);
                  })));
    }
  }

  onPaymentMade(response, context) async {
    SharedPreferences sharedPreferences = await DeviceStorage().getInstance();
    await sharedPreferences.setString(DeviceStorage.subscriptionData, "");
    await sharedPreferences.setString(DeviceStorage.plans, "");
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text("Purchase complete")));
    context.go(AppRouter.home);
  }

  @override
  Widget build(BuildContext context) {
    return CircularLoadingElevatedButton(
      height: 40,
      onTap: subscribeUser,
      isLoading: isLoading,
      buttonText: "Subscribe Now",
    );
  }
}
