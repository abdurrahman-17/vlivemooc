import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:vlivemooc/core/helpers/app_screen_dimen.dart';
import 'package:vlivemooc/core/helpers/route_generator.dart';
import 'package:vlivemooc/core/models/category/category_model/category.dart';
import 'package:vlivemooc/core/models/category/category_model/category_model.dart';
import 'package:vlivemooc/core/network/network_handler.dart';
import 'package:vlivemooc/ui/constants/constants.dart';
import 'package:shimmer/shimmer.dart';
import 'package:vlivemooc/ui/routes/routes.dart';

import '../../../core/helpers/text_styles.dart';
import '../../constants/colors.dart';

class Categories extends StatefulWidget {
  final Function? onLoadCallback;
  final bool renderScrollButtons;
  const Categories(
      {super.key, this.onLoadCallback, this.renderScrollButtons = true});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> with AutomaticKeepAliveClientMixin{
  @override
  bool get wantKeepAlive => true;
  CategoryModel? categoryModel;
  final ScrollController _controller = ScrollController();
  bool isScrollStart = false;
  bool isScrollEnd = true;

  @override
  void initState() {
    super.initState();
    getCategories();
    _controller.addListener(() {
      setState(() {
        isScrollStart = true;
        isScrollEnd = true;
      });
      if (_controller.position.atEdge) {
        bool isStart = _controller.position.pixels == 0;
        if (isStart) {
          setState(() {
            isScrollStart = false;
            isScrollEnd = true;
          });
        } else {
          setState(() {
            isScrollStart = true;
            isScrollEnd = false;
          });
        }
      }
    });
  }

  getCategories() async {
    CategoryModel model = await NetworkHandler.getCategories();
    setState(() {
      categoryModel = model;
    });
    if (widget.onLoadCallback != null) {
      widget.onLoadCallback!(model);
    }
  }

  void _scrollTo(bool forward) {
    double scrollTo = _controller.position.pixels;
    double sensitivity = 150;
    if (forward) {
      scrollTo = scrollTo + sensitivity;
    } else {
      scrollTo = scrollTo - sensitivity;
    }
    _controller.animateTo(
      scrollTo,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeIn,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    if (categoryModel == null || categoryModel!.categories == null) {
      return Padding(
        padding: EdgeInsets.all(Constants.insetPadding),
        child: SizedBox(
          height: Constants.categoryCardDimens,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 10,
              itemBuilder: (BuildContext ctx, int index) {
                return const CategoryCardShimmer();
              }),
        ),
      );
    }

    bool isMobil = isMobile(context);
    return Container(
      margin: EdgeInsets.only(top: Constants.insetPadding),
      padding: EdgeInsets.symmetric(horizontal: Constants.insetPadding),
      child: Stack(
        children: [
          SizedBox(
            height: isMobil
                ? Constants.categoryCardMobileDimensHight
                : Constants.categoryCardDimensHight,
            child: ListView.separated(
              controller: _controller,
              scrollDirection: Axis.horizontal,
              itemCount: categoryModel!.categories!.length,
              itemBuilder: (BuildContext ctx, int index) {
                Category category = categoryModel!.categories![index];
                return CategoryCard(
                  category: category,
                  imageWidth: isMobil
                      ? Constants.categoryCardMobileDimens
                      : Constants.categoryCardDimens,
                  imageHeight: isMobil
                      ? Constants.categoryCardMobileDimens
                      : Constants.categoryCardDimens,
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(
                  width: Constants.insetPadding + 5,
                );
              },
            ),
          ),
          widget.renderScrollButtons
              ? Positioned(
                  left: 0,
                  top: isMobil ? 20 : 40,
                  child: Visibility(
                    visible: isScrollStart,
                    maintainAnimation: true,
                    maintainState: true,
                    child: AnimatedOpacity(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.fastOutSlowIn,
                      opacity: isScrollStart ? 1 : 0,
                      child: FloatingActionButton.small(
                        heroTag: UniqueKey().toString(),
                        backgroundColor: AppColors.primaryColor,
                        foregroundColor: Colors.white,
                        onPressed: () {
                          _scrollTo(false);
                        },
                        child: const Icon(Icons.arrow_back),
                      ),
                    ),
                  ),
                )
              : Container(),
          widget.renderScrollButtons
              ? Positioned(
                  right: 0,
                  top: isMobil ? 20 : 40,
                  child: Visibility(
                    visible: isScrollEnd,
                    maintainAnimation: true,
                    maintainState: true,
                    child: AnimatedOpacity(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.fastOutSlowIn,
                      opacity: isScrollEnd ? 1 : 0,
                      child: FloatingActionButton.small(
                        heroTag: UniqueKey().toString(),
                        backgroundColor: AppColors.primaryColor,
                        foregroundColor: Colors.white,
                        onPressed: () {
                          _scrollTo(true);
                        },
                        child: const Icon(Icons.arrow_forward),
                      ),
                    ),
                  ),
                )
              : Container()
        ],
      ),
    );
  }
}

class CategoryCardShimmer extends StatelessWidget {
  const CategoryCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: Constants.insetPadding),
      child: SizedBox(
        width: Constants.categoryCardDimens,
        height: Constants.categoryCardDimens,
        child: Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade200,
          child: Container(
            width: Constants.categoryCardDimens,
            height: Constants.categoryCardDimens,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: Colors.grey.shade200,
            ),
          ),
        ),
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final Category category;
  final bool shouldRoute;
  final bool renderTitle;
  final double imageWidth;
  final double imageHeight;
  final double imageSize;
  final double borderWidth;
  const CategoryCard({
    super.key,
    required this.category,
    this.shouldRoute = true,
    this.renderTitle = true,
    this.imageWidth = Constants.categoryCardDimens,
    this.imageHeight = Constants.categoryCardDimens,
    this.imageSize = 30,
    this.borderWidth = 3,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: imageWidth,
      child: InkWell(
        hoverColor: Colors.transparent,
        onTap: () {
          if (!shouldRoute) {
            return;
          }
          RouteGenerator().navigate(
              context,
              RouteGenerator.generateCategoryRoute(
                  category: category, base: AppRouter.categories),
              extra: category);
        },
        child: Column(
          children: [
            SizedBox(
              width: imageWidth,
              height: imageHeight,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(imageWidth),
                child: CachedNetworkImage(
                  imageUrl: category.icon ?? "",
                  fit: BoxFit.fill,
                ),
              ),
            ),
            renderTitle ? sizedBoxHeight8(context) : Container(),
            renderTitle
                ? Text(category.title!,
                textAlign: TextAlign.center,
                style:  poppinsMedium(isMobile(context)?Constants.semanticMarginTen:Constants.fontSizeSmall, AppColors.blackcolor))
          : Container(),
          ],
        ),
      ),
    );
  }
}
