import "package:universal_html/html.dart" as html;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:vlivemooc/ui/animations/loading_animation.dart';
import 'package:vlivemooc/ui/components/appbar/top_bar.dart';
import 'package:vlivemooc/ui/constants/colors.dart';

class CrossPlatformWebView extends StatefulWidget {
  final String url;
  final bool renderNavs;
  final Function(dynamic) onResponse;

  const CrossPlatformWebView(
      {super.key,
      required this.url,
      required this.onResponse,
      this.renderNavs = false});

  @override
  State<CrossPlatformWebView> createState() => _CrossPlatformWebViewState();
}

class _CrossPlatformWebViewState extends State<CrossPlatformWebView> {
  late InAppWebViewController _controller;
  bool loading = true;
  bool dataReceived = false;

  @override
  void initState() {
    super.initState();
    if (kIsWeb) {
      html.window.addEventListener("message", eventListener);
    }
  }

  eventListener(event) {
    var data = (event as html.MessageEvent).data ?? '-';
    widget.onResponse(data);
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
        appBar: widget.renderNavs
            ? TopBar(
                logoPath: "assets/images/logo_white.png",
                backgroundColor: AppColors.primaryColor,
                renderNav: true,
              )
            : AppBar(
                backgroundColor: AppColors.primaryColor,
              ),
        body: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              child: InAppWebView(
                initialUrlRequest: URLRequest(url: WebUri(widget.url)),
                onWebViewCreated: (InAppWebViewController controller) {
                  _controller = controller;
                  _controller.addJavaScriptHandler(
                      handlerName: "onPaymentMade",
                      callback: (args) {
                        Map<String, dynamic> response = args[0];
                        Navigator.pop(context);
                        widget.onResponse(response);
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
              ),
            ),
            Positioned(
                child: SizedBox(
                    width: 100,
                    height: 100,
                    child: loading ? const LoadingAnimation() : null)),
          ],
        ),
      ),
    );
  }
}
