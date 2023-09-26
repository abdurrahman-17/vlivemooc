import 'package:flutter/material.dart';
import 'package:vlivemooc/ui/components/testimonials/webcarouselads.dart';
import 'package:vlivemooc/ui/constants/colors.dart';

class Testimonials extends StatelessWidget {
  const Testimonials({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: AppColors.primaryColor.withOpacity(0.95),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.only(
                left: 60.0,
                top: 60,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text.rich(TextSpan(
                      text: "People Vouch for",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 40.0,
                        fontFamily: "Inter-SemiBold",
                      ),
                      children: <InlineSpan>[
                        TextSpan(
                          text: 'Us',
                          style: TextStyle(
                            color: AppColors.goldcolor,
                            fontSize: 40.0,
                            fontFamily: "Inter-SemiBold",
                          ),
                        )
                      ])),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Image.asset(
                    "assets/images/quotesimage.png",
                    height: 55.0,
                    width: 70.0,
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  const WebCarouselAds(),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Image.asset("assets/images/reviewimage.png"),
          ),
        ],
      ),
    );
  }
}
