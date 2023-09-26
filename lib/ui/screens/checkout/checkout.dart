import 'package:flutter/material.dart';
import 'package:vlivemooc/core/helpers/app_screen_dimen.dart';
import 'package:vlivemooc/ui/components/appbar/mobile_app_bar.dart';
import 'package:vlivemooc/ui/components/appbar/top_bar.dart';
import 'package:vlivemooc/ui/components/checkout/ordersummary.dart';
import 'package:vlivemooc/ui/components/checkout/paymentgateway.dart';
import 'package:vlivemooc/ui/components/checkout/proceedbutton.dart';
import 'package:vlivemooc/ui/components/footer/web_footer.dart';
import 'package:vlivemooc/ui/constants/colors.dart';
import 'package:vlivemooc/ui/constants/constants.dart';

class Checkout extends StatefulWidget {
  bool isMobile;
  Checkout({super.key, required this.isMobile});

  @override
  State<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(Constants.appBarHeight),
        child: !widget.isMobile ? TopBar(
          logoPath: "assets/images/logo_white.png",
          backgroundColor: AppColors.primaryColor,
          renderNav: true,
        ):  const MobileAppBar(
          title: "Coaches",
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: widget.isMobile ? const EdgeInsets.all(16) :const EdgeInsets.symmetric(horizontal: 72, vertical: 52),
              padding: widget.isMobile ? null : const EdgeInsets.symmetric(horizontal: 16, vertical: 40),
              width: double.infinity,
              decoration: widget.isMobile ? null : ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  side: const BorderSide(width: 0.50, color: Color(0xFFF6F2F5)),
                  borderRadius: BorderRadius.circular(8),
                ),
                shadows: const [
                  BoxShadow(
                    color: Color(0x28000000),
                    blurRadius: 3,
                    offset: Offset(0, 1),
                    spreadRadius: 0,
                  )
                ],
              ),
              child:  Column(
                children: [
                  SizedBox(
                    width: 420,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        OrderSummary(isMobile: widget.isMobile),
                        if(!widget.isMobile)sizedBoxHeight25(context),
                        if(!widget.isMobile)const Divider(
                          color: Color(0xFFCFCFCF),
                          height: 1,
                        ),
                        sizedBoxHeight35(context),
                        PaymentGateway(isMobile: widget.isMobile),
                        sizedBoxHeight45(context),
                        ProceedButton(isMobile: widget.isMobile),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            if(!widget.isMobile)const WebFooter()
          ],
        ),
      ),
    );
  }
}
