import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:vlivemooc/core/helpers/amount_helper.dart';
import 'package:vlivemooc/core/helpers/route_generator.dart';
import 'package:vlivemooc/core/helpers/text_styles.dart';
import 'package:vlivemooc/core/models/coaches/events_model/response.dart';
import 'package:vlivemooc/ui/components/buttons/book_event.dart';
import 'package:vlivemooc/ui/constants/colors.dart';
import 'package:vlivemooc/ui/constants/constants.dart';
import 'package:vlivemooc/ui/routes/Routes.dart';

class EventCard extends StatelessWidget {
  final Response response;
  final bool shouldRoutePush;

  const EventCard(
      {super.key, required this.response, this.shouldRoutePush = false});

  @override
  Widget build(BuildContext context) {
    String? amount = response.amount;
    try {
      if (amount != null) {
        double amt = double.parse(amount);
        amt = amt / 100;
        amount = amt.toString();
      }
    } catch (err) {
      //do nothing
    }
    return InkWell(
      onTap: () {
        if (shouldRoutePush) {
          context.push(RouteGenerator.generateEventRoute(
              base: AppRouter.events, event: response));
        } else {
          RouteGenerator().navigate(
              context,
              RouteGenerator.generateEventRoute(
                  base: AppRouter.events, event: response));
        }
      },
      child: Card(
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.transparent,
            //color: Colors.red,
            borderRadius: BorderRadius.all(
              Radius.circular(7.0),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                  aspectRatio: 16 / 9,
                  child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(Constants.cardBorderRadius),
                          topLeft: Radius.circular(Constants.cardBorderRadius)),
                      child: response.thumbnail!.isEmpty
                          ? Image.asset("assets/images/logo_on_white.png")
                          : Image.network(
                              response.thumbnail!,
                              fit: BoxFit.cover,
                            ))),
              getEventDateBelowImage(response),
              Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  child: Text(response.title!,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: poppinsLight(15, AppColors.blackcolor))),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text.rich(
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          TextSpan(
                            text: "Speaker : ",
                            style: TextStyle(
                                fontSize: 14,
                                fontFamily: "Inter-Regular",
                                color: AppColors.greytextcolor),
                            children: [
                              TextSpan(
                                text: "${response.name}",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Inter-Regular",
                                    color: AppColors.greytextcolor),
                              )
                            ],
                          ),
                        )),
                    const SizedBox(
                      height: Constants.cardBorderRadius,
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                      child: Row(
                        children: [
                          Expanded(
                              flex: 1,
                              child: response.amount!.isNotEmpty
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
                                          color: AppColors.violettextcolor))),
                          SizedBox(
                              width: 85, child: BookEvent(event: response)),
                          const SizedBox(
                            width: 5,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  static getEventDateBelowImage(Response response) {
    String getMonthName(int month) {
      switch (month) {
        case 1:
          return 'January';
        case 2:
          return 'February';
        case 3:
          return 'March';
        case 4:
          return 'April';
        case 5:
          return 'May';
        case 6:
          return 'June';
        case 7:
          return 'July';
        case 8:
          return 'August';
        case 9:
          return 'September';
        case 10:
          return 'October';
        case 11:
          return 'November';
        case 12:
          return 'December';
        default:
          return '';
      }
    }

    DateTime now = response.starttime!;

    String day = now.day.toString();
    String month = getMonthName(now.month);
    String formattedTime = DateFormat.Hms().format(now);

    String formattedDate = '$day $month';
    return Container(
      color: AppColors.lighterpink,
      width: double.infinity,
      child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: Constants.semanticMarginTen,
              vertical: Constants.semanticMarginTen),
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                    text: formattedDate,
                    style: TextStyle(
                      color: AppColors.violettextcolor,
                      fontSize: 13.0,
                      fontFamily: "Inter-SemiBold",
                    )),
                TextSpan(
                  text: " @ $formattedTime",
                  style: TextStyle(
                    color: AppColors.redcolor,
                    fontSize: 13.0,
                    fontFamily: "Inter-SemiBold",
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
