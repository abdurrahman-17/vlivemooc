import 'package:flutter/material.dart';
import 'package:vlivemooc/core/network/urls.dart';
import 'package:vlivemooc/ui/components/footer/web_footer.dart';
import 'package:vlivemooc/ui/components/helpers/cross_platform_web_view.dart';

class Blogs extends StatelessWidget {
  const Blogs({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: CrossPlatformWebView(
              url: AppUrls.providerBlogsUrl,
              onResponse: (response) {},
              renderNavs: true,
            ),
          ),
          const WebFooter(),
        ],
      ),
    );
  }
}
