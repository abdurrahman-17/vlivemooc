import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vlivemooc/ui/components/cards/content_card.dart';

import '../../../core/helpers/app_screen_dimen.dart';
import '../../../core/models/content/content_model/datum.dart';
import '../../../core/provider/search_provider.dart';
import '../../constants/constants.dart';
import '../mixins/keep_alive_mixin.dart';

class SearchResultsLayout extends StatelessWidget {
  final List<Datum> contentModels;

  const SearchResultsLayout({super.key, required this.contentModels});

  @override
  Widget build(BuildContext context) {
    if (contentModels.isEmpty) {
      return Text(Provider.of<SearchProvider>(context).query.isEmpty
          ? "No results found"
          : 'No results found for "${Provider.of<SearchProvider>(context).query}"');
    }
    double width = MediaQuery.of(context).size.width;

    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: Constants.insetPadding),
          sliver: SliverGrid.builder(
              itemCount: contentModels.length,
              gridDelegate: isMobile(context)
                  ? SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisExtent: ( width- Constants.semanticMarginTen),
                      crossAxisSpacing: Constants.semanticMarginTen,
                      mainAxisSpacing: Constants.insetPadding,
                      crossAxisCount: 1)
                  : SliverGridDelegateWithMaxCrossAxisExtent(
                      mainAxisExtent: 350,
                      crossAxisSpacing: Constants.semanticMarginTen,
                      mainAxisSpacing: Constants.insetPadding,
                      maxCrossAxisExtent: Constants.maxContentCardWidthWeb2),
              itemBuilder: (BuildContext context, int index) {
                // Category category = categoryModel!.categories![index];
                return KeepAliveMixin(
                  child: ContentCard(content: contentModels[index]),
                );
              }),
        )
      ],
    );
  }
}
