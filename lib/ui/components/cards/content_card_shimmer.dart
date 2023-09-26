import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../constants/constants.dart';

class ContentCardShimmer extends StatelessWidget {
  const ContentCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 280,
      width: 300,
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade200,
        child: Container(
          height: 280,
          width: 300,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Constants.cardBorderRadius),
            color: Colors.grey.shade200,
          ),
        ),
      ),
    );
  }
}
