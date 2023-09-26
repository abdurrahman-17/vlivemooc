import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vlivemooc/ui/constants/string_constants.dart';

import '../../../core/helpers/app_screen_dimen.dart';
import '../../../core/helpers/route_generator.dart';
import '../../../core/models/coaches/events_model/events_model.dart';
import '../../../core/models/coaches/events_model/response.dart';
import '../../../core/network/network_handler.dart';
import '../../../core/provider/user_provider.dart';
import '../../constants/colors.dart';
import '../../constants/constants.dart';
import '../cards/event_card.dart';

class EventsLayout extends StatefulWidget {
  final String showAll;

  const EventsLayout({super.key,  this.showAll=""});

  @override
  State<EventsLayout> createState() => _EventsLayoutState();
}

class _EventsLayoutState extends State<EventsLayout> {
  List<Response> response = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getEvents();
    _controller.addListener(() {
      setState(() {
        isScrollStart = true;
        isScrollEnd = true;
      });
      if (_controller.position.atEdge) {
        bool isStart = _controller.position.pixels == 0;
        if (isStart) {
          setState(() {
            isScrollStart = false;
            isScrollEnd = true;
          });
        } else {
          setState(() {
            isScrollStart = true;
            isScrollEnd = false;
          });
        }
      }
    });
  }

  getEvents() async {
    bool isLoggedin =
        Provider.of<UserProvider>(context, listen: false).isLoggedIn;
    List<Response> slug = [];

    EventsModel? data;
    try {
      data = await NetworkHandler.getEvents(isLoggedin: isLoggedin);
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
    setState(() {
      response = slug;
      isLoading = false;
    });
  }

  final ScrollController _controller = ScrollController();
  bool isScrollStart = false;
  bool isScrollEnd = true;

  void _scrollTo(bool forward) {
    double scrollTo = _controller.position.pixels;
    double sensitivity = 150;
    if (forward) {
      scrollTo = scrollTo + sensitivity;
    } else {
      scrollTo = scrollTo - sensitivity;
    }
    _controller.animateTo(
      scrollTo,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeIn,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (response.isEmpty) {
      return Container();
    }
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Constants.insetPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  StringConstants.events,
                  style: const TextStyle(
                      fontSize: Constants.fontSizeLarge,
                      fontWeight: FontWeight.bold),
                ),
              ),
              widget.showAll.isEmpty
                  ? Container()
                  : TextButton(
                      onPressed: () {
                        RouteGenerator().navigate(context, widget.showAll);
                      },
                      child: Text(
                        "Show All",
                        style: TextStyle(color: AppColors.primaryColor),
                      ))
            ],
          ),

          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                height: isMobile(context) ? 300 : 320,
                child: ListView.builder(
                    controller: _controller,
                    itemCount: response.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      return SizedBox(
                          width: isMobile(context) ? 240 : 280,
                          child: EventCard(response: response[index]));
                    }),
              ),
              Positioned(
                left: 0,
                child: Visibility(
                  visible: isScrollStart,
                  maintainAnimation: true,
                  maintainState: true,
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.fastOutSlowIn,
                    opacity: isScrollStart ? 1 : 0,
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
                right: 0,
                child: Visibility(
                  visible: isScrollEnd,
                  maintainAnimation: true,
                  maintainState: true,
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.fastOutSlowIn,
                    opacity: isScrollEnd ? 1 : 0,
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
            ],
          )
        ],
      ),
    );
  }
}
