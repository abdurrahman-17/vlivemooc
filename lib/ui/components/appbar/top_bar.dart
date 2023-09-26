import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:vlivemooc/core/helpers/app_screen_dimen.dart';
import 'package:vlivemooc/core/helpers/route_generator.dart';
import 'package:vlivemooc/core/live/live_tv.dart';
import 'package:vlivemooc/core/network/urls.dart';
import 'package:vlivemooc/core/provider/user_provider.dart';
import 'package:vlivemooc/ui/components/buttons/accounts_button.dart';
import 'package:vlivemooc/ui/components/buttons/login_button.dart';
import 'package:vlivemooc/ui/components/buttons/notifications_button.dart';
import 'package:vlivemooc/ui/components/buttons/search_button.dart';
import 'package:vlivemooc/ui/constants/constants.dart';
import 'package:vlivemooc/ui/routes/Routes.dart';

import '../buttons/live_tv_button.dart';
import '../buttons/logo_button.dart';

class TopBar extends StatelessWidget implements PreferredSizeWidget {
  final String logoPath;
  final Color backgroundColor;
  final bool renderNav;
  final bool isSearchPage;
  @override
  final Size preferredSize;

  const TopBar(
      {super.key,
      required this.logoPath,
      this.preferredSize = const Size.fromHeight(Constants.appBarHeight),
      this.renderNav = false,
      this.backgroundColor = Colors.white,
      this.isSearchPage = false});

  @override
  Widget build(BuildContext context) {
    bool isLoggedIn = Provider.of<UserProvider>(context).isLoggedIn;
    return AppBar(
      automaticallyImplyLeading:
          (defaultTargetPlatform == TargetPlatform.android &&
                  getScreenWidth(context) > 600)
              ? false
              : true,
      toolbarHeight: Constants.appBarHeight,
      backgroundColor: backgroundColor,
      elevation: Constants.appBarElevation,
      title: Row(
        children: [
          LogoButton(
            assetURI: logoPath,
          ),
          const SizedBox(
            width: Constants.defaultPagePadding,
          ),
          Expanded(
              flex: 10,
              child: renderNav
                  ? const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        NavLink(
                          text: "Home",
                          route: AppRouter.home,
                        ),
                        NavLink(
                          text: "Videos",
                          route: AppRouter.videos,
                        ),
                        NavLink(
                          text: "Courses",
                          route: AppRouter.courses,
                        ),
                        NavLink(
                          text: "Coaching",
                          route: AppRouter.coaches,
                        ),
                        NavLink(
                          text: "Events",
                          route: AppRouter.events,
                        ),
                        NavLink(
                          text: "Blogs",
                          route: AppUrls.providerBlogsUrl,
                        ),
                        Padding(
                            padding: EdgeInsets.only(
                                left: Constants.semanticsMarginExSmall),
                            child: LiveTvButton()),
                      ],
                    )
                  : Container()),
          Expanded(
              flex: 6,
              child: renderNav
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                         SearchButton(isSearchPage:isSearchPage),
                        const SizedBox(
                          width: Constants.semanticsMarginExSmall * 2,
                        ),
                        const NotificationsButton(),
                        const SizedBox(
                          width: Constants.semanticsMarginExSmall * 2,
                        ),
                        isLoggedIn
                            ? const AccountsButton()
                            : const LoginButton(),
                      ],
                    )
                  : Container()),
        ],
      ),
    );
  }
}

class NavLink extends StatelessWidget {
  final String text;
  final String route;
  final Icon? icon;

  const NavLink(
      {super.key, required this.text, required this.route, this.icon});

  onPressed(BuildContext context) {
    if (route == "/livetv") {
      LiveTV().play(context);
      return;
    } else if (route == AppUrls.providerBlogsUrl) {
      // AppUrls.openUrl(route);
      RouteGenerator().navigate(context, "/blogs");
      return;
    }
    context.go(route);
  }

  @override
  Widget build(BuildContext context) {
    return icon == null
        ? TextButton(
            style: TextButton.styleFrom(foregroundColor: Colors.white),
            onPressed: () {
              onPressed(context);
            },
            child: Text(text),
          )
        : TextButton.icon(
            style: TextButton.styleFrom(foregroundColor: Colors.white),
            onPressed: () {
              onPressed(context);
            },
            icon: icon!,
            label: Text(text));
  }
}
