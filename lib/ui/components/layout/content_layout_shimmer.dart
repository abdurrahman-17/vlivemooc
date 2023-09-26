import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:vlivemooc/ui/components/cards/content_card_shimmer.dart';

import '../../constants/constants.dart';

class ContentLayoutShimmer extends StatelessWidget {
  const ContentLayoutShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Constants.insetPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 150,
            height: 40,
            child: Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade200,
              child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.grey.shade200),
              ),
            ),
          ),
          const SizedBox(
            height: Constants.semanticsMarginExSmall,
          ),
          SizedBox(
            height: 280,
            child: ListView.builder(
                itemCount: 7,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  return SizedBox(
                    width: 300,
                    child: Padding(
                        padding: EdgeInsets.only(right: Constants.insetPadding),
                        child: const ContentCardShimmer()),
                  );
                }),
          )
        ],
      ),
    );
  }
}
