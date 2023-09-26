import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:vlivemooc/core/network/network_handler.dart';
import 'package:vlivemooc/core/player/availability_service.dart';
import 'package:vlivemooc/ui/animations/loading_animation.dart';
import 'package:vlivemooc/ui/components/plans/plans.dart';
import 'package:vlivemooc/ui/components/text/icon_text.dart';
import 'package:vlivemooc/ui/constants/colors.dart';
import 'package:vlivemooc/ui/constants/constants.dart';

import '../../../core/models/plans/plans_model/plans_model.dart';

class MyPlans extends StatefulWidget {
  final bool isMobile;
  const MyPlans({super.key, required this.isMobile});

  @override
  State<MyPlans> createState() => _MyPlansState();
}

class _MyPlansState extends State<MyPlans> {
  bool isLoading = true;
  bool hasSubscribed = false;
  late PlansModel plansModel;
  var subscriptionData = {};
  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    String subData = await AvailabilityService().fetchSubscriptionData();
    if (subData == AvailabilityService.notsubscribed) {
      PlansModel model = await NetworkHandler.getPlans();
      setState(() {
        hasSubscribed = false;
        plansModel = model;
        isLoading = false;
      });
    } else {
      var subObj = jsonDecode(subData);
      setState(() {
        hasSubscribed = true;
        subscriptionData = subObj;
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: isLoading
          ? const Center(
              child: LoadingAnimation(),
            )
          : hasSubscribed
              ? MyPlansSubscribed(subscriptionData: subscriptionData)
              : Plans(
                  plansModel: plansModel,
                  isMobile: widget.isMobile,
                ),
    );
  }
}

class MyPlansSubscribed extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final subscriptionData;
  const MyPlansSubscribed({super.key, required this.subscriptionData});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
          color: AppColors.accentColor,
          border: Border.all(width: 1, color: AppColors.primaryColor)),
      child: Padding(
        padding: EdgeInsets.all(Constants.insetPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              subscriptionData['data'][0]['planname'],
              style: const TextStyle(
                  fontSize: Constants.fontSizeMedium,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: Constants.semanticMarginDefault,
            ),
            Container(
              padding: EdgeInsets.all(Constants.insetPadding),
              color: Colors.white,
              child: screenWidth < 600
                  ? Column(
                      children: [
                        const PlanBenefits(),
                        const SizedBox(
                          height: Constants.semanticMarginDefault,
                        ),
                        PlanDescription(
                          subscriptionData: subscriptionData,
                        )
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Expanded(child: PlanBenefits()),
                        Expanded(
                          child: PlanDescription(
                            subscriptionData: subscriptionData,
                          ),
                        )
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class PlanBenefits extends StatelessWidget {
  const PlanBenefits({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconText(
            icon: Icon(
              Icons.done,
              color: AppColors.primaryColor,
              size: 15,
            ),
            text: "Every first chapter free"),
        IconText(
            icon: Icon(
              Icons.done,
              size: 15,
              color: AppColors.primaryColor,
            ),
            text: "Selection of free courses"),
        IconText(
            icon: Icon(
              size: 15,
              Icons.done,
              color: AppColors.primaryColor,
            ),
            text: "Every first chapter free"),
        IconText(
            icon: Icon(
              Icons.done,
              size: 15,
              color: AppColors.primaryColor,
            ),
            text: "Selection of free courses"),
      ],
    );
  }
}

class PlanDescription extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final subscriptionData;
  const PlanDescription({super.key, required this.subscriptionData});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.accentColor,
      child: Padding(
        padding: EdgeInsets.all(Constants.insetPadding),
        child: Text(
            "Your ${subscriptionData['data'][0]['planname']} ends at ${subscriptionData['data'][0]['nextbilling']}. Your plan does not auto renew"),
      ),
    );
  }
}
