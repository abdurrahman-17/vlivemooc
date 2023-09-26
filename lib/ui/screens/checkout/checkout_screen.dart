import 'package:flutter/material.dart';
import 'package:vlivemooc/ui/screens/checkout/checkout.dart';
import '../../responsive/responsive.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Responsive(
        mobileView: Checkout(isMobile: true), desktopView: Checkout(isMobile: false,));
  }
}
