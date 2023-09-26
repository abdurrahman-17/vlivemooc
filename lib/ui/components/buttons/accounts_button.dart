import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:vlivemooc/core/models/subscriber/subscriber_model.dart';
import 'package:vlivemooc/core/network/network_handler.dart';
import 'package:vlivemooc/core/provider/bottom_nav_provider.dart';
import 'package:vlivemooc/core/provider/user_provider.dart';
import 'package:vlivemooc/ui/components/dialogs/pogress_dialog.dart';
import 'package:vlivemooc/ui/constants/constants.dart';
import 'package:vlivemooc/ui/routes/routes.dart';

// This is the type used by the popup menu below.
enum AccountMenuItem { settings, logout }

class AccountsButton extends StatelessWidget {
  final bool isMobile;
  const AccountsButton({super.key, this.isMobile = false});

  @override
  Widget build(BuildContext context) {
    SubscriberModel? model = Provider.of<UserProvider>(context).subscriberModel;
    String profileimage = "";
    if (model != null && model.picture != null) {
      profileimage = model.picture!;
    }
    return PopupMenuButton<AccountMenuItem>(
      offset: const Offset(0, 50),
      shape: const TooltipShape(),
      onSelected: (AccountMenuItem item) {
        if (item == AccountMenuItem.logout) {
          NetworkHandler.appContext = context;
          // ScaffoldMessenger.of(context).showSnackBar(
          //     const SnackBar(content: Text("Logging out, please wait...")));
          showProgressDialog(context);
          NetworkHandler().logout().then((value) {
            context.pop();
            context.go(AppRouter.signup);
          });
        } else if (item == AccountMenuItem.settings) {
          if (isMobile) {
            Provider.of<BottomNavProvider>(context, listen: false)
                .changePage(4);
          } else {
            context.go(AppRouter.account);
          }
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<AccountMenuItem>>[
        const PopupMenuItem<AccountMenuItem>(
          value: AccountMenuItem.settings,
          child: Row(children: [
            Icon(
              Icons.account_circle,
              color: Colors.black,
            ),
            SizedBox(
              width: Constants.semanticMarginDefault,
            ),
            Text('My Profile')
          ]),
        ),
        const PopupMenuItem<AccountMenuItem>(
          value: AccountMenuItem.logout,
          child: Row(children: [
            Icon(
              Icons.logout,
              color: Colors.black,
            ),
            SizedBox(
              width: Constants.semanticMarginDefault,
            ),
            Text('Logout')
          ]),
        ),
      ],
      child: profileimage.isEmpty
          ? const Icon(
              Icons.account_circle,
              size: 40,
            )
          : CircleAvatar(
              backgroundImage: NetworkImage(profileimage),
              backgroundColor: Colors.transparent,
            ),
    );
  }
}

// I'm using [RoundedRectangleBorder] as my reference...
class TooltipShape extends ShapeBorder {
  const TooltipShape();

  final BorderSide _side = BorderSide.none;
  final BorderRadiusGeometry _borderRadius = BorderRadius.zero;

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.all(_side.width);

  @override
  Path getInnerPath(
    Rect rect, {
    TextDirection? textDirection,
  }) {
    final Path path = Path();

    path.addRRect(
      _borderRadius.resolve(textDirection).toRRect(rect).deflate(_side.width),
    );

    return path;
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    final Path path = Path();
    final RRect rrect = _borderRadius.resolve(textDirection).toRRect(rect);

    path.moveTo(0, 10);
    path.quadraticBezierTo(0, 0, 10, 0);
    path.lineTo(rrect.width - 30, 0);
    path.lineTo(rrect.width - 20, -10);
    path.lineTo(rrect.width - 10, 0);
    path.quadraticBezierTo(rrect.width, 0, rrect.width, 10);
    path.lineTo(rrect.width, rrect.height - 10);
    path.quadraticBezierTo(
        rrect.width, rrect.height, rrect.width - 10, rrect.height);
    path.lineTo(10, rrect.height);
    path.quadraticBezierTo(0, rrect.height, 0, rrect.height - 10);

    return path;
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {}

  @override
  ShapeBorder scale(double t) => RoundedRectangleBorder(
        side: _side.scale(t),
        borderRadius: _borderRadius * t,
      );
}
