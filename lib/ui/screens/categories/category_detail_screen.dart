import 'package:flutter/material.dart';
import 'package:vlivemooc/core/models/category/category_model/category.dart';
import 'package:vlivemooc/core/network/network_handler.dart';
import 'package:vlivemooc/core/objects/content_tab_item.dart';
import 'package:vlivemooc/ui/animations/loading_animation.dart';
import 'package:vlivemooc/ui/responsive/responsive.dart';
import 'package:vlivemooc/ui/screens/categories/mobile_category_detail.dart';
import 'package:vlivemooc/ui/screens/categories/web_category_detail.dart';

class CategoryDetail extends StatefulWidget {
  final Category? category;
  final String categoryid;
  const CategoryDetail(
      {super.key, required this.category, required this.categoryid});

  @override
  State<CategoryDetail> createState() => _CategoryDetailState();
}

class _CategoryDetailState extends State<CategoryDetail> {
  Category? category;
  @override
  void initState() {
    super.initState();
    if (widget.category == null) {
      getCategory();
    } else {
      category = widget.category;
      initializeContentTabs(category!);
    }
  }

  getCategory() async {
    Category categoryObj = await NetworkHandler.getCategory(widget.categoryid);
    setState(() {
      category = categoryObj;
    });
    initializeContentTabs(categoryObj);
  }

  initializeContentTabs(Category category) {
    List<ContentTabItem> slugList = [];
    slugList.add(ContentTabItem(
        tabName: "All",
        idgenre: category.title!,
        objectType: "",
        categoryType: ''));
    slugList.add(ContentTabItem(
        tabName: "Videos",
        idgenre: category.title!,
        objectType: "CONTENT",
        categoryType: '["MOVIE"]'));
    slugList.add(ContentTabItem(
        tabName: "Courses",
        idgenre: category.title!,
        objectType: "SERIES",
        categoryType: '["COURSE"]'));
    slugList.add(ContentTabItem(
      tabName: "Coaches",
      idgenre: category.title!,
    ));
    slugList.add(ContentTabItem(
      tabName: "Events",
      idgenre: category.title!,
    ));

    setState(() {
      contentTabs = slugList;
    });
  }

  List<ContentTabItem> contentTabs = [];

  @override
  Widget build(BuildContext context) {
    if (category == null) {
      return const Scaffold(
        body: Center(
          child: LoadingAnimation(),
        ),
      );
    }
    return Responsive(
      mobileView: MobileCategoryDetail(
        category: category!,
        contentTabs: contentTabs,
      ),
      desktopView: WebCategoryDetail(
        category: category!,
        contentTabs: contentTabs,
      ),
    );
  }
}
