import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:vlivemooc/core/network/network_handler.dart';
import 'package:vlivemooc/core/provider/provider_constants.dart';
import 'package:vlivemooc/core/provider/user_provider.dart';
import 'package:vlivemooc/ui/constants/colors.dart';
import 'package:vlivemooc/ui/constants/constants.dart';
import 'package:vlivemooc/ui/routes/Routes.dart';


class MainApp extends StatefulWidget {
  const MainApp({super.key});
  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  void initState() {
    super.initState();
  }

  bool hasInitialized = false;

  initializeApp() {
    if (hasInitialized) {
      return;
    }
    initializeLogin();
  }

  initializeLogin() async {
    bool isLoggedIn = await NetworkHandler.getLoginState();
    ProviderConstants.isLoggedIn = isLoggedIn;
    //added timer to wait for the UI to build first before updting the state
    Timer(const Duration(milliseconds: 300), () {
      Provider.of<UserProvider>(context, listen: false)
          .setIsLoggedIn(isLoggedIn);
      Provider.of<UserProvider>(context, listen: false).updateSubscriber();
      setState(() {
        hasInitialized = true;
      });
    });
  }

  AppRouter appRouter = AppRouter();
  @override
  Widget build(BuildContext context) {
    NetworkHandler.appContext = context;
    Constants.initialize(context);

    initializeApp();

    return Shortcuts(
      shortcuts: <LogicalKeySet, Intent>{
        LogicalKeySet(LogicalKeyboardKey.select): const ActivateIntent(),
      },
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: appRouter.getRoutes(),
        theme: ThemeData(
          primaryColor: AppColors.primaryColor,
          fontFamily: 'Poppins',
        ),
      ),
    );
  }
}
