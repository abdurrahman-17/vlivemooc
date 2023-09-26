import 'package:flutter/material.dart';
import 'package:vlivemooc/ui/screens/search/web_search.dart';

import '../../responsive/responsive.dart';
import 'mobile_search.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Responsive(
        mobileView: MobileSearch(), desktopView: WebSearch());
  }
}
