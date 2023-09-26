import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vlivemooc/core/helpers/amount_helper.dart';
import 'package:vlivemooc/core/models/coaches/events_model/response.dart';
import 'package:vlivemooc/ui/components/appbar/top_bar.dart';
import 'package:vlivemooc/ui/components/buttons/book_event.dart';
import 'package:vlivemooc/ui/components/category/categories.dart';
import 'package:vlivemooc/ui/components/events/events.dart';
import 'package:vlivemooc/ui/components/footer/web_footer.dart';
import 'package:vlivemooc/ui/constants/constants.dart';
import 'package:vlivemooc/ui/routes/Routes.dart';

import '../../../core/helpers/app_screen_dimen.dart';
import '../../animations/loading_animation.dart';
import '../../constants/colors.dart';
import '../cards/event_card.dart';
import '../mixins/keep_alive_mixin.dart';

class EventDetail extends StatefulWidget {
  final bool isMobile;
  final String idevent;
  const EventDetail({super.key, required this.isMobile, required this.idevent});

  @override
  State<EventDetail> createState() => _EventDetailState();
}

class _EventDetailState extends State<EventDetail> {
  @override
  void initState() {
    super.initState();
  }

  Response? event;
  List<Response> response = [];
  bool isLoading = true;

  onEventsLoaded(List<Response> slugModels) {
    Response? data;
    for (var i = 0; i < slugModels.length; i++) {
      Response slug = slugModels[i];
      if (slug.idevent == widget.idevent) {
        data = slug;
        break;
      }
    }
    setState(() {
      event = data;
      isLoading = false;
      response = slugModels;
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    int crossAxisCount = 4;
    if (width < 600) {
      crossAxisCount = 1;
    } else if (width < 900) {
      crossAxisCount = 2;
    }

    return SafeArea(
        top: true,
        bottom: true,
        left: true,
        right: true,
        child: Scaffold(
          appBar: widget.isMobile
              ? AppBar(
                  backgroundColor: AppColors.primaryColor,
                  elevation: Constants.appBarElevation,
                  leading: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () {
                      if (context.canPop()) {
                        context.pop();
                      } else {
                        context.go(AppRouter.home);
                      }
                    },
                  ),
                  // title:  Text(widget.content.title!),
                )
              : TopBar(
                  logoPath: "assets/images/logo_white.png",
                  backgroundColor: AppColors.primaryColor,
                  renderNav: true,
                ),
          body: CustomScrollView(
            slivers: [
              event != null
                  ? SliverList(
                      delegate: SliverChildListDelegate([
                      Container(
                        padding: EdgeInsets.all(Constants.insetPadding),
                        color: AppColors.accentColor,
                        child: widget.isMobile
                            ? Column(
                                children: [
                                  ImageLayout(
                                    path: event!.thumbnail!,
                                  ),
                                  DescriptionLayout(
                                    isMobile: widget.isMobile,
                                    event: event!,
                                  )
                                ],
                              )
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                      flex: 1,
                                      child: ImageLayout(
                                        path: event!.thumbnail!,
                                      )),
                                  SizedBox(
                                    width: Constants.insetPadding,
                                  ),
                                  Expanded(
                                      flex: 1,
                                      child: DescriptionLayout(
                                        isMobile: widget.isMobile,
                                        event: event!,
                                      ))
                                ],
                              ),
                      ),
                      Categories(
                        renderScrollButtons: !isMobile(context),
                      ),
                    ]))
                  : const SliverPadding(padding: EdgeInsets.zero),
              SliverList(
                  delegate: SliverChildListDelegate([
                Events(
                  onLoaded: onEventsLoaded,
                  renderEmpty: true,
                ),
                const SizedBox(
                  height: Constants.semanticMarginDefault,
                ),
                Padding(
                  padding: EdgeInsets.only(left: Constants.insetPadding),
                  child: const Text(
                    "More Events",
                    style: TextStyle(
                        fontSize: Constants.fontSizeMedium,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: Constants.semanticsMarginExSmall,
                ),
              ])),
              isLoading
                  ? SliverList(
                      delegate: SliverChildListDelegate([
                      const SizedBox(
                        height: 200,
                        child: Center(
                          child: LoadingAnimation(),
                        ),
                      ),
                    ]))
                  : response.isNotEmpty
                      ? SliverGrid.builder(
                          itemCount: response.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: crossAxisCount,
                                  mainAxisSpacing: Constants.insetPadding),
                          itemBuilder: (BuildContext context, int index) {
                            // Category category = categoryModel!.categories![index];
                            return KeepAliveMixin(
                              child: EventCard(
                                  shouldRoutePush: true,
                                  response: response[index]),
                            );
                          })
                      : SliverList(
                          delegate: SliverChildListDelegate([
                          const SizedBox(
                            height: 50,
                            child: Center(
                              child: Text("No events found"),
                            ),
                          ),
                        ])),
              SliverList(
                  delegate: SliverChildListDelegate([
                const SizedBox(
                  height: Constants.semanticMarginDefault,
                ),
                widget.isMobile && event == null
                    ? Container()
                    : const WebFooter()
              ])),
            ],
          ),
        ));
  }
}

class DescriptionLayout extends StatelessWidget {
  final bool isMobile;
  final Response event;
  const DescriptionLayout(
      {super.key, required this.isMobile, required this.event});

  @override
  Widget build(BuildContext context) {
    String? amount = event.amount;
    try {
      if (amount != null) {
        double amt = double.parse(amount);
        amt = amt / 100;
        amount = amt.toString();
      }
    } catch (err) {
      //do nothing
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (isMobile)
          const SizedBox(
            height: Constants.semanticMarginTen,
          ),
        Text(
          event.title!,
          style: const TextStyle(
              fontSize: Constants.fontSizeLarge, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: Constants.semanticsMarginExSmall,
        ),
        Text(
          "Speaker : ${event.name}",
          style: const TextStyle(fontSize: Constants.fontSizeSmall),
        ),
        const SizedBox(
          height: Constants.semanticsMarginExSmall,
        ),
        SizedBox(
          width: isMobile ? double.infinity : 150,
          child: EventCard.getEventDateBelowImage(event),
        ),
        const SizedBox(
          height: Constants.semanticsMarginExSmall,
        ),
        Text(
          event.description ?? "",
          style: const TextStyle(fontSize: Constants.fontSizeSmall),
        ),
        const SizedBox(
          height: Constants.semanticMarginDefault,
        ),
        event.amount!.isNotEmpty
            ? Text(
                "₹ ${amountHelper.formatAmountInDouble(amount!)}",
                style: TextStyle(
                    fontSize: 18,
                    fontFamily: "Inter-Bold",
                    color: AppColors.violettextcolor),
              )
            : Text("Free",
                style: TextStyle(
                    fontSize: 18,
                    fontFamily: "Inter-Bold",
                    color: AppColors.violettextcolor)),
        const SizedBox(
          height: Constants.semanticMarginDefault,
        ),
        SizedBox(width: 100, child: BookEvent(event: event)),
      ],
    );
  }
}

class ImageLayout extends StatelessWidget {
  final String path;
  const ImageLayout({super.key, required this.path});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: ClipRRect(
        borderRadius:
            const BorderRadius.all(Radius.circular(Constants.cardBorderRadius)),
        child: Image.network(
          path,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
