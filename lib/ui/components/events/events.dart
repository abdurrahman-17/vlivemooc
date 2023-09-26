import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vlivemooc/core/models/category/category_model/category_model.dart';
import 'package:vlivemooc/core/models/coaches/events_model/events_model.dart';
import 'package:vlivemooc/core/network/network_handler.dart';
import 'package:vlivemooc/core/provider/user_provider.dart';
import 'package:vlivemooc/ui/animations/loading_animation.dart';
import 'package:vlivemooc/ui/components/cards/event_card.dart';
import 'package:vlivemooc/ui/components/category/categories.dart';
import 'package:vlivemooc/ui/components/footer/web_footer.dart';
import 'package:vlivemooc/ui/components/mixins/keep_alive_mixin.dart';
import 'package:vlivemooc/ui/constants/constants.dart';

import '../../../core/models/coaches/events_model/response.dart';
import '../../constants/string_constants.dart';

class Events extends StatefulWidget {
  final bool isMobile;
  final String partnerid;
  final String category;
  final Function? onLoaded;
  final bool renderEmpty;

  const Events(
      {super.key,
      this.isMobile = true,
      this.partnerid = "",
      this.onLoaded,
      this.renderEmpty = false,  this.category=""});

  @override
  State<Events> createState() => _EventsState();
}

class _EventsState extends State<Events> {
  CategoryModel? categoryModel;
  EventsModel? events;

  onCategoryLoaded(CategoryModel model) {
    setState(() {
      categoryModel = model;
    });
    getEvents();
  }

  @override
  void initState() {
    super.initState();
    if (widget.partnerid.isNotEmpty) {
      getEvents();
    } else if (widget.renderEmpty) {
      getEvents();
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
          isLoggedin: isLoggedin, instructorID: widget.partnerid,category: widget.category);
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
    if (widget.renderEmpty) {
      return Container();
    }
    double width = MediaQuery.of(context).size.width;
    int crossAxisCount = 4;
    if (width < 600) {
      crossAxisCount = 1;
    } else if (width < 900) {
      crossAxisCount = 2;
    }
    return CustomScrollView(
      slivers: [
        widget.partnerid.isEmpty
            ? SliverList(
                delegate: SliverChildListDelegate([
                SizedBox(
                  height: Constants.insetPadding,
                ),
                // const BreadCrumbs(path: "Home/Events"),
                Categories(
                  onLoadCallback: onCategoryLoaded,
                  renderScrollButtons: !widget.isMobile,
                ),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: Constants.insetPadding),
                  child: Text(
                    StringConstants.events,
                    style: const TextStyle(
                        fontSize: Constants.fontSizeLarge,
                        fontWeight: FontWeight.bold),
                  ),
                )
              ]))
            : const SliverPadding(padding: EdgeInsets.zero),
        isLoading
            ? SliverList(
                delegate: SliverChildListDelegate([
                const SizedBox(
                  height: 250,
                  child: Center(
                    child: LoadingAnimation(),
                  ),
                ),
              ]))
            : response.isNotEmpty
                ? SliverPadding(
                    padding: EdgeInsets.symmetric(
                        horizontal: Constants.insetPadding),
                    sliver: SliverGrid.builder(
                        itemCount: response.length,
                        gridDelegate: widget.isMobile
                            ? SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisSpacing: Constants.semanticMarginTen,
                                mainAxisSpacing: Constants.insetPadding,
                                crossAxisCount: crossAxisCount)
                            : SliverGridDelegateWithMaxCrossAxisExtent(
                                mainAxisExtent: 350,
                                crossAxisSpacing: Constants.insetPadding,
                                mainAxisSpacing: Constants.insetPadding,
                                maxCrossAxisExtent: 360),
                        itemBuilder: (BuildContext context, int index) {
                          // Category category = categoryModel!.categories![index];
                          return KeepAliveMixin(
                            child: EventCard(response: response[index]),
                          );
                        }),
                  )
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
          widget.isMobile
              ? Container()
              : categoryModel != null && widget.partnerid.isEmpty
                  ? Padding(
                      padding: EdgeInsets.only(top: Constants.insetPadding),
                      child: const WebFooter())
                  : Container()
        ])),
      ],
    );
  }
}
