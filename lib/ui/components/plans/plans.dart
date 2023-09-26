import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:vlivemooc/core/helpers/app_screen_dimen.dart';
import 'package:vlivemooc/core/models/plans/plans_model/datum.dart';
import 'package:vlivemooc/core/models/plans/plans_model/plans_model.dart';
import 'package:vlivemooc/ui/components/buttons/subscribe_button.dart';
import 'package:vlivemooc/ui/components/cards/my_plans.dart';

import '../../constants/colors.dart';
import '../../constants/constants.dart';

class Plans extends StatefulWidget {
  final bool isMobile;
  final PlansModel plansModel;
  const Plans({
    super.key,
    required this.plansModel,
    this.isMobile = false,
  });

  @override
  State<Plans> createState() => _PlansState();
}

class _PlansState extends State<Plans> {
  late PageController _pageController;

  int activePage = 1;
  double viewportFraction = 1;
  double animationScale = .9;
  bool hasInitialized = false;

  @override
  void initState() {
    super.initState();
    viewportFraction = widget.isMobile ? 0.95 : 0.3;
    _pageController =
        PageController(viewportFraction: viewportFraction, initialPage: 1);

    Timer(const Duration(milliseconds: 200), () {
      // animatePage(1);
      setState(() {
        hasInitialized = true;
      });
    });
  }

  animatePage(int index) {
    _pageController.animateToPage(index,
        duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: Constants.semanticsMarginExSmall,
          ),
          Text(
            "Pricing Plan",
            style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryColor),
          ),
          const SizedBox(
            height: Constants.semanticsMarginExSmall,
          ),
          const Text(
            "Choose the right pricing plan for you and get started",
            style: TextStyle(
                fontSize: Constants.fontSizeSmall, color: Colors.grey),
          ),
          const SizedBox(
            height: Constants.semanticMarginDefault,
          ),
          ActivePlanController(
              plansModel: widget.plansModel,
              activePlan: activePage,
              onTap: (index) {
                animatePage(index);
              }),
          const SizedBox(
            height: Constants.semanticMarginDefault,
          ),
          SizedBox(
            height: 330,
            child: PageView.builder(
                itemCount: widget.plansModel.data!.length,
                pageSnapping: true,
                controller: _pageController,
                onPageChanged: (int newValue) {
                  int active = newValue % widget.plansModel.data!.length;
                  setState(() {
                    activePage = active;
                  });
                },
                itemBuilder: (context, pagePosition) {
                  Datum datum = widget.plansModel.data![pagePosition];
                  if (!hasInitialized) {
                    return PlansCard(
                      index: pagePosition,
                      onTap: (index) {
                        animatePage(index);
                      },
                      isMobile: widget.isMobile,
                      plan: datum,
                      selected: pagePosition == activePage,
                    );
                  }
                  return AnimatedBuilder(
                    animation: _pageController,
                    builder: (_, __) => Transform.scale(
                      scale: max(
                        animationScale,
                        (1 - (_pageController.page! - pagePosition).abs() / 2),
                      ),
                      child: PlansCard(
                        index: pagePosition,
                        onTap: (index) {
                          animatePage(index);
                        },
                        isMobile: widget.isMobile,
                        plan: datum,
                        selected: pagePosition == activePage,
                      ),
                    ),
                  );
                }),
          ),
          const SizedBox(
            height: Constants.semanticMarginDefault,
          ),
          AnimatedSmoothIndicator(
              activeIndex: activePage,
              count: widget.plansModel.data!.length,
              effect: SwapEffect(
                dotColor: Colors.grey.shade300,
                activeDotColor: AppColors.primaryColor,
                dotHeight: 2,
                dotWidth: 15,
              ),
              onDotClicked: (index) {
                animatePage(index);
              })
        ],
      ),
    );
  }
}

class PlansCard extends StatelessWidget {
  final Datum plan;
  final bool isMobile;
  final bool selected;
  final int index;
  final Function onTap;
  const PlansCard(
      {super.key,
      required this.plan,
      required this.selected,
      required this.index,
      required this.onTap,
      required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: selected ? Constants.cardElevation : 0,
      child: GestureDetector(
        onTap: () {
          onTap(index);
        },
        child: Container(
          padding: EdgeInsets.all(Constants.insetPadding),
          decoration: BoxDecoration(
              border: selected
                  ? Border.all(width: 1, color: AppColors.primaryColor)
                  : null,
              borderRadius: const BorderRadius.all(
                  Radius.circular(Constants.cardBorderRadius))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                plan.planname!,
                style: const TextStyle(
                    fontSize: Constants.fontSizeMedium,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: Constants.semanticsMarginExSmall,
              ),
              const Text(
                "Limited Access",
                style: TextStyle(fontSize: Constants.fontSizeSmall),
              ),
              SizedBox(
                height: Constants.insetPadding,
              ),
              Container(
                width: double.infinity,
                color: AppColors.accentColor,
                padding: EdgeInsets.all(Constants.insetPadding),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      plan.currency!,
                      style:const TextStyle(fontSize: Constants.fontSizeSmall),
                    ),
                    sizedBoxWidth5(context),
                    Text(
                      (plan.amount! / 100).toString(),
                      style: const TextStyle(
                          fontSize: Constants.fontSizeLarge,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "/${plan.planinterval}",
                      style: const TextStyle(fontSize: Constants.fontSizeSmall),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: Constants.semanticMarginDefault,
              ),
              const PlanBenefits(),
              const SizedBox(
                height: Constants.semanticMarginDefault,
              ),
              Expanded(child: Container()),
              SubscribeButton(plan: plan)
            ],
          ),
        ),
      ),
    );
  }
}

class ActivePlanController extends StatelessWidget {
  final PlansModel plansModel;
  final int activePlan;
  final Function onTap;
  const ActivePlanController(
      {super.key,
      required this.plansModel,
      required this.activePlan,
      required this.onTap});

  List<Widget> _buildChildren(int activePlan) {
    List<Widget> children = [];
    for (int i = 0; i < plansModel.data!.length; i++) {
      Datum plan = plansModel.data![i];
      children.add(GestureDetector(
        onTap: () {
          onTap(i);
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: activePlan == i
              ? BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: const BorderRadius.all(Radius.circular(100)))
              : null,
          padding: const EdgeInsets.all(8),
          child: Text(
            plan.planname!,
            style: TextStyle(
                fontSize: Constants.fontSizeSmall,
                color: activePlan == i ? Colors.white : AppColors.primaryColor),
          ),
        ),
      ));
    }
    return children;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: AppColors.accentColor,
          borderRadius: const BorderRadius.all(Radius.circular(100))),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: _buildChildren(activePlan),
      ),
    );
  }
}
