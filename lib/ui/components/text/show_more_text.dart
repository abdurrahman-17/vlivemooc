import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:vlivemooc/core/helpers/text_styles.dart';

import '../../constants/colors.dart';
import '../../constants/constants.dart';

class ShowMoreText extends StatefulWidget {
  final String? text;
  final int maxLength;
  const ShowMoreText({super.key, required this.text, this.maxLength = 120});

  @override
  State<ShowMoreText> createState() => _ShowMoreTextState();
}

class _ShowMoreTextState extends State<ShowMoreText> {
  bool _showMore = false;

  @override
  Widget build(BuildContext context) {
    if (widget.text == null) {
      return Container();
    }
    final text = _showMore
        ? widget.text
        : (widget.text!.length <= widget.maxLength
            ? widget.text
            : widget.text!.substring(0, widget.maxLength));
    final isLongText = widget.text!.length > widget.maxLength;

    return RichText(
      text: TextSpan(
        text: text,
        style:
        poppinsMediumWithHeight(Constants.fontSizeDefault,  Colors.grey,spacingHeight: 1.5),
        children: <TextSpan>[
          if (isLongText)
            TextSpan(
              text: _showMore ? ' Show less' : ' Show more',
              style: poppinsMedium(Constants.fontSizeDefault,  AppColors.primaryColor)  ,
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  setState(() {
                    _showMore = !_showMore;
                  });
                },
            )
        ],
      ),
      textAlign: TextAlign.justify,
    );
  }
}
