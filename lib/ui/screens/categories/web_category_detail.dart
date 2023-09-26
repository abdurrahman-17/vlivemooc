import 'package:flutter/material.dart';
import 'package:vlivemooc/core/models/category/category_model/category.dart';
import 'package:vlivemooc/ui/components/category/categories.dart';
import 'package:vlivemooc/ui/components/tabs/content_tab.dart';

import '../../../core/objects/content_tab_item.dart';
import '../../components/appbar/top_bar.dart';
import '../../constants/colors.dart';
import '../../constants/constants.dart';

class WebCategoryDetail extends StatefulWidget {
  final Category category;
  final List<ContentTabItem> contentTabs;

  const WebCategoryDetail(
      {super.key, required this.category, required this.contentTabs});

  @override
  State<WebCategoryDetail> createState() => _WebCategoryDetailState();
}

class _WebCategoryDetailState extends State<WebCategoryDetail> {
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(
        logoPath: "assets/images/logo_white.png",
        backgroundColor: AppColors.primaryColor,
        renderNav: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          color: AppColors.accentColor,
          child: Column(
            children: [
              SizedBox(
                height: Constants.insetPadding,
              ),
              Row(
                children: [
                  SizedBox(
                    width: Constants.insetPadding,
                  ),
                  CategoryCard(
                    category: widget.category,
                    shouldRoute: false,
                    renderTitle: false,
                    imageWidth: 100,
                    imageHeight: 100,
                  ),
                  SizedBox(
                    width: Constants.insetPadding,
                  ),
                  Expanded(
                    flex: 5,
                    child: Padding(
                      padding: EdgeInsets.all(Constants.insetPadding),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.category.title!,
                            style: const TextStyle(
                                fontSize: Constants.fontSizeMedium,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: Constants.semanticsMarginExSmall,
                          ),
                          Text(
                            widget.category.description!,
                            style: const TextStyle(
                                fontSize: Constants.fontSizeSmall,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  ),
                  //needed empty expanded with container for page margin
                  Expanded(flex: 3, child: Container())
                ],
              ),
              ContentTab(
                tabList: widget.contentTabs,
                paginationEnabled: true,
              )
            ],
          ),
        ),
      ),
    );
  }
}
