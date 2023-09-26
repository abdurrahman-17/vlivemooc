import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vlivemooc/core/helpers/app_screen_dimen.dart';
import 'package:vlivemooc/core/player/play_button_state.dart';
import 'package:vlivemooc/ui/animations/loading_animation.dart';
import 'package:vlivemooc/ui/components/auth/signup_component.dart';
import 'package:vlivemooc/ui/components/cards/my_plans.dart';
import 'package:vlivemooc/ui/constants/constants.dart';
import '../../../core/models/content/content_model/datum.dart';

class PlayLeadPopup {
  final BuildContext context;
  final Datum content;
  PlayLeadPopup({required this.context, required this.content});

  showPopup() {
    showModalBottomSheet(
        backgroundColor: Colors.white,
        isScrollControlled: true,
        isDismissible: false,
        enableDrag: false,
        context: context,
        builder: (context) {
          return PayComponent(
            content: content,
            onClose: () {
              hidePopup();
            },
          );
        });
  }

  hidePopup() {
    context.pop();
  }
}

class PayComponent extends StatefulWidget {
  final Datum content;
  final Function onClose;
  const PayComponent({super.key, required this.content, required this.onClose});

  @override
  State<PayComponent> createState() => _PayComponentState();
}

class _PayComponentState extends State<PayComponent> {
  String playState = "";
  @override
  void initState() {
    super.initState();
    getPlayState();
  }

  getPlayState() async {
    PlayButtonState playButtonState = PlayButtonState();
    String state =
        await playButtonState.getState(widget.content, clearleadCheck: false);
    setState(() {
      playState = state;
    });
  }

  Widget _buildBody() {
    if (playState == PlayButtonState.subscribe) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                IconButton(
                    onPressed: () {
                      context.pop();
                    },
                    icon: const Icon(Icons.close))
              ],
            ),
          ),
          const SizedBox(
            height: Constants.semanticMarginDefault,
          ),
          const Text(
            "Your free watch time is over, subscribe now to continue watching",
            style: TextStyle(
                fontSize: Constants.fontSizeLarge, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: Constants.semanticMarginDefault,
          ),
          MyPlans(isMobile: isMobile(context)),
        ],
      );
    } else if (playState == PlayButtonState.buy) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                IconButton(
                    onPressed: () {
                      context.pop();
                    },
                    icon: const Icon(Icons.close))
              ],
            ),
          ),
          const Text(
            "Your free watch time is over, buy now to continue watching",
            style: TextStyle(
                fontSize: Constants.fontSizeLarge, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: Constants.semanticMarginDefault,
          ),
          MyPlans(isMobile: isMobile(context)),
        ],
      );
    } else if (playState == PlayButtonState.login) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                IconButton(
                    onPressed: () {
                      context.pop();
                    },
                    icon: const Icon(Icons.close))
              ],
            ),
          ),
          const SizedBox(
            width: Constants.webAuthCardWidth,
            child: Text(
              "Your free watch time is over, login and buy the content to continue watching.",
              style: TextStyle(
                  fontSize: Constants.fontSizeLarge,
                  fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: Constants.semanticMarginDefault,
          ),
          const SizedBox(
              width: Constants.webAuthCardWidth, child: SignupComponent())
        ],
      );
    }

    return const Center(
      child: LoadingAnimation(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: _buildBody(),
    );
  }
}
