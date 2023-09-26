import 'package:url_launcher/url_launcher.dart';

import '../provider/provider_constants.dart';

class AppUrls {
  static const String baseUrlVSMS =
      "https://vsms.mobiotics.com/${ProviderConstants.environment}";

  static const String baseUrlVAuth =
      "https://vauth.mobiotics.com/${ProviderConstants.environment2}";
  // static const String baseUrlVAuth =
  //     "https://uz9jsl3qoc.execute-api.us-east-1.amazonaws.com/${ProviderConstants.environment}";
  static const String baseUrlVCMS =
      "https://vcms.mobiotics.com/${ProviderConstants.environment}";
  static const String baseUrlVCHARGE =
      "https://vcharge.mobiotics.com/${ProviderConstants.environment}";
  static const baseUrlVliveEvents =
      "https://vevents.mobiotics.com/${ProviderConstants.environment}";
  static const String appStorePath = "";
  static const String playStorePath = "";

  static openUrl(String path) async {
    if (!await launchUrl(Uri.parse(path), webOnlyWindowName: '_blank')) {
      throw Exception('Could not launch $path');
    }
  }

  static const String providerFacebookUrl = "https://www.facebook.com/EnrichTV";
  static const String providerInstagramUrl =
      "https://www.instagram.com/enrichtvglobal";
  static const String providerTwitterUrl = "https://twitter.com/enrichtv";
  static const String providerLinkedinUrl =
      "https://www.linkedin.com/company/enrichtv";

  static const String firebaseUrl =
      "https://enrichtv-b0346-default-rtdb.firebaseio.com/";
  static const String providerBlogsUrl = "https://blogs.enrichtv.com";
}
