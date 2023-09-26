import 'package:flutter/material.dart';
import 'package:vlivemooc/core/helpers/app_screen_dimen.dart';
import 'package:vlivemooc/ui/constants/colors.dart';

class PaymentGateway extends StatefulWidget {
  bool isMobile;
  PaymentGateway({super.key, required this.isMobile});

  @override
  State<PaymentGateway> createState() => _PaymentGatewayState();
}

class _PaymentGatewayState extends State<PaymentGateway> {

  int selectedRadio = -1;

  void _onRadioChanged(int value) {
    setState(() {
      if (selectedRadio == value) {
        // Clicking on already selected radio unchecks it
        selectedRadio = -1;
      } else {
        selectedRadio = value;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: widget.isMobile ? const EdgeInsets.symmetric(horizontal: 16, vertical: 24) : null,
      decoration: widget.isMobile ? ShapeDecoration(
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
      ) : null,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Select payment Gateway',
            style: TextStyle(
              color: Color(0xFF322440),
              fontSize: 20,
              fontFamily: 'DM Sans',
              fontWeight: FontWeight.w500,
            ),
          ),
          sizedBoxHeight24(context),
          Container(
            padding: const EdgeInsets.only(
              top: 16,
              left: 16,
              right: 24,
              bottom: 16,
            ),
            decoration: ShapeDecoration(
              color: const Color(0x197F6389),
              shape: RoundedRectangleBorder(
                side: const BorderSide(width: 0.50, color: Color(0xFF7F6389)),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Row(
              children: [
                Radio(
                  value: 1,
                  activeColor: AppColors.primaryColor,
                  groupValue: selectedRadio,
                  onChanged: (value) {
                    _onRadioChanged(value!);
                  },
                ),
                sizedBoxWidth15(context),
                const Text(
                  'Stripe',
                  style: TextStyle(
                    color: Color(0xFF322440),
                    fontSize: 18,
                    fontFamily: 'DM Sans',
                    fontWeight: FontWeight.w700,
                    height: 1.11,
                  ),
                ),
                const Spacer(),
                Image.asset("assets/images/stripe.png",width: 44,)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
