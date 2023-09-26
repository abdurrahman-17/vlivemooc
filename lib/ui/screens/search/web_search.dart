import 'package:flutter/material.dart';
import 'package:vlivemooc/ui/components/footer/web_footer.dart';

import '../../components/appbar/top_bar.dart';
import '../../constants/colors.dart';
import '../bottomnav/search.dart';

class WebSearch extends StatelessWidget {
  const WebSearch({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(
        logoPath: "assets/images/logo_white.png",
        backgroundColor: AppColors.primaryColor,
        renderNav: true,
          isSearchPage:true
      ),
      body: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [Expanded(child: Search(isMobile: false,)), WebFooter()],
      ),
    );
  }
}
