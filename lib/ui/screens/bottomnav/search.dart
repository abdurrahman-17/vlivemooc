import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vlivemooc/ui/animations/loading_animation.dart';
import 'package:vlivemooc/ui/components/layout/coaches_grid_layout.dart';
import 'package:vlivemooc/ui/components/layout/event_grid_layout.dart';
import 'package:vlivemooc/ui/components/search/search_results_layout.dart';
import 'package:vlivemooc/ui/constants/constants.dart';

import '../../../core/provider/search_provider.dart';
import '../../constants/colors.dart';

class Search extends StatelessWidget {
  final bool isMobile;

  const Search({super.key, this.isMobile = true});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
          padding: EdgeInsets.all(Constants.insetPadding),
          child: Consumer<SearchProvider>(builder:
              (BuildContext context, SearchProvider notifier, Widget? child) {
            if (notifier.query.isEmpty) {
              return Container();
            }
            return DefaultTabController(
              length: 5,
              child: notifier.isSearching
                  ? const LoadingAnimation()
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Showing results for "${notifier.query}"',
                          style: const TextStyle(
                              fontSize: Constants.fontSizeMedium,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: isMobile ? double.infinity : 500,
                          child: TabBar(
                              indicatorColor: AppColors.primaryColor,
                              labelColor: AppColors.primaryColor,
                              unselectedLabelColor: Colors.black,
                              isScrollable: isMobile,
                              tabs: const [
                                Tab(
                                  text: "All",
                                ),
                                Tab(
                                  text: "Videos",
                                ),
                                Tab(
                                  text: "Courses",
                                ),
                                Tab(
                                  text: "Coaches",
                                ),
                                Tab(
                                  text: "Events",
                                ),
                              ]),
                        ),
                        const SizedBox(
                          height: Constants.semanticsMarginExSmall,
                        ),
                        Expanded(
                          child: TabBarView(children: [
                            SearchResultsLayout(
                                contentModels: notifier.allResults),
                            SearchResultsLayout(
                                contentModels: notifier.videoResults),
                            SearchResultsLayout(
                                contentModels: notifier.courseResults),
                            CoachesGridLayout(
                              coaches: notifier.coachResults,
                            ),
                            EventsGridLayout(
                              events: notifier.eventResults,
                            ),
                          ]),
                        )
                      ],
                    ),
            );
          })),
    );
  }
}
