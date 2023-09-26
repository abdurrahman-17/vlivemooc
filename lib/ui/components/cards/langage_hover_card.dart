import 'package:flutter/material.dart';
import 'package:vlivemooc/core/helpers/text_styles.dart';
import 'package:vlivemooc/ui/constants/colors.dart';
import 'package:vlivemooc/ui/constants/constants.dart';

class LanguageHoverCard extends StatelessWidget {
  final String text;

  const LanguageHoverCard({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Constants.cardBorderRadius),
          //set border radius more than 50% of height and width to make circle
        ),
      child: Container(
        width: Constants.languageHoverLength,
          color: AppColors.primaryColor,
          padding: const EdgeInsets.all(Constants.semanticsMarginExSmall),
          child: Expanded(
            child: Text(
              text,
              style: poppinsMedium(10, AppColors.white),
            ),
          )),
    );
  }
}
