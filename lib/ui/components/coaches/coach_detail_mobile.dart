import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:vlivemooc/core/objects/content_tab_item.dart';
import 'package:vlivemooc/ui/components/buttons/book_session.dart';
import 'package:vlivemooc/ui/components/buttons/share_button.dart';
import 'package:vlivemooc/ui/components/tabs/content_tab.dart';
import '../../../core/models/coaches/coach_model/datum.dart';
import '../../constants/colors.dart';
import '../../constants/constants.dart';
import '../text/show_more_text.dart';
import 'coach_detail_components.dart';

class CoachDetailMobile extends StatefulWidget {
  final Datum coach;
  final List<ContentTabItem> tabList;
  const CoachDetailMobile(
      {super.key, required this.coach, required this.tabList});

  @override
  State<CoachDetailMobile> createState() => _CoachDetailMobileState();
}

class _CoachDetailMobileState extends State<CoachDetailMobile> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: true,
        bottom: true,
        left: true,
        right: true,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.primaryColor,
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: ShareButtonCoach(
                    content: widget.coach,
                    onTap: () async {
                      // final ByteData bytes = await rootBundle.load('assets/images/image.png'); // Replace with your image path
                      // final Uint8List imageData = bytes.buffer.asUint8List();

                      String title = widget.coach.partnername!;
                      String description =
                      widget.coach.description!.length > 100
                          ? widget.coach.description!.substring(0, 100)
                          : widget.coach.description!;
                      String url = widget.coach.profilepicture;

                      await Share.share('$title\n\n$description\n\n$url');
                    }),
              )
            ],
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(Constants.insetPadding),
              color: AppColors.accentColor,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                          flex: 3,
                          child:
                          ImageLayout(path: widget.coach.profilepicture!)),
                      SizedBox(
                        width: Constants.insetPadding,
                      ),
                      Expanded(
                          flex: 5,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TitleLayout(coach: widget.coach, isMobile: true),
                              const SizedBox(
                                height: Constants.semanticsMarginExSmall,
                              ),
                              widget.coach.tags != null
                                  ? SizedBox(
                                height: Constants.insetPadding,
                              )
                                  : Container(),
                              TagsListView(tags: widget.coach.tags!),
                              SizedBox(
                                height: Constants.insetPadding,
                              ),
                            ],
                          ))
                    ],
                  ),
                  const SizedBox(
                    height: Constants.semanticMarginDefault,
                  ),
                  // const StatisticsListView(
                  //   isMobile: true,
                  // ),
                  ShowMoreText(text: widget.coach.description ?? ""),
                  SizedBox(
                    height: Constants.insetPadding,
                  ),
                  BookSession(
                    coach: widget.coach,
                  ),
                  ContentTab(tabList: widget.tabList,paginationEnabled: true,isCoachMobile: true,)
                ],
              ),
            ),
          ),
        ));
  }
}
