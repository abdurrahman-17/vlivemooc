import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';
import 'package:vlivemooc/core/device/device_registration.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:vlivemooc/core/network/network_handler.dart';
import 'package:vlivemooc/core/provider/bottom_nav_provider.dart';
import 'package:vlivemooc/core/provider/firebase_provider.dart';
import 'package:vlivemooc/core/provider/search_provider.dart';
import 'package:vlivemooc/core/social_login/facebook_login.dart';
import 'package:vlivemooc/core/storage/device_storage.dart';
import 'package:vlivemooc/ui/main_app.dart';

// import 'core/fireabse/firebase_options.dart';
import 'core/fireabse/firebase_options.dart';
import 'core/helpers/channel_helper.dart';
import 'core/provider/user_provider.dart';

// import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  usePathUrlStrategy();
  DeviceStorage.initialize();
  FacebookLogin.initialize();
  NetworkHandler.initialize();

  //Initialize the firebase app.
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  DeviceRegistration().registerDevice().then((value) async {
    try {
      await NetworkHandler.getCountry();
      //do not remove the await
      await NetworkHandler.getSubscriber();
      FlutterNativeSplash.remove();
    } catch (userWasNotLoggedIn) {
      //do nothing
      FlutterNativeSplash.remove();
    }
    // AvailabilityService().initializeAvailability();
    // NetworkHandler.getPurchaseList();
  });
  if (WidgetsBinding
          .instance.platformDispatcher.views.first.physicalSize.width >
      450) {
    runApp(const ProviderApp());
  } else {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
        .then((value) => runApp(const ProviderApp()));
  }
}

class ProviderApp extends StatelessWidget {
  const ProviderApp({super.key});
  @override
  Widget build(BuildContext context) {
    //THis is for android
    setPlayerReleaseHandler(context);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserProvider>(create: (_) => UserProvider()),
        ChangeNotifierProvider<FirebaseProvider>(create: (_) => FirebaseProvider()),
        ChangeNotifierProvider<SearchProvider>(create: (_) => SearchProvider()),
        ChangeNotifierProvider<BottomNavProvider>(
            create: (_) => BottomNavProvider()),
      ],
      child: const MainApp(),
    );
  }
}
