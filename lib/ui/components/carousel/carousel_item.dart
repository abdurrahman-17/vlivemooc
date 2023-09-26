import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:vlivemooc/core/fireabse/firebase_actions.dart';
import 'package:vlivemooc/core/helpers/app_screen_dimen.dart';
import 'package:vlivemooc/core/helpers/image_filters.dart';
import 'package:vlivemooc/core/helpers/time_calculator.dart';
import 'package:vlivemooc/core/models/content/content_model/datum.dart';
import 'package:vlivemooc/core/models/firebase/fire_datum.dart';
import 'package:vlivemooc/core/models/subscriber/subscriber_model.dart';
import 'package:vlivemooc/core/provider/user_provider.dart';
import 'package:vlivemooc/ui/components/buttons/add_to_watchlist.dart';
import 'package:vlivemooc/ui/components/buttons/share_button.dart';
import 'package:vlivemooc/ui/constants/constants.dart';

import '../../../core/helpers/route_generator.dart';

class CarouselItem extends StatefulWidget {
  final Datum content;
  const CarouselItem({super.key, required this.content});

  @override
  State<CarouselItem> createState() => _CarouselItemState();
}

class _CarouselItemState extends State<CarouselItem> {
  bool isHover = false;

  @override
  void didChangeDependencies() {
    fetchContentFromFirebase();
    super.didChangeDependencies();
  }

  void fetchContentFromFirebase() async {
    //Fetch subscriber and then get the fire contents
    SubscriberModel? model = Provider.of<UserProvider>(context).subscriberModel;
    if (model != null) {
      firebaseRealtimeDatabase.listenForAContentChange(
          changeInFireContent: (FireDatum fireContent) {
            setState(() {
              setState(() {
                widget.content.inwatchlist = fireContent.inwatchlist ?? false;
              });
            });
          },
          subscriberId: model.subscriberId,
          objectId: widget.content.objectid);
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        RouteGenerator().navigate(context,
            RouteGenerator.generateContentRoute(content: widget.content),
            extra: widget.content);
      },
      onHover: (hovered) {
        setState(() {
          isHover = hovered;
          // print("isHover data");
          // print(isHover);
        });
      },
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(Constants.cardBorderRadius),
          child: Stack(
            children: [
              CachedNetworkImage(
                imageUrl: getHdPosterLandscapeBasedOnGenre(widget.content),
              ),
              Visibility(
                visible: isHover,
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          colors: [
                        Colors.transparent,
                        Colors.transparent,
                        Colors.transparent,
                        Colors.black,
                      ],
                          stops: [
                        0.0,
                        0.7,
                        0.4,
                        1.0
                      ],
                          begin: FractionalOffset.topCenter,
                          end: FractionalOffset.bottomCenter,
                          tileMode: TileMode.repeated)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15.0, bottom: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          widget.content.title!,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        sizedBoxHeight10(context),
                        Row(
                          children: [
                            Text(
                              widget.content.genre!,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            sizedBoxWidth10(context),
                            Text(
                              widget.content.productionyear.toString(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            sizedBoxWidth10(context),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 7),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                color: Colors.white,
                                width: 2,
                              )),
                              child: Text(
                                widget.content.pgrating.toString(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        sizedBoxHeight5(context),
                        Row(
                          children: [
                            const Icon(
                              Icons.access_time_outlined,
                              color: Colors.white,
                              size: 16,
                            ),
                            sizedBoxWidth5(context),
                            Text(
                              "${TimeCalculator().formatTimetoMinsFromSec(timeInSecond: widget.content.duration)}m",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        sizedBoxHeight10(context),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            /*LikeButton(
                                content: widget.content,
                                isMobile: false,
                                isCarousal: true),
                            sizedBoxWidth15(context),*/
                            ShareButton(
                              content: widget.content,
                              onTap: () async {
                                String title = widget.content.title!;
                                String description =
                                    widget.content.shortdescription ?? "";
                                String url = widget.content.poster![0]
                                        .filelist![0].filename ??
                                    "";
                                await Share.share(
                                    '$title\n\n$description\n\n$url');
                              },
                              isCarousal: true,
                            ),
                            sizedBoxWidth15(context),
                            AddToWatclist(
                              content: widget.content,
                              isCarousal: true,
                              size: 25,
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
