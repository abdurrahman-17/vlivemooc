import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:vlivemooc/core/helpers/route_generator.dart';
import 'package:vlivemooc/ui/components/buttons/play_button.dart';
import 'package:vlivemooc/ui/routes/Routes.dart';

import '../../../core/models/content/content_model/datum.dart';
import '../../constants/colors.dart';
import '../../constants/constants.dart';
import '../buttons/add_to_watchlist.dart';
import '../buttons/add_to_watchlist_mobile.dart';

import '../buttons/share_button.dart';
import '../../../core/models/coaches/coach_model/datum.dart' as coachclass;

class CourseTitleLayout extends StatefulWidget {
  final Datum content;
  final bool isMobile;
  final String modules;
  final String price;
  final coachclass.Datum? coach;
  const CourseTitleLayout(
      {super.key,
        required this.content,
        required this.modules,
        required this.price,
        this.isMobile = true,
        required this.coach});

  @override
  State<CourseTitleLayout> createState() => _CourseTitleLayoutState();
}

class _CourseTitleLayoutState extends State<CourseTitleLayout> {
  @override
  Widget build(BuildContext context) {
    String coachName = "";
    if (widget.coach != null && widget.coach!.partnername != null) {
      coachName = widget.coach!.partnername!;
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Row(
        //   children: [
        //     Expanded(
        //       child: Text(
        //         widget.content.title!,
        //         style: const TextStyle(
        //             fontSize: Constants.fontSizeMedium,
        //             fontWeight: FontWeight.bold),
        //       ),
        //     ),
        //     // ShareButton(
        //     //     content: widget.content,
        //     //     onTap: () async {
        //     //       // final ByteData bytes = await rootBundle.load('assets/images/image.png'); // Replace with your image path
        //     //       // final Uint8List imageData = bytes.buffer.asUint8List();

        //     //       String title = widget.content.title!;
        //     //       String description =
        //     //           widget.content.longdescription!.length > 100
        //     //               ? widget.content.longdescription!.substring(0, 100)
        //     //               : widget.content.longdescription!;
        //     //       String url = widget.content.poster![0].filelist![0].filename!;

        //     //       await Share.share('$title\n\n$description\n\n$url');
        //     //     })
        //   ],
        // ),
        Text(
          widget.content.title!,
          style: const TextStyle(
              fontSize: Constants.fontSizeLarge, fontWeight: FontWeight.bold),
        ),
        Text.rich(TextSpan(
            text: 'Speaker : ',
            style: const TextStyle(
              fontSize: Constants.fontSizeSmall,
            ),
            children: <InlineSpan>[
              TextSpan(
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    RouteGenerator().navigate(
                        context,
                        RouteGenerator.generateCoachRoute(
                            coach: widget.coach!, base: AppRouter.coaches),
                        extra: widget.coach);
                  },
                text: coachName,
                style: TextStyle(
                  color: AppColors.primaryColor,
                ),
              )
            ])),
        const SizedBox(
          height: Constants.semanticsMarginExSmall,
        ),
        Text(
          "${widget.modules} Module'(s)",
          style: const TextStyle(fontSize: Constants.fontSizeMedium),
        ),
        Text(
          widget.price,
          style: const TextStyle(
              fontSize: Constants.fontSizeMedium, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: Constants.semanticsMarginExSmall,
        ),
        widget.isMobile
            ? PlayButton(
          content: widget.content,
          isCourse: true,
        )
            : Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
                width: 180,
                child: PlayButton(
                  content: widget.content,
                  isCourse: true,
                )),
            const SizedBox(
              width: Constants.semanticMarginDefault,
            ),
            AddToWatclist(
              content: widget.content,
              size: 40,
            ),
            // const SizedBox(
            //   width: Constants.semanticsMarginExSmall,
            // ),
            // Download(content: content)
          ],
        ),
        SizedBox(
          height: Constants.insetPadding,
        ),
        Row(
          children: [
            // LikeButton(
            //   content: widget.content,
            //   isMobile: widget.isMobile,
            // ),
            // const SizedBox(
            //   width: Constants.semanticMarginDefault,
            // ),
            // DislikeButton(
            //   content: widget.content,
            //   isMobile: widget.isMobile,
            // ),
            // const SizedBox(
            //   width: Constants.semanticMarginDefault,
            // ),
            widget.isMobile
                ? AddToWatchlistMobileButton(
              content: widget.content,
            )
                : ShareButton(
              content: widget.content,
              onTap: () async {
                try {
                  setState(() async {
                    // final ByteData bytes = await rootBundle.load('assets/images/image.png'); // Replace with your image path
                    // final Uint8List imageData = bytes.buffer.asUint8List();
                    // print("pressed");
                    String title = widget.content.title!;
                    String description =
                    widget.content.longdescription!.length > 100
                        ? widget.content.longdescription!
                        .substring(0, 100)
                        : widget.content.longdescription!;
                    String url =
                    widget.content.poster![0].filelist![0].filename!;

                    await Share.share('$title\n\n$description\n\n$url');
                  });
                } catch (e) {
                  // Handle sharing error
                }
              },
            ),
          ],
        )
      ],
    );
  }
}
