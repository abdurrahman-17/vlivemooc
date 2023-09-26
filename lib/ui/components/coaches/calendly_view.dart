import "package:universal_html/html.dart" as html;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:vlivemooc/ui/constants/colors.dart';

import '../../../core/helpers/app_screen_dimen.dart';
import '../appbar/top_bar.dart';

class CalendlyView extends StatefulWidget {
  final String url;
  final Function(dynamic) onCalendlyResponse;

  const CalendlyView(
      {super.key, required this.url, required this.onCalendlyResponse});

  @override
  State<CalendlyView> createState() => _CalendlyViewState();
}

class _CalendlyViewState extends State<CalendlyView> {
  late InAppWebViewController _controller;
  bool loading = true;
  String baseUrl = "https://salam-tv-prod.web.app";
  late String calendlyUrl;
  bool dataReceived = false;

  @override
  void initState() {
    super.initState();
    calendlyUrl = "$baseUrl/?calendlyUrl=${widget.url}";
    if (kIsWeb) {
      html.window.addEventListener("message", eventListener);
    }
  }

  eventListener(event) {
    var data = (event as html.MessageEvent).data ?? '-';
    widget.onCalendlyResponse(data);
    setState(() {
      dataReceived = true;
    });
  }

  @override
  void dispose() {
    super.dispose();
    html.window.removeEventListener("message", eventListener);
  }

  @override
  Widget build(BuildContext context) {
    if (dataReceived) {
      Navigator.pop(context);
    }
    return SafeArea(
      top: true,
      bottom: true,
      left: true,
      right: true,
      child: Scaffold(
        appBar: isMobile(context)?AppBar(backgroundColor: AppColors.primaryColor,title: const Text("Book Session"),):TopBar(
          logoPath: "assets/images/logo_white.png",
          backgroundColor: AppColors.primaryColor,
          renderNav: true,
        ),
        body: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              child: InAppWebView(
                  initialUrlRequest: URLRequest(url: WebUri(calendlyUrl)),
                  onWebViewCreated: (InAppWebViewController controller) {
                    _controller = controller;
                    _controller.addJavaScriptHandler(
                        handlerName: "onEventCreated",
                        callback: (args) {
                          Map<String, dynamic> response = args[0];

                          widget.onCalendlyResponse(response);

                          Navigator.pop(context);
                          return {'event': 'Callback received'};
                        });
                  },
                  onLoadStart: (InAppWebViewController controller, Uri? uri) {},
                  onLoadStop:
                      (InAppWebViewController controller, Uri? uri) async {
                    setState(() {
                      loading = false;
                    });
                  },
                  onConsoleMessage: (controller, consoleMessage) {}),
            ),
            Positioned(
                child: SizedBox(
                    width: 30,
                    height: 30,
                    child: loading ? const CircularProgressIndicator() : null)),
          ],
        ),
      ),
    );
  }
}
