import 'package:flutter/material.dart';
import 'package:vlivemooc/ui/components/category/categories.dart';
import 'package:vlivemooc/ui/components/layout/content_grid_layout.dart';

import '../../constants/constants.dart';
import '../footer/web_footer.dart';

class Courses extends StatefulWidget {
  final bool isMobile;
  const Courses({super.key, this.isMobile = true});

  @override
  State<Courses> createState() => _CoursesState();
}

class _CoursesState extends State<Courses> {
  bool hasPageLoaded = false;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // const BreadCrumbs(path: "Home/Courses"),
          Categories(
            onLoadCallback: (categories) {}, renderScrollButtons: !widget.isMobile,
          ),
          ContentGridLayout(
            title: "Courses",
            listType: "",
            objectType: "SERIES",
            categoryType: '["COURSE"]',
            onContentLoaded: () {
              setState(() {
                hasPageLoaded = true;
              });
            },
            shrinkWrap: true,
          ),
          widget.isMobile
              ? Container()
              : hasPageLoaded
              ? Padding(
              padding: EdgeInsets.only(top: Constants.insetPadding),
              child: const WebFooter())
              : Container()
        ],
      ),
    );
  }
}
