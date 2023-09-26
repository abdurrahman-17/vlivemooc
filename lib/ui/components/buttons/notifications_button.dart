import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vlivemooc/ui/routes/routes.dart';

class NotificationsButton extends StatelessWidget {
  const NotificationsButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          context.go(AppRouter.notifications);
        },
        icon: const Icon(
          color:Colors.white,
          Icons.notifications_none,
          size: 25,
        ));
  }
}
