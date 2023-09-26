import 'package:flutter/material.dart';
import 'package:vlivemooc/core/helpers/app_screen_dimen.dart';

class OrderSummary extends StatelessWidget {
  final bool isMobile;
   const OrderSummary({super.key, required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: isMobile ? const EdgeInsets.symmetric(horizontal: 16, vertical: 24) : null,
      decoration: isMobile ? ShapeDecoration(
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
            'Order Summary',
            style: TextStyle(
              color: Color(0xFF322440),
              fontSize: 20,
              fontFamily: 'DM Sans',
              fontWeight: FontWeight.w500,
            ),
          ),
          sizedBoxHeight24(context),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: ShapeDecoration(
              color: const Color(0xFFF6F2F5),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            child: Row(
              children: [
                Container(
                  width: 115.18,
                  height: 65,
                  decoration: ShapeDecoration(
                    color: Colors.grey,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                  ),
                ),
                sizedBoxWidth12(context),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Lorem ipsum dolor sit ',
                        maxLines: 1,
                        style: TextStyle(
                          color: Color(0xFF322440),
                          fontSize: 14,
                          fontFamily: 'DM Sans',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      sizedBoxHeight2(context),
                      const Text(
                        'By Ron Malhotra',
                        style: TextStyle(
                          color: Color(0xFF322440),
                          fontSize: 12,
                          fontFamily: 'DM Sans',
                          fontWeight: FontWeight.w400,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          sizedBoxHeight24(context),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 11),
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                side: const BorderSide(width: 0.50, color: Color(0xFFD9D9D9)),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            child: Row(
              children: [
                const Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Discount code",
                      border: InputBorder.none,
                    ),
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: TextButton(onPressed: (){}, child: const Text(
                      'APPLY',
                      style: TextStyle(
                        color: Color(0xFF490A53),
                        fontSize: 16,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                      ),
                    )),
                  ),
                )
              ],
            ),
          ),
          sizedBoxHeight20(context),
          Column(
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Subtotal',
                    style: TextStyle(
                      color: Color(0xFF545454),
                      fontSize: 14,
                      fontFamily: 'DM Sans',
                      fontWeight: FontWeight.w400,
                      height: 1.50,
                      letterSpacing: -0.20,
                    ),
                  ),
                  Text(
                    '₹100.00',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: Color(0xFF333333),
                      fontSize: 14,
                      fontFamily: 'DM Sans',
                      fontWeight: FontWeight.w400,
                      height: 1.50,
                      letterSpacing: -0.20,
                    ),
                  )
                ],
              ),
              sizedBoxHeight12(context),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Discount',
                    style: TextStyle(
                      color: Color(0xFF545454),
                      fontSize: 14,
                      fontFamily: 'DM Sans',
                      fontWeight: FontWeight.w400,
                      height: 1.50,
                      letterSpacing: -0.20,
                    ),
                  ),
                  Text(
                    '-',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: Color(0xFF333333),
                      fontSize: 14,
                      fontFamily: 'DM Sans',
                      fontWeight: FontWeight.w400,
                      height: 1.50,
                      letterSpacing: -0.20,
                    ),
                  )
                ],
              ),
              sizedBoxHeight17(context),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total',
                    style: TextStyle(
                      color: Color(0xFF333333),
                      fontSize: 16,
                      fontFamily: 'DM Sans',
                      fontWeight: FontWeight.w400,
                      height: 1.50,
                      letterSpacing: -0.20,
                    ),
                  ),
                  Text(
                    '₹95.00',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: Color(0xFF333333),
                      fontSize: 24,
                      fontFamily: 'DM Sans',
                      fontWeight: FontWeight.w400,
                      height: 1.50,
                      letterSpacing: -0.20,
                    ),
                  )
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
