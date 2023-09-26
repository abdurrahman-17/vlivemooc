import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:vlivemooc/core/helpers/app_screen_dimen.dart';
import 'package:vlivemooc/core/models/content/content_model/content_model.dart';
import 'package:vlivemooc/core/models/content/content_model/datum.dart';
import 'package:vlivemooc/ui/components/carousel/carousel_item.dart';
import 'package:vlivemooc/ui/constants/colors.dart';
import 'package:vlivemooc/ui/constants/constants.dart';

class MainCarousel extends StatefulWidget {
  const MainCarousel({super.key, required this.data});
  final ContentModel data;
  @override
  State<MainCarousel> createState() => _MainCarouselState();
}

class _MainCarouselState extends State<MainCarousel> {
  late PageController _pageController;
  int activePage = 0;
  double viewportFraction = 0.5;
  double animationScale = 0.9;
  bool hasInitialized = false;
  bool isHover = false;
  late Timer _carouselAnimeTimer;

  @override
  void initState() {
    super.initState();
    viewportFraction = Constants.carouselViewportFraction;
    _pageController =
        PageController(viewportFraction: viewportFraction, initialPage: 999);
    Timer(const Duration(milliseconds: 200), () {
      // animatePage(1);
      setState(() {
        hasInitialized = true;
      });
    });
    _carouselAnimeTimer = Timer.periodic(const Duration(seconds: 4), (timer) {
      int currentIndex = activePage;
      currentIndex += 1;
      animatePage(currentIndex);
      setState(() {
        activePage = currentIndex;
      });
    });
  }

  animatePage(int index) {
    _pageController.animateToPage(index,
        duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
  }

  void _scrollTo(bool forward) {

    if(forward){
      _pageController.animateToPage(activePage + 1,
          duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
    }else{
      _pageController.animateToPage(activePage - 1,
          duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
    }

  }


  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
    _carouselAnimeTimer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width * viewportFraction;
    double calculatedHeight = width * 0.5625;
    bool isMobileSize = isMobile(context);
    return Column(
      children: [
        InkWell(
          onTap: (){},
          onHover: (hovered){
            setState(() {
              isHover = hovered;
            });
          },
          hoverColor: Colors.transparent,
          child: SizedBox(
            height: calculatedHeight,
            child: Stack(
                children: [
                  PageView.builder(
                      pageSnapping: true,
                      controller: _pageController,
                      onPageChanged: (int newValue) {
                        int active = newValue % widget.data.data!.length;
                        setState(() {
                          activePage = active;
                        });
                      },
                      itemBuilder: (context, pagePosition) {
                        int length = widget.data.data!.length;
                        int index = pagePosition % length;
                        Datum datum = widget.data.data![index];
                        if (!hasInitialized) {
                          return CarouselItem(
                            content: datum,
                          );
                        }
                        return AnimatedBuilder(
                          animation: _pageController,
                          builder: (_, __) => Transform.scale(
                            scale: max(
                              animationScale,
                              (1 - (_pageController.page! - pagePosition).abs() / 2),
                            ),
                            child: CarouselItem(
                              content: datum,
                            ),
                          ),
                        );
                      }),
                  Positioned(
                    left: 10,
                    top: isMobileSize ? 20 : calculatedHeight / 2,
                    child: Visibility(
                      visible: isHover,
                      child: AnimatedOpacity(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.fastOutSlowIn,
                        opacity:1,
                        child: FloatingActionButton.small(
                          heroTag: UniqueKey().toString(),
                          backgroundColor: AppColors.primaryColor,
                          foregroundColor: Colors.white,
                          onPressed: () {
                            _scrollTo(false);
                          },
                          child: const Icon(Icons.arrow_back),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 10,
                    top: isMobileSize ? 20 : calculatedHeight / 2,
                    child: Visibility(
                      visible: isHover,
                      child: AnimatedOpacity(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.fastOutSlowIn,
                        opacity: 1,
                        child: FloatingActionButton.small(
                          heroTag: UniqueKey().toString(),
                          backgroundColor: AppColors.primaryColor,
                          foregroundColor: Colors.white,
                          onPressed: () {
                            _scrollTo(true);
                          },
                          child: const Icon(Icons.arrow_forward),
                        ),
                      ),
                    ),
                  )
                ]
            ),
          ),
        ),
        const SizedBox(
          height: Constants.semanticMarginDefault,
        ),
        AnimatedSmoothIndicator(
            activeIndex: activePage % widget.data.data!.length,
            count: widget.data.data!.length,
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
    );
  }
}
