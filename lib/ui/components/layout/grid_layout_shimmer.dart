import 'package:flutter/material.dart';
import 'package:vlivemooc/core/helpers/app_screen_dimen.dart';
import 'package:vlivemooc/ui/components/cards/content_card_shimmer.dart';
import '../../constants/constants.dart';

class GridLayoutShimmer extends StatelessWidget {
  const GridLayoutShimmer({super.key});

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;

    int crossAxisCount = 4;
    if (width < 600) {
      crossAxisCount = 1;
    } else if (width < 900) {
      crossAxisCount = 2;
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Constants.insetPadding),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GridView.builder(
                itemCount: 5,
                shrinkWrap: true,
                gridDelegate: isMobile(context)
                    ? SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: Constants.semanticMarginTen,
                    mainAxisSpacing: Constants.insetPadding,
                    crossAxisCount: crossAxisCount)
                    : SliverGridDelegateWithMaxCrossAxisExtent(
                    mainAxisExtent: isMobile(context) ? 335 : 345,
                    crossAxisSpacing: Constants.semanticMarginTen,
                    mainAxisSpacing: Constants.insetPadding,
                    maxCrossAxisExtent: Constants.maxContentCardWidthWeb2),
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                      padding: EdgeInsets.only(right: Constants.insetPadding),
                      child: const ContentCardShimmer());
                })
          ],
        ),
      ),
    );
  }
}
