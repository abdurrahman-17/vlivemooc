import 'package:flutter/material.dart';
import 'package:vlivemooc/core/models/category/category_model/category.dart';
import 'package:vlivemooc/core/objects/content_tab_item.dart';
import 'package:vlivemooc/ui/components/category/categories.dart';
import 'package:vlivemooc/ui/constants/colors.dart';

import '../../components/appbar/mobile_app_bar.dart';
import '../../components/tabs/content_tab.dart';
import '../../constants/constants.dart';

class MobileCategoryDetail extends StatelessWidget {
  final Category category;
  final List<ContentTabItem> contentTabs;
  const MobileCategoryDetail(
      {super.key, required this.category, required this.contentTabs});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      bottom: true,
      left: true,
      right: true,
      child: Scaffold(
          appBar: MobileAppBar(
            titleWidget: Row(children: [
              CategoryCard(
                category: category,
                imageWidth: 30,
                imageHeight: 30,
                imageSize: 15,
                renderTitle: false,
                shouldRoute: false,
                borderWidth: 1,
              ),
              const SizedBox(
                width: Constants.semanticMarginDefault,
              ),
              Text(
                category.title!,
                style: const TextStyle(
                    fontSize: Constants.fontSizeMedium,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ]),
          ),
          body: SingleChildScrollView(
            child: Container(
              color: AppColors.accentColor,
              padding: EdgeInsets.all(Constants.insetPadding),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    category.description!,
                    style: const TextStyle(
                      fontSize: Constants.fontSizeSmall,
                    ),
                  ),
                  SizedBox(height: 800, child: ContentTab(tabList: contentTabs,paginationEnabled: true,))
                ],
              ),
            ),
          )),
    );
  }
}
