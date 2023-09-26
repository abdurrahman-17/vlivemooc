import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vlivemooc/ui/routes/routes.dart';

class AppAlerts {
  static showSessionTimedOut(BuildContext context) {
    Widget cancelButton = TextButton(
      child: const Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget loginButton = TextButton(
      child: const Text("Login"),
      onPressed: () {
        context.go(AppRouter.signup);
      },
    );
    AlertDialog alert = AlertDialog(
      title: const Text("Session expired!"),
      content: const Text("Your session expired and you were logged out"),
      actions: [cancelButton, loginButton],
    );

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        });
  }
}
