import 'package:flutter/material.dart';
import 'package:vlivemooc/ui/constants/constants.dart';

class IconText extends StatelessWidget {
  final Widget icon;
  final String text;
  final FontWeight fontWeight;
  final double fontSize;
  const IconText(
      {super.key,
      required this.icon,
      required this.text,
      this.fontSize = Constants.fontSizeSmall,
      this.fontWeight = FontWeight.normal});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        icon,
        const SizedBox(
          width: Constants.semanticsMarginExSmall,
        ),
        Text(
          text,
          style: TextStyle(fontSize: fontSize, fontWeight: fontWeight),
        )
      ],
    );
  }
}
