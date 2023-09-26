import 'package:flutter/material.dart';

class Constants {
  static const String videoRemovedFromWatchList = "Video removed from watchlist";
  static const String videoAddedTOWatchList = "Video added to watchlist";

  static const String courseRemovedFromWatchList = "Course removed from watchlist";
  static const String courseAddedTOWatchList = "Course added to watchlist";
  static const String facebookAppId = "249447180931431";
  static const String myAccount = "My Account";
  static const String watchList = "Watchlist";

  static const num otpLength =6;

  static const double webFooterHeight=140;

  static const double oneThousand=1000;


  static initialize(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth < 600) {
      carouselViewportFraction = 0.8;
      insetPadding = 8;
      scrollSensitivity = 150;
    } else {
      insetPadding = 20;
      scrollSensitivity = 300;
      carouselViewportFraction = 0.5;
    }
  }

  static double carouselViewportFraction = 0.5;
  static double insetPadding = 20;
  static double zeroPadding = 0;
  static double scrollSensitivity = 150;
  static double languageHoverLength = 100;

  static const double webAuthCardWidth = 350;
  static const double appBarElevation = 5;
  static const double cardElevation = 4;
  static const double cardPadding = 8;

  static const double logoWidth = 100;
  static const double defaultPagePaddingWeb = 20;
  static const double defaultPagePadding = 20;
  static const double defaultPagePaddingModile = 8;

  static const double appBarHeight = 60;
  static const double mobileAppBarHeight = 56;

  static const double buttonHeight = 50;
  static const double buttonHeightSmall = 40;
  static const double cardBorderRadius = 8;
  static const double carouselItemPadding = 15;
  static const double categoryCardDimens = 110;
  static const double categoryCardMobileDimens = 80;
  static const double categoryCardDimensHight = 160;
  static const double categoryCardMobileDimensHight = 120;

  static const double textFieldCornerRadius = 4;
  static const double semanticsMarginExSmall = 4;
  static const double semanticMarginDefault = 20;
  static const double semanticMarginTen = 10;
  static const double regularMargin = 40;
  static const double marginThirty = 30;
  static const double fontSizeSmall = 12;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Constants && runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;
  static const double fontSizeDefault = 14;

  static const double fontSizeExSmall = 9;

  static const double fontSizeLarge = 18;
  static const double fontSizeMedium = 16;

  static const int animationSnappy = 400;
  static const int animationSlower = 800;
  static RegExp emailReges = RegExp(
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");
  static const continueJourney="Continue Journey";

  static const continueWatching = "Continue Watching";
  static const playerSecurity = "PlayerSecurity";

  static const double maxContentCardWidthWeb = 280;
  static const double maxContentCardWidthWeb2 = 350;
  static const int getContentPageSize = 10;
}
