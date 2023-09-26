
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:vlivemooc/core/fireabse/firebase_actions.dart';
import 'package:vlivemooc/core/helpers/image_filters.dart';
import 'package:vlivemooc/core/helpers/route_generator.dart';
import 'package:vlivemooc/core/helpers/text_styles.dart';
import 'package:vlivemooc/core/models/content/content_model/content_model.dart';
import 'package:vlivemooc/core/models/content/content_model/datum.dart';
import 'package:vlivemooc/core/player/video/trailer_player.dart';
import 'package:vlivemooc/ui/components/buttons/add_to_watchlist.dart';
import 'package:vlivemooc/ui/components/buttons/play_shortcut_button.dart';
import 'package:vlivemooc/ui/components/cards/tag_card.dart';
import 'package:vlivemooc/ui/constants/colors.dart';
import 'package:vlivemooc/ui/constants/constants.dart';

import '../../../core/helpers/language_codes.dart';
import '../../../core/helpers/time_calculator.dart';
import '../../../core/models/firebase/fire_datum.dart';
import '../../../core/models/subscriber/subscriber_model.dart';
import '../../../core/provider/user_provider.dart';

class ContentCard extends StatefulWidget {
  final Datum content;
  final bool reversedPadding;
  final bool shouldRoutePush;
  final String idgenre;

  const ContentCard(
      {super.key,
        required this.content,
        this.idgenre = "",
        this.reversedPadding = false,
        this.shouldRoutePush = false});

  @override
  State<ContentCard> createState() => _ContentCardState();
}

class _ContentCardState extends State<ContentCard> with AutomaticKeepAliveClientMixin{
  @override
  void initState() {
    super.initState();
    String objectType = widget.content.objecttype!;
    if (objectType == ContentModel.series &&
        widget.content.category == ContentModel.course) {
      isCourse = true;
    } else {
      isCourse = false;
    }
    if (widget.content.episodenum != null) {
      isEpisode = true;
    }
    if (widget.idgenre.isNotEmpty) {
      widget.content.selectedGenre = widget.idgenre;
    }
    if (widget.content.objecttype == ContentModel.series) {
      isSeries = true;
    }

    language = widget.content.contentlanguage != null
        ? getLanguagesListFromAvailableLanguages(
        widget.content.contentlanguage!)
        : "English";
  }

  bool isCourse = false;
  bool isEpisode = false;
  bool isSeries = false;
  bool isHovered = false;
  String language = "";
  String toolTipLanguage = "";

  onCardClick() {
    if (widget.shouldRoutePush) {
      context.push(RouteGenerator.generateContentRoute(content: widget.content),
          extra: widget.content);
    } else {
      RouteGenerator().navigate(
          context, RouteGenerator.generateContentRoute(content: widget.content),
          extra: widget.content);
    }
  }

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
          changeInFireContent: onFetchedFirebaseContents,
          subscriberId: model.subscriberId,
          objectId: widget.content.objectid,
          onNullValue: () {
            setState(() {
              widget.content.inwatchlist = false;
            });
          });
    }
  }

  onFetchedFirebaseContents(FireDatum fireContentsData) {
    setState(() {
      widget.content.inwatchlist = fireContentsData.inwatchlist ?? false;
      widget.content.watchedDuration = fireContentsData.watchedDuration ?? 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Padding(
      padding: widget.reversedPadding
          ? const EdgeInsets.only(
          left: Constants.semanticsMarginExSmall,
          bottom: Constants.semanticsMarginExSmall)
          : const EdgeInsets.only(
          right: Constants.semanticsMarginExSmall,
          bottom: Constants.semanticsMarginExSmall),
      child: Card(
        elevation: Constants.cardElevation,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Constants.cardBorderRadius)),
        child: InkWell(
          onHover: (value) {
            setState(() {
              isHovered = value;
            });
          },
          hoverColor: Colors.transparent,
          onTap: () {
            onCardClick();
          },
          borderRadius: BorderRadius.circular(Constants.cardBorderRadius),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: 16 / 9,
                child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(Constants.cardBorderRadius),
                        topRight: Radius.circular(Constants.cardBorderRadius)),
                    child: widget.content.poster == null ||
                        widget.content.poster![0].filelist == null
                        ? Container()
                        : isHovered &&
                        widget.content.trailer.toString().isNotEmpty
                        ? TrailerPlayer(
                      content: widget.content,
                      onTap: onCardClick,
                    )
                        : CachedNetworkImage(
                      imageUrl: getHdPosterLandscapeBasedOnGenre(
                          widget.content,
                          genre: widget.idgenre.isEmpty
                              ? widget.content.genre
                              : widget.idgenre),
                      fit: BoxFit.fill,
                    )),
              ),
              !isCourse
                  ? Container(
                width: double.infinity,
                color: AppColors.primaryColor.withOpacity(0.1),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: Constants.semanticsMarginExSmall,
                      vertical: 2),
                  child: Row(children: [
                    widget.content.genre!=null
                        ? TagCard(tag:widget.content.selectedGenre?? widget.content.genre!)
                        : Container(),
                    const SizedBox(
                      width: Constants.semanticsMarginExSmall,
                    ),
                    language.length > 15
                        ? Expanded(
                      child: Tooltip(
                        richMessage: WidgetSpan(
                            child: Container(
                              constraints:
                              const BoxConstraints(maxWidth: 170),
                              child: Text(
                                language,
                                style: poppinsMedium(
                                    Constants.fontSizeExSmall,
                                    AppColors.white),
                              ),
                            )),
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        child: Text(
                          language,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontSize: Constants.fontSizeSmall,
                              color: Colors.black),
                        ),
                      ),
                    )
                        : Expanded(
                        child: Text(
                          language,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontSize: Constants.fontSizeSmall,
                              color: Colors.black),
                        )),
                  ]),
                ),
              )
                  : Container(),
              Expanded(
                child: Padding(
                    padding: const EdgeInsets.all(Constants.cardPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.content.title!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: Constants.fontSizeMedium),
                        ),
                        widget.content.objectowner!=null
                            ? Text.rich(
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          TextSpan(
                            text: "Speaker : ",
                            style: poppinsMedium(Constants.fontSizeSmall,
                                AppColors.blackcolor),
                            children: [
                              TextSpan(
                                text: widget.content.objectowner!,
                                style: poppinsBold(
                                  Constants.fontSizeSmall,
                                  AppColors.primaryColor,
                                ),
                              )
                            ],
                          ),
                        )
                            : Container(),
                        Text(
                          widget.content.shortdescription ??
                              widget.content.longdescription ??
                              "",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontSize: Constants.fontSizeSmall),
                        ),
                        Container(
                          padding: const EdgeInsets.only(right: 7, bottom: 7),
                          child: Row(
                            children: [
                              Expanded(
                                  flex: 1,
                                  child: isCourse
                                      ? Text(
                                      "${widget.content.seasoncount ?? 0} Modules")
                                      : Text(
                                    isSeries
                                        ? "Contains Episodes"
                                        : "Duration: ${TimeCalculator().formatTimetoMinsFromSec(timeInSecond: widget.content.duration)} Min",
                                    style: poppinsLight(
                                        13, AppColors.blackcolor),
                                  )),
                              (!isCourse && !isEpisode)
                                  ? AddToWatclist(content: widget.content)
                                  : Container(),
                              (!isCourse && !isEpisode)
                                  ? const SizedBox(
                                width: Constants.semanticMarginTen,
                              )
                                  : Container(),
                              (!isCourse)
                                  ? PlayShortcutButton(
                                content: widget.content,
                                isSeries: isSeries,
                              )
                                  : Container(),
                              isCourse
                                  ? ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                      AppColors.primaryColor,
                                      foregroundColor: Colors.white),
                                  onPressed: () {
                                    onCardClick();
                                  },
                                  child: const Text("Enroll"))
                                  : Container()
                            ],
                          ),
                        )
                      ],
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
