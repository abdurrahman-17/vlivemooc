import 'package:flutter/material.dart';
import 'package:vlivemooc/core/models/content/content_model/datum.dart';
import 'package:vlivemooc/core/models/coaches/coach_model/datum.dart'
as coaches;
import 'package:vlivemooc/ui/constants/colors.dart';
import 'package:vlivemooc/ui/constants/constants.dart';

class ShareButton extends StatefulWidget {
  final Datum content;
  final VoidCallback onTap;
  final bool isCarousal;
  const ShareButton({super.key, required this.content, required this.onTap, this.isCarousal = false});

  @override
  State<ShareButton> createState() => _ShareButtonState();
}

class _ShareButtonState extends State<ShareButton> {
  bool isActive = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onHover: (value) {
        setState(() {
          isActive = value;
        });
      },
      onTap: widget.onTap,
      child:
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            isActive ? Icons.share : Icons.share_outlined,
            color: widget.isCarousal?Colors.white : AppColors.primaryColor,
          ),
          if (MediaQuery.of(context).size.width >= 600)
            if(!widget.isCarousal)const SizedBox(
              width: Constants.semanticsMarginExSmall,
            ),
          if (MediaQuery.of(context).size.width >= 600)
            if(!widget.isCarousal)Text(
              "Share",
              style: TextStyle(color: AppColors.primaryColor),
            )
        ],
      ),
    );
  }
}

class ShareButtonCoach extends StatefulWidget {
  final coaches.Datum content;
  final VoidCallback onTap;
  const ShareButtonCoach(
      {super.key, required this.content, required this.onTap});

  @override
  State<ShareButtonCoach> createState() => _ShareButtonCoachState();
}

class _ShareButtonCoachState extends State<ShareButtonCoach> {
  bool isActive = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onHover: (value) {
        setState(() {
          isActive = value;
        });
      },
      onTap: widget.onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            isActive ? Icons.share : Icons.share_outlined,
            color: AppColors.white,
          ),
          if (MediaQuery.of(context).size.width >= 600)
            const SizedBox(
              width: Constants.semanticsMarginExSmall,
            ),
          if (MediaQuery.of(context).size.width >= 600)
            Text(
              "Share",
              style: TextStyle(color: AppColors.primaryColor),
            )
        ],
      ),
    );
  }
}
