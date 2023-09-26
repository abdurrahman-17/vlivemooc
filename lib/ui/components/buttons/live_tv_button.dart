import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:vlivemooc/core/live/live_tv.dart';
import 'package:vlivemooc/core/provider/user_provider.dart';
import 'package:vlivemooc/ui/routes/routes.dart';

class LiveTvButton extends StatelessWidget {
  const LiveTvButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          final state = GoRouterState.of(context);
          if (state.location == AppRouter.blogs) {
            Provider.of<UserProvider>(context, listen: false)
                .updateLiveTvVisibility(true);
            context.go(AppRouter.home);
          } else {
            LiveTV().play(context);
          }
        },
        child: Image.asset(
          "assets/images/livetv_icon.gif",
          fit: BoxFit.fill,
          width: 65,
          height: 50,
        ));
  }
}
