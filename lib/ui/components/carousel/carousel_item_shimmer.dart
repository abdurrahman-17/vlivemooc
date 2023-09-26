import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:vlivemooc/ui/constants/constants.dart';

class CarouselItemShimmer extends StatelessWidget {
  const CarouselItemShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade200,
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: Constants.carouselItemPadding),
        child: AspectRatio(
          aspectRatio: 16 / 9,
          child: Container(
            decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius:
                    BorderRadius.circular(Constants.cardBorderRadius)),
            width: double.infinity,
            height: double.infinity,
          ),
        ),
      ),
    );
  }
}
