import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import '../../constants/constants.dart';

class TagCard extends StatelessWidget {
  final String tag;
  const TagCard({super.key, required this.tag});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: Constants.semanticsMarginExSmall),
      child: Card(
        margin: EdgeInsets.zero,
        color: AppColors.secondaryColor,
        child: Padding(
          padding: const EdgeInsets.all(Constants.semanticsMarginExSmall),
          child: Text(
            tag,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
                fontSize: Constants.fontSizeSmall, color: Colors.black),
          ),
        ),
      ),
    );
  }
}
