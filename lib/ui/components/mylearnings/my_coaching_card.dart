import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vlivemooc/ui/constants/colors.dart';

import '../../../core/helpers/app_screen_dimen.dart';
import '../../../core/helpers/text_styles.dart';
import '../../../core/helpers/time_calculator.dart';
import '../../../core/models/coaches/coach_model/session_datum.dart';

class MyCoachingCard extends StatefulWidget {
  final SessionDatum sessionData;
  final bool isMobile;

  const MyCoachingCard(
      {super.key, required this.sessionData, required this.isMobile});

  @override
  State<MyCoachingCard> createState() => _MyCoachingCardState();
}

class _MyCoachingCardState extends State<MyCoachingCard> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return widget.isMobile
        ? getMobileView(widget.sessionData)
        : expansionTileContainer(widget.sessionData);
  }

  Widget expansionTileContainer(SessionDatum coachingData) {
    double widthOfImage = 80;
    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    final String formatted = formatter.format(coachingData.starttime!);
    return Theme(
      data: ThemeData().copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SizedBox(
                  height: widthOfImage / 0.67,
                  width: widthOfImage,
                  child: Image.network(
                    "https://d27kvsajbyluqu.cloudfront.net/enrichtv/instructor/Em6xhmCQ.jpeg",
                    fit: BoxFit.fill,
                  ),
                ),
                const SizedBox(width: 10,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    Text(
                        'Session with ${"John Jacob"}' ,
                        style: poppinsMedium(
                          isMobile(context) ? 13 : 16,
                          AppColors.violettextcolor,
                        )),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Icon(
                          Icons.date_range_rounded,
                          size: 18,
                          color: AppColors.violettextcolor,
                        ),
                        sizedBoxWidth5(context),
                        Text(formatted,
                            style: poppinsLight(
                              isMobile(context) ? 12 : 14,
                              AppColors.textLight1,
                            )),
                        sizedBoxWidth10(context),
                        Icon(
                          Icons.access_time_rounded,
                          size: 18,
                          color: AppColors.violettextcolor,
                        ),
                        sizedBoxWidth5(context),
                        Text( widget.sessionData.starttime!=null? DateFormat('hh:mm a')
                            .format(widget.sessionData.starttime!):"",
                            style: poppinsLight(
                              isMobile(context) ? 12 : 14,
                              AppColors.textLight1,
                            )),
                      ],
                    ),
                    const SizedBox(height: 15),
                    TextButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            AppColors.buttonTextBlue),
                      ),
                      onPressed: () {},
                      child: Text(
                        'JOIN',
                        style: poppinsBold(12, AppColors.whiteColor),
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                )
              ],
            )
          ],
        ),
        /*onExpansionChanged: onExpansionChanged,
        initiallyExpanded: initiallyExpanded,*/
        children: [getMoreDetails()],
      ),
    );
  }

  Widget getMobileView(SessionDatum coachingData) {
    double widthOfImage = 80;
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: widthOfImage / 0.67,
                width: widthOfImage,
                child: Image.network(
                  "https://d27kvsajbyluqu.cloudfront.net/enrichtv/instructor/Em6xhmCQ.jpeg",
                  fit: BoxFit.fill,
                ),
              ),
              const SizedBox(width: 10,),
              SizedBox(
                width: MediaQuery.of(context).size.width - 130,
                child: Stack(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                        Text('Session with',
                            style: poppinsMedium(
                              isMobile(context) ? 13 : 16,
                              AppColors.violettextcolor,
                            )),
                        const SizedBox(height: 5),
                        Text("John Jacob" ,
                            style: poppinsMedium(
                              isMobile(context) ? 13 : 16,
                              AppColors.violettextcolor,
                            )),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Icon(
                              Icons.date_range_rounded,
                              size: 18,
                              color: AppColors.violettextcolor,
                            ),
                            sizedBoxWidth5(context),
                            Text(
                              coachingData.starttime?.toString() ?? '',
                              style: poppinsLight(isMobile(context) ? 12 : 14,
                                  AppColors.violettextcolor),
                            ),
                          ],
                        ),
                        sizedBoxHeight5(context),
                        Row(
                          children: [
                            Icon(Icons.access_time_rounded,
                                size: 18,
                                color: AppColors.violettextcolor),
                            sizedBoxWidth5(context),
                            Text(widget.sessionData.starttime!=null? DateFormat('hh:mm a')
                                .format(widget.sessionData.starttime!):"",
                                style: poppinsLight(
                                  isMobile(context) ? 12 : 14,
                                  AppColors.violettextcolor,
                                )),
                          ],
                        ),
                      ],
                    ),
                    Positioned(
                      bottom: 1,
                      right: 1,
                      child: TextButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              AppColors.buttonTextBlue),
                        ),
                        onPressed: () {},
                        child: Text(
                          'JOIN',
                          style: poppinsBold(12, AppColors.whiteColor),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          const SizedBox(
            height: 7,
          ),
          Divider(
            color: AppColors.dividerColor,
            height: 1,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
            child: InkWell(
              onTap: () {
                setState(() {
                  isExpanded = !isExpanded;
                });
              },
              child: Row(
                children: [
                  Text(isExpanded ? "Hide Details" : 'View Details',
                      style: poppinsMedium(
                        12,
                        AppColors.textLight1,
                      )),
                  Icon(
                    isExpanded ? Icons.arrow_downward : Icons.arrow_forward_ios,
                    size: 12,
                    color: AppColors.blackcolor,
                  ),
                ],
              ),
            ),
          ),
          Visibility(visible: isExpanded, child: getMoreDetails()),
        ],
      ),
    );
  }

  getMoreDetails() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isMobile(context)) const Divider(color: Colors.grey),
          sizedBoxHeight20(context),
          Text('Coach Timezone' ,
              style: poppinsMedium(
                isMobile(context) ? 12 : 14,
                AppColors.textLight1,
              )),
          sizedBoxHeight5(context),
          Text(widget.sessionData.starttime?.timeZoneName??"Asia/Calcutta" ,
              style: poppinsMedium(
                isMobile(context) ? 12 : 14,
                AppColors.violettextcolor,
              )),
          sizedBoxHeight10(context),
          Text(widget.sessionData.title??"",
              style: poppinsMedium(
                isMobile(context) ? 14 : 16,
                AppColors.violettextcolor,
              )),
          sizedBoxHeight8(context),
          Text(
              widget.sessionData.description??"",
              style: TextStyle(
                  fontSize: isMobile(context) ? 12 : 14,
                  color: AppColors.textLight1,
                  fontWeight: FontWeight.w400,
                  fontFamily: "DMSans-Medium",
                  height: 1.5)),
          sizedBoxHeight15(context),
          Text('Created: ${TimeCalculator().formatDateMMMddYYYY(widget.sessionData.created!)} IST',
              style: poppinsLight(
                isMobile(context) ? 11 : 13,
                AppColors.textLight1,
              )),
          sizedBoxHeight20(context),
        ],
      ),
    );
  }



}
