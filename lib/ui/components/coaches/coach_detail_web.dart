import 'package:flutter/material.dart';
import 'package:vlivemooc/ui/components/appbar/top_bar.dart';
import 'package:vlivemooc/ui/components/buttons/book_session.dart';
import 'package:vlivemooc/ui/components/footer/web_footer.dart';
import 'package:vlivemooc/ui/components/tabs/content_tab.dart';

import '../../../core/models/coaches/coach_model/datum.dart';
import '../../../core/objects/content_tab_item.dart';
import '../../constants/colors.dart';
import '../../constants/constants.dart';
import 'coach_detail_components.dart';

class CoachDetailWeb extends StatefulWidget {
  final Datum coach;
  final List<ContentTabItem> tabList;
  const CoachDetailWeb({super.key, required this.coach, required this.tabList});

  @override
  State<CoachDetailWeb> createState() => _CoachDetailWebState();
}

class _CoachDetailWebState extends State<CoachDetailWeb> {
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
          appBar: TopBar(
            logoPath: "assets/images/logo_white.png",
            backgroundColor: AppColors.primaryColor,
            renderNav: true,
          ),
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // const BreadCrumbs(path: "Home/Coaches"),
                Container(
                  padding: EdgeInsets.all(Constants.insetPadding),
                  color: AppColors.accentColor,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                          flex: 1,
                          child:
                          ImageLayout(path: widget.coach.profilepicture!)),
                      SizedBox(
                        width: Constants.insetPadding,
                      ),
                      Expanded(
                          flex: 3,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TitleLayout(coach: widget.coach, isMobile: false),
                              const SizedBox(
                                height: Constants.semanticsMarginExSmall,
                              ),
                              Text(widget.coach.description ?? "",
                                  style: const TextStyle(
                                      fontSize: Constants.fontSizeMedium,
                                      color: Colors.grey)),
                              widget.coach.tags != null
                                  ? SizedBox(
                                height: Constants.insetPadding,
                              )
                                  : Container(),
                              TagsListView(tags: widget.coach.tags!),
                              // const SizedBox(
                              //   height: 50,
                              // ),
                              // const StatisticsListView(),
                              const SizedBox(
                                height: Constants.semanticMarginDefault,
                              ),
                              SizedBox(
                                  width: 150,
                                  child: BookSession(
                                    coach: widget.coach,
                                  ))
                            ],
                          ))
                    ],
                  ),
                ),
                ContentTab(tabList: widget.tabList,paginationEnabled: true,shouldRenderFooter: false),
                const WebFooter()
              ],
            ),
          ),
        ));
  }
}
