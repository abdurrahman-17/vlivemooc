import 'package:flutter/material.dart';
import 'package:vlivemooc/ui/components/carousel/carousel_item_shimmer.dart';

import '../../constants/constants.dart';

class CarouselShimmer extends StatefulWidget {
  const CarouselShimmer({super.key});

  @override
  State<CarouselShimmer> createState() => _CarouselShimmerState();
}

class _CarouselShimmerState extends State<CarouselShimmer> {
  late PageController _pageController;
  double viewportFraction = 0.5;

  @override
  void initState() {
    super.initState();
    viewportFraction = Constants.carouselViewportFraction;
    _pageController =
        PageController(viewportFraction: viewportFraction, initialPage: 1);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width * viewportFraction;
    double calculatedHeight = width * 0.5625;
    return Column(
      children: [
        SizedBox(
          height: calculatedHeight,
          child: PageView.builder(
              itemCount: 3,
              pageSnapping: true,
              controller: _pageController,
              itemBuilder: (context, pagePosition) {
                return const CarouselItemShimmer();
              }),
        ),
      ],
    );
  }
}
