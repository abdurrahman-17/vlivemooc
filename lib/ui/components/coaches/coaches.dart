import 'package:flutter/material.dart';
import 'package:vlivemooc/ui/components/category/categories.dart';
import 'package:vlivemooc/ui/components/footer/web_footer.dart';
import 'package:vlivemooc/ui/components/layout/coaches_grid_layout.dart';
import 'package:vlivemooc/ui/constants/string_constants.dart';

import '../../constants/constants.dart';

class Coaches extends StatefulWidget {
  final bool isMobile;
  const Coaches({super.key, this.isMobile = true});

  @override
  State<Coaches> createState() => _CoachesState();
}

class _CoachesState extends State<Coaches> {
  bool hasPageLoaded = false;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Categories(renderScrollButtons: ! widget.isMobile,),
          Container(
            padding:  EdgeInsets.symmetric(horizontal:Constants.insetPadding),
            child: Text(
              StringConstants.coaches,
              style: const TextStyle(
                  fontSize: Constants.fontSizeLarge,
                  fontWeight: FontWeight.bold),
            ),
          ),
          CoachesGridLayout(
            onLoadCallback: (model) {
              setState(() {
                hasPageLoaded = true;
              });
            },
          ),
          widget.isMobile
              ? Container()
              : hasPageLoaded
              ? const WebFooter()
              : Container(),
        ],
      ),
    );
  }
}
