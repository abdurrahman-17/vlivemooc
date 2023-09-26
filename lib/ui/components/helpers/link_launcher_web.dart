import 'package:url_launcher/url_launcher.dart';

class LinkLauncherWeb {
  launchUrlWeb(String url, {bool newTab = false}) async {
    if (!await launchUrl(Uri.parse(url),
        webOnlyWindowName: newTab ? '_blank' : '_self')) {
      throw Exception('Could not launch $url');
    }
  }
}
