import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vlivemooc/core/network/urls.dart';
import 'package:vlivemooc/ui/constants/colors.dart';
import 'package:vlivemooc/ui/constants/constants.dart';
import 'package:vlivemooc/ui/routes/routes.dart';

class WebFooter extends StatelessWidget {
  const WebFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Constants.webFooterHeight,
      color: AppColors.primaryColor,
      padding: EdgeInsets.all(Constants.insetPadding),
      child: const Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  StoreImage(
                      path: "assets/images/googleplayimage.png",
                      storePath: AppUrls.playStorePath),
                  SizedBox(
                    width: Constants.semanticsMarginExSmall,
                  ),
                  StoreImage(
                      path: "assets/images/appstoreimage.png",
                      storePath: AppUrls.appStorePath),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Text(
                        "Connect with us",
                        style: TextStyle(
                            fontSize: Constants.fontSizeMedium,
                            color: Colors.white),
                      ),
                      SizedBox(
                        width: Constants.semanticMarginDefault,
                      ),
                      SocialIcon(
                          path: "assets/images/facebookimage.png",
                          redirectPath: AppUrls.providerFacebookUrl),
                      SizedBox(
                        width: Constants.semanticsMarginExSmall,
                      ),
                      SocialIcon(
                          path: "assets/images/instagramimage.png",
                          redirectPath: AppUrls.providerInstagramUrl),
                      SizedBox(
                        width: Constants.semanticsMarginExSmall,
                      ),
                      SocialIcon(
                          path: "assets/images/twitterimage.png",
                          redirectPath: AppUrls.providerTwitterUrl),
                      SizedBox(
                        width: Constants.semanticsMarginExSmall,
                      ),
                      SocialIcon(
                          path: "assets/images/linkedinimage.png",
                          redirectPath: AppUrls.providerLinkedinUrl),
                    ],
                  ),
                  SizedBox(
                    height: Constants.semanticsMarginExSmall,
                  ),
                ],
              )
            ],
          ),
          Row(
            children: [
              FooterLink(text: "About Us", url: "About Us"),
              FooterLink(text: "Contact Us", url: "Contact Us"),
              FooterLink(
                  text: "Terms of Use",
                  url: "https://enrichtv.com/terms-of-use"),
              FooterLink(
                  text: "Privacy Policy",
                  url: "https://enrichtv.com/privacy-policy"),
              FooterLink(
                text: "Disclaimer",
                url: "https://enrichtv.com/disclamier",
                renderSpacer: false,
              ),
            ],
          ),
          SizedBox(
            height: Constants.semanticsMarginExSmall,
          ),
          SizedBox(
            width: double.infinity,
            child: Center(
              child: Text(
                "Copyright © 2023 Enrich TV Pvt. Ltd. All rights reserved",
                style: TextStyle(
                    color: Colors.white, fontSize: Constants.fontSizeSmall),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FooterLink extends StatelessWidget {
  final bool renderSpacer;
  final String text;
  final String url;
  const FooterLink(
      {super.key,
      this.renderSpacer = true,
      required this.text,
      required this.url});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TextButton(
            style: TextButton.styleFrom(foregroundColor: Colors.white),
            onPressed: () {
              if (url.contains("http")) {
                AppUrls.openUrl(url);
              } else if (url.contains("About Us")) {
                context.go(AppRouter.aboutus);
              } else if (url.contains("Contact Us")) {
                context.go(AppRouter.contactus);
              } else {
                context.go(url);
              }
            },
            child: Text(text)),
        renderSpacer
            ? const SizedBox(height: 20, child: LinkSpacer())
            : Container()
      ],
    );
  }
}

class LinkSpacer extends StatelessWidget {
  const LinkSpacer({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        SizedBox(
          width: Constants.semanticsMarginExSmall,
        ),
        VerticalDivider(
          width: 2,
          color: Colors.white,
        ),
        SizedBox(
          width: Constants.semanticsMarginExSmall,
        ),
      ],
    );
  }
}

class SocialIcon extends StatelessWidget {
  final String path;
  final String redirectPath;
  const SocialIcon({super.key, required this.path, required this.redirectPath});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        AppUrls.openUrl(redirectPath);
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: Container(
          padding: const EdgeInsets.all(5),
          color: const Color(0xff7f6389),
          child: Image.asset(
            path,
            height: 30,
            width: 30,
          ),
        ),
      ),
    );
  }
}

class StoreImage extends StatelessWidget {
  final String path;
  final String storePath;
  const StoreImage({super.key, required this.path, required this.storePath});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        AppUrls.openUrl(storePath);
      },
      child: Image.asset(
        path,
        height: 40,
        width: 140,
      ),
    );
  }
}
