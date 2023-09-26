import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vlivemooc/core/models/coaches/events_model/events_model.dart';
import 'package:vlivemooc/core/models/coaches/events_model/response.dart';
import 'package:vlivemooc/core/provider/user_provider.dart';
import 'package:vlivemooc/ui/components/cards/event_card.dart';
import 'package:vlivemooc/ui/components/layout/grid_layout_shimmer.dart';
import 'package:vlivemooc/ui/components/mixins/keep_alive_mixin.dart';
import 'package:vlivemooc/ui/constants/constants.dart';

import '../../../core/helpers/app_screen_dimen.dart';
import '../../../core/network/network_handler.dart';

class EventsGridLayout extends StatefulWidget {
  final bool isMobile;
  final String partnerid;
  final Function? onLoaded;
  final bool renderEmpty;
  final String category;
  final List<Response>? events;
  const EventsGridLayout(
      {super.key,
      this.isMobile = true,
      this.partnerid = "",
      this.category = "",
      this.onLoaded,
      this.events,
      this.renderEmpty = false});

  @override
  State<EventsGridLayout> createState() => _EventsGridLayoutState();
}

class _EventsGridLayoutState extends State<EventsGridLayout> {
  @override
  void initState() {
    super.initState();
    if (widget.events != null) {
      response = widget.events!;
      isLoading = false;
    } else {
      if (widget.partnerid.isNotEmpty) {
        getEvents();
      } else if (widget.renderEmpty) {
        getEvents();
      }
    }
  }

  List<Response> response = [];
  bool isLoading = true;

  getEvents() async {
    bool isLoggedin =
        Provider.of<UserProvider>(context, listen: false).isLoggedIn;
    List<Response> slug = [];

    EventsModel? data;
    try {
      data = await NetworkHandler.getEvents(
          isLoggedin: isLoggedin,
          instructorID: widget.partnerid,
          category: widget.category);
    } catch (err) {
      setState(() {
        response = slug;
        isLoading = false;
      });
      return;
    }

    for (var i = 0; i < data.response!.length; i++) {
      Response event = data.response![i];
      String amount = "";
      if (event.amount != null && event.amount!.isNotEmpty) {
        try {
          int amt = int.parse(event.amount!);
          amt = amt ~/ 100;
          amount = amt.toString();
        } catch (notaNumber) {
          //implement error logic
          if (kDebugMode) {
            print(notaNumber);
          }
        }
      }
      if (event.thumbnail != null &&
          event.thumbnail!.isNotEmpty &&
          event.type != "SESSION") {
        slug.add(event);
      }
    }
    if (widget.onLoaded != null) {
      widget.onLoaded!(slug);
    }
    setState(() {
      response = slug;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    int crossAxisCount = 4;
    if (width < 400) {
      crossAxisCount = 1;
    } else if (width < 600) {
      crossAxisCount = 1;
    } else if (width < 900) {
      crossAxisCount = 3;
    }

    if (isLoading) {
      return const GridLayoutShimmer();
    }
    return Padding(
      padding: EdgeInsets.all(Constants.insetPadding),
      child: response.isNotEmpty
          ? GridView.builder(
              itemCount: response.length,
              gridDelegate: isMobile(context)
                  ? SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisSpacing: Constants.semanticMarginTen,
                      mainAxisSpacing: Constants.insetPadding,
                      crossAxisCount: crossAxisCount)
                  : SliverGridDelegateWithMaxCrossAxisExtent(
                      mainAxisExtent: 350,
                      crossAxisSpacing: Constants.insetPadding,
                      mainAxisSpacing: Constants.insetPadding,
                      maxCrossAxisExtent: Constants.maxContentCardWidthWeb2),
              itemBuilder: (BuildContext context, int index) {
                // Category category = categoryModel!.categories![index];
                return KeepAliveMixin(
                  child: EventCard(response: response[index]),
                );
              })
          : const SizedBox(
              height: 50,
              child: Center(
                child: Text("No events found"),
              ),
            ),
    );
  }
}
