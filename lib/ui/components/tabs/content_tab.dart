import 'package:flutter/material.dart';
import 'package:vlivemooc/core/helpers/app_screen_dimen.dart';
import 'package:vlivemooc/core/objects/content_tab_item.dart';
import 'package:vlivemooc/ui/components/layout/coaches_grid_layout.dart';
import 'package:vlivemooc/ui/components/layout/content_grid_layout.dart';
import 'package:vlivemooc/ui/components/layout/event_grid_layout.dart';
import 'package:vlivemooc/ui/components/mixins/keep_alive_mixin.dart';
import 'package:vlivemooc/ui/constants/colors.dart';
import 'package:vlivemooc/ui/constants/constants.dart';

import '../footer/web_footer.dart';

class ContentTab extends StatefulWidget {
  final List<ContentTabItem> tabList;
  final bool paginationEnabled;
  final bool shouldRenderFooter;
  final bool isCoachMobile;

  const ContentTab(
      {super.key,
        required this.tabList,
        this.paginationEnabled = false,
        this.shouldRenderFooter = true,
        this.isCoachMobile = false});

  @override
  State<ContentTab> createState() => _ContentTabState();
}

class _ContentTabState extends State<ContentTab> {
  int indexTab = 0;
  List<Widget> pages = [];

  @override
  void initState() {
    super.initState();
    for (var i = 0; i < widget.tabList.length; i++) {
      if (widget.tabList[i].tabName == "Coaches") {
        pages.add(KeepAliveMixin(
          child: CoachesGridLayout(
            category: widget.tabList[i].idgenre,
          ),
        ));
      } else if (widget.tabList[i].tabName == "Events") {
        pages.add(KeepAliveMixin(
          child: EventsGridLayout(
            renderEmpty: true,
            category: widget.tabList[i].idgenre,
            partnerid: widget.tabList[i].partnerid,
          ),
        ));
      } else {
        pages.add(KeepAliveMixin(
          child: ContentGridLayout(
            title: "",
            listType: widget.tabList[i].listType,
            objectType: widget.tabList[i].objectType,
            categoryType: widget.tabList[i].categoryType,
            partnerid: widget.tabList[i].partnerid,
            idgenre: widget.tabList[i].idgenre,
            paginationEnabled: widget.paginationEnabled,
          ),
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: widget.tabList.length,
      initialIndex: indexTab,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: SizedBox(
              width: isMobile(context) ? double.infinity : 500,
              child: TabBar(
                  onTap: (index) {
                    setState(() {
                      indexTab = index;
                    });
                  },
                  isScrollable: true,
                  indicatorColor: AppColors.primaryColor,
                  labelColor: AppColors.primaryColor,
                  unselectedLabelColor: Colors.black,
                  tabs: List<Widget>.generate(widget.tabList.length, (index) {
                    return Tab(
                      text: widget.tabList[index].tabName,
                    );
                  })),
            ),
          ),
          const SizedBox(
            height: Constants.semanticMarginTen,
          ),
          Container(
            constraints: widget.isCoachMobile
                ? const BoxConstraints(maxHeight: 370, minHeight: 100)
                : const BoxConstraints(maxHeight: 700, minHeight: 400),
            child: TabBarView(
              children: pages,
            ),
          ),
          if(!isMobile(context))  if(widget.shouldRenderFooter) const WebFooter()
        ],
      ),
    );
  }
}
