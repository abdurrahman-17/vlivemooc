import 'package:flutter/material.dart';
import 'package:vlivemooc/ui/components/carousel/carousel_shimmer.dart';
import 'package:vlivemooc/ui/components/carousel/main_carousel.dart';

import '../../../core/models/content/content_model/content_model.dart';
import '../../../core/network/network_handler.dart';

class Carousel extends StatefulWidget {
  const Carousel({super.key});

  @override
  State<Carousel> createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  ContentModel? carouselData;

  @override
  void initState() {
    super.initState();
    getContent();
  }

  getContent() async {
    ContentModel contentModel = await NetworkHandler.getContent("FEATURED");
    setState(() {
      carouselData = contentModel;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (carouselData == null) {
      return const CarouselShimmer();
    }
    return MainCarousel(data: carouselData!);
  }
}
