import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../core/provider/user_provider.dart';
import '../../routes/Routes.dart';

class LoginButton extends StatelessWidget {
  final Color foregroundColor;
  final Color borderColor;
  const LoginButton(
      {super.key,
      this.foregroundColor = Colors.white,
      this.borderColor = Colors.white});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
          foregroundColor: foregroundColor,
          side: BorderSide(color: borderColor)),
      onPressed: () {
        final state = GoRouterState.of(context);
        Provider.of<UserProvider>(context, listen: false)
            .setRedirectLocation(state.location);
        context.push(AppRouter.signup);
      },
      child: const Text("Login"),
    );
  }
}
