import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:vlivemooc/core/fireabse/firebase_actions.dart';
import 'package:vlivemooc/core/helpers/route_generator.dart';
import 'package:vlivemooc/core/helpers/time_calculator.dart';
import 'package:vlivemooc/core/models/content/content_model/content_model.dart';
import 'package:vlivemooc/core/models/firebase/fire_datum.dart';
import 'package:vlivemooc/core/models/subscriber/subscriber_model.dart';
import 'package:vlivemooc/core/provider/user_provider.dart';
import 'package:vlivemooc/ui/animations/loading_animation.dart';
import 'package:vlivemooc/ui/components/appbar/top_bar.dart';
import 'package:vlivemooc/ui/components/buttons/add_to_watchlist.dart';
import 'package:vlivemooc/ui/components/buttons/add_to_watchlist_mobile.dart';
import 'package:vlivemooc/ui/components/buttons/play_button.dart';
import 'package:vlivemooc/ui/components/buttons/play_floating_button.dart';
import 'package:vlivemooc/ui/components/buttons/share_button.dart';
import 'package:vlivemooc/ui/components/cards/instructor_content_card.dart';
import 'package:vlivemooc/ui/components/category/categories.dart';
import 'package:vlivemooc/ui/components/footer/web_footer.dart';
import 'package:vlivemooc/ui/constants/constants.dart';
import 'package:vlivemooc/ui/routes/Routes.dart';

import '../../../core/helpers/app_screen_dimen.dart';
import '../../../core/models/content/content_model/datum.dart';
import '../../../core/network/network_handler.dart';
import '../../constants/colors.dart';
import '../../../core/models/coaches/coach_model/datum.dart' as coachclass;
import '../layout/content_layout.dart';

class SeriesDetail extends StatefulWidget {
  final bool isMobile;
  final Datum content;
  const SeriesDetail({
    super.key,
    required this.isMobile,
    required this.content,
  });

  @override
  State<SeriesDetail> createState() => _SeriesDetailState();
}

class _SeriesDetailState extends State<SeriesDetail> {
  Datum? episode1;

  @override
  void initState() {
    super.initState();
    getCoach(widget.content.partnerid);
  }

  coachclass.Datum? coach;
  getCoach(String? partnerid) async {
    if (partnerid == null) {
      return;
    }
    coachclass.Datum? datum = await NetworkHandler.getCoach(partnerid);
    setState(() {
      coach = datum;
    });
  }

  onLoadCallback(ContentModel model) {
    setState(() {
      episode1 = model.data![0];
    });
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
          changeInFireContent: (FireDatum fireContent){setState(() {
            setState(() {
              widget.content.inwatchlist=fireContent.inwatchlist??false;
            });
          });},
          subscriberId: model.subscriberId,
          objectId: widget.content.objectid);
    }

  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: true,
        bottom: true,
        left: true,
        right: true,
        child: Scaffold(
          appBar: widget.isMobile
              ? AppBar(
            backgroundColor: AppColors.primaryColor,
          )
              : TopBar(
            logoPath: "assets/images/logo_white.png",
            backgroundColor: AppColors.primaryColor,
            renderNav: true,
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                // widget.isMobile
                //     ? Container()
                //     : const BreadCrumbs(path: "Home/Series"),
                Container(
                  padding: EdgeInsets.all(Constants.insetPadding),
                  color: AppColors.accentColor,
                  child: widget.isMobile
                      ? episode1 == null
                      ? const Center(
                    child: LoadingAnimation(),
                  )
                      : Column(
                    children: [
                      ImageLayout(
                          episode1: episode1!,
                          content: widget.content,
                          path: widget.content.poster![0].filelist![0]
                              .filename!),
                      DescriptionLayout(
                        isMobile: widget.isMobile,
                        coach: coach,
                        episode1: episode1!,
                        content: widget.content,
                      )
                    ],
                  )
                      : episode1 == null
                      ? const Center(
                    child: LoadingAnimation(),
                  )
                      : Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                          flex: 1,
                          child: ImageLayout(
                              episode1: episode1!,
                              content: widget.content,
                              path: widget.content.poster![0]
                                  .filelist![0].filename!)),
                      SizedBox(
                        width: Constants.insetPadding,
                      ),
                      Expanded(
                          flex: 1,
                          child: DescriptionLayout(
                            isMobile: widget.isMobile,
                            episode1: episode1!,
                            coach: coach,
                            content: widget.content,
                          ))
                    ],
                  ),
                ),
                Categories(
                  renderScrollButtons: !isMobile(context),
                ),
                coach != null
                    ? SizedBox(
                  height: Constants.insetPadding,
                )
                    : Container(),
                coach != null
                    ? InstructorContentCard(
                    isMobile: widget.isMobile, coach: coach!)
                    : Container(),
                coach != null
                    ? SizedBox(
                  height: Constants.insetPadding,
                )
                    : Container(),
                coach != null
                    ? ContentLayout(
                  title: "More series by ${coach!.partnername!}",
                  listType: "",
                  objectType: widget.content.objecttype!,
                  categoryType: "",
                  shouldRoutePush: true,
                  partnerid: coach!.partnerid!,
                )
                    : Container(),
                SizedBox(
                  height: Constants.insetPadding,
                ),
                ContentLayout(
                  title: "Episodes",
                  listType: "",
                  objectType: "CONTENT",
                  categoryType: "",
                  shouldRoutePush: true,
                  onLoadCallback: onLoadCallback,
                  isEpisode: true,
                  seriesId: widget.content.objectid,
                ),
                SizedBox(
                  height: Constants.insetPadding,
                ),
                // ContentLayout(
                //   title: "Related Series",
                //   listType: "",
                //   objectType: "",
                //   categoryType: "",
                //   shouldRoutePush: true,
                //   related: widget.content.objectid,
                // ),
                // SizedBox(
                //   height: Constants.insetPadding,
                // ),
                widget.isMobile ? Container() : const WebFooter()
              ],
            ),
          ),
        ));
  }
}

class DescriptionLayout extends StatelessWidget {
  final Datum content;
  final Datum episode1;
  final coachclass.Datum? coach;
  final bool isMobile;
  const DescriptionLayout(
      {super.key,
        required this.content,
        required this.coach,
        required this.episode1,
        required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
       /* content.tags != null
            ? SizedBox(
          height: 25,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: content.tags!.length,
              itemBuilder: (context, index) {
                String tag = content.tags![index] ?? "";
                return Padding(
                    padding: const EdgeInsets.only(
                        right: Constants.semanticsMarginExSmall),
                    child: Padding(
                        padding: const EdgeInsets.only(
                            top: Constants.semanticsMarginExSmall),
                        child: TagCard(tag: tag)));
              }),
        )
            : Container(),
        const SizedBox(
          height: Constants.semanticsMarginExSmall,
        ),*/
        Text(
          content.title!,
          style: const TextStyle(
              fontSize: Constants.fontSizeLarge, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: Constants.semanticsMarginExSmall,
        ),
        Text(
          "Duration : ${TimeCalculator.formatTimeInContentDuration(timeInSecond: content.duration)}",
          style: const TextStyle(fontSize: Constants.fontSizeSmall),
        ),
        const SizedBox(
          height: Constants.semanticsMarginExSmall,
        ),
        coach != null
            ? InkWell(
          onTap: () {
            context.push(RouteGenerator.generateCoachRoute(
                coach: coach!, base: AppRouter.coaches));
          },
          child: Text.rich(TextSpan(
              text: 'Speaker : ',
              style: const TextStyle(
                fontSize: Constants.fontSizeMedium,
              ),
              children: <InlineSpan>[
                TextSpan(
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      RouteGenerator().navigate(
                          context,
                          RouteGenerator.generateCoachRoute(
                              coach: coach!, base: AppRouter.coaches),
                          extra: coach);
                    },
                  text: coach!.partnername!,
                  style: TextStyle(
                    color: AppColors.primaryColor,
                  ),
                )
              ])),
        )
            : Container(),
        const SizedBox(
          height: Constants.semanticsMarginExSmall,
        ),
        Text(
          content.shortdescription??content.longdescription ?? "",
          style: const TextStyle(fontSize: Constants.fontSizeSmall),
        ),
        const SizedBox(
          height: Constants.semanticsMarginExSmall,
        ),
        isMobile
            ? PlayButton(
          content: episode1,
          buttonText: "Play Episode 1",
        )
            : Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
                width: 180,
                child: PlayButton(
                  content: episode1,
                  buttonText: "Play Episode 1",
                )),
            const SizedBox(
              width: Constants.semanticMarginDefault,
            ),
            AddToWatclist(
              content: content,
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
            //   content: content,
            //   isMobile: isMobile,
            // ),
            // const SizedBox(
            //   width: Constants.semanticMarginDefault,
            // ),
            // DislikeButton(
            //   content: content,
            //   isMobile: isMobile,
            // ),
            // const SizedBox(
            //   width: Constants.semanticMarginDefault,
            // ),
            isMobile
                ? AddToWatchlistMobileButton(
              content: content,
            )
                : ShareButton(
              content: content,
              onTap: () async {
                String title = content.title!;
                String description = content.shortdescription ?? "";
                String url =
                    content.poster![0].filelist![0].filename ?? "";
                await Share.share('$title\n\n$description\n\n$url');
              },
            ),
          ],
        )
      ],
    );
  }
}

class ImageLayout extends StatelessWidget {
  final String path;
  final Datum content;
  final Datum episode1;
  const ImageLayout(
      {super.key,
        required this.path,
        required this.content,
        required this.episode1});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        AspectRatio(
          aspectRatio: 16 / 9,
          child: ClipRRect(
            borderRadius: const BorderRadius.all(
                Radius.circular(Constants.cardBorderRadius)),
            child: Image.network(path),
          ),
        ),
        SizedBox(
          width: 40,
          height: 40,
          child: PlayFloatingButton(content: episode1),
        )
      ],
    );
  }
}
