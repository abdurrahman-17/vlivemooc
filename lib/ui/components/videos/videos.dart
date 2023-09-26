// import 'package:flutter/material.dart';
// import 'package:vlivemooc/ui/components/breadcrumbs/breadcrumbs.dart';
// import 'package:vlivemooc/ui/components/category/categories.dart';
// import 'package:vlivemooc/ui/components/layout/content_grid_layout.dart';

// class Videos extends StatelessWidget {
//   const Videos({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return CustomScrollView(
//       slivers: [
//         SliverList(
//             delegate: SliverChildListDelegate(
//           [
//             const BreadCrumbs(path: "Home/Videos"),
//             const Categories(),
//           ],
//         )),
//         const ContentGridLayout(
//           title: "Videos",
//           listType: "",
//           objectType: "CONTENT",
//           categoryType: '["MOVIE"]',
//         )
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:vlivemooc/core/models/category/category_model/category.dart';
import 'package:vlivemooc/core/models/category/category_model/category_model.dart';
import 'package:vlivemooc/ui/components/category/categories.dart';
import 'package:vlivemooc/ui/components/footer/web_footer.dart';
import 'package:vlivemooc/ui/components/layout/content_layout.dart';
import 'package:vlivemooc/ui/components/mixins/keep_alive_mixin.dart';
import 'package:vlivemooc/ui/constants/constants.dart';
import 'package:vlivemooc/ui/screens/continue_learning/continue_learning.dart';

import '../../../core/helpers/route_generator.dart';
import '../../routes/Routes.dart';

class Videos extends StatefulWidget {
  final bool isMobile;

  const Videos({super.key, this.isMobile = true});

  @override
  State<Videos> createState() => _VideosState();
}

class _VideosState extends State<Videos> {
  CategoryModel? categoryModel;

  onCategoryLoaded(CategoryModel model) {
    setState(() {
      categoryModel = model;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverList(
            delegate: SliverChildListDelegate([
          const SizedBox(
            height: Constants.semanticsMarginExSmall,
          ),
          // const BreadCrumbs(path: "Home/Videos"),
          Categories(
            onLoadCallback: onCategoryLoaded,
            renderScrollButtons: !widget.isMobile,
          ),
        ])),
        SliverList(
            delegate: SliverChildListDelegate([
          const ContinueLearning(
              title: Constants.continueWatching, isOnlyVidoes: true),
        ])),
        categoryModel != null
            ? SliverList.builder(
                itemCount: categoryModel!.categories!.length,
                itemBuilder: (BuildContext context, int index) {
                  Category category = categoryModel!.categories![index];
                  return KeepAliveMixin(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          bottom: Constants.semanticMarginDefault),
                      child: ContentLayout(
                        title: category.title!,
                        objectType: "CONTENT",
                        listType: '',
                        showAll: RouteGenerator.generateCategoryRoute(
                            category: category, base: AppRouter.categories),
                        categoryType: '["MOVIE"]',
                        idgenre: category.title!,
                        renderEmpty: true,
                      ),
                    ),
                  );
                })
            : const SliverPadding(
                padding: EdgeInsets.zero,
              ),
        SliverList(
            delegate: SliverChildListDelegate([
          widget.isMobile
              ? Container()
              : categoryModel != null
                  ? Padding(
                      padding: EdgeInsets.only(top: Constants.insetPadding),
                      child: const WebFooter())
                  : Container()
        ])),
      ],
    );
  }
}
