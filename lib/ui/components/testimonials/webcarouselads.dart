import 'package:flutter/material.dart';
import 'package:vlivemooc/ui/constants/colors.dart';

// Main page of the widget (Carousel)
class WebCarouselAds extends StatefulWidget {
  const WebCarouselAds({
    Key? key,
  }) : super(key: key);

  @override
  State<WebCarouselAds> createState() => _WebCarouselAdsState();
}

class _WebCarouselAdsState extends State<WebCarouselAds> {
  int activePage = 1;
  late PageController _pageController;
  List<String> images = [
    "assets/images/sliderimage.png",
    "assets/images/sliderimage.png",
    "assets/images/sliderimage.png",
    "assets/images/sliderimage.png",
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.8, initialPage: 1);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: SizedBox(
            width: MediaQuery.of(context).size.width / 1.5,
            height: 160,
            child: PageView.builder(
                itemCount: 1,
                pageSnapping: true,
                controller: _pageController,
                onPageChanged: (page) {
                  setState(() => activePage = page);
                },
                itemBuilder: (context, pagePosition) {
                  bool active = pagePosition == activePage;
                  return slider(images, pagePosition, active);
                }),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: imageIndicator(images.length, activePage),
          ),
        ),
      ],
    );
  }
}

// Animated container widget
AnimatedContainer slider(images, pagePosition, active) {
  double margin = active ? 5 : 10;

  return AnimatedContainer(
    duration: const Duration(milliseconds: 500),
    curve: Curves.easeInOutCubic,
    margin: EdgeInsets.all(margin),
    child: const Column(
      children: [
        Text(
            "Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit. Exercitation veniam consequat sunt nostrud amet.",
            style: TextStyle(
              color: Colors.white,
              fontSize: 17.0,
              fontFamily: "Inter-SemiBold",
            )),
        SizedBox(
          height: 20.0,
        ),
        Text("John Doe    HR Executive",
            style: TextStyle(
              color: Colors.white,
              fontSize: 17.0,
              fontFamily: "Inter-SemiBold",
            )),
      ],
    ),
    /* decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            images[pagePosition],
          ),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(10)
    ),*/
  );
}

// Widget for image animation while sliding carousel
imageAnimation(PageController animation, images, pagePosition) {
  return AnimatedBuilder(
    animation: animation,
    builder: (context, widget) {
      // print(pagePosition);
      return SizedBox(
        width: 200,
        height: 200,
        child: widget,
      );
    },
    child: Container(
      margin: const EdgeInsets.all(10),
      child: Image.network(images[pagePosition]),
    ),
  );
}

// Widget for showing image indicator
List<Widget> imageIndicator(imagesLength, currentIndex) {
  return List<Widget>.generate(imagesLength, (index) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 2),
      width: 20,
      height: 2,
      decoration: BoxDecoration(
          color: currentIndex == index ? AppColors.secondaryColor : Colors.grey,
          shape: BoxShape.rectangle,
          borderRadius: const BorderRadius.horizontal(
              left: Radius.elliptical(2, 2), right: Radius.elliptical(2, 2))),
    );
  });
}
