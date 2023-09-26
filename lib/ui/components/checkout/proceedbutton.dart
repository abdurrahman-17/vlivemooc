import 'package:flutter/material.dart';
import 'package:vlivemooc/core/helpers/app_screen_dimen.dart';
import 'package:vlivemooc/ui/components/buttons/circular_loading_button.dart';
import 'package:vlivemooc/ui/constants/colors.dart';
import 'package:vlivemooc/ui/constants/constants.dart';

class ProceedButton extends StatelessWidget {
  bool isMobile;
  ProceedButton({super.key, required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CircularLoadingElevatedButton(
            buttonText: "Proceed",
            isLoading: false,
            onTap: () {},
          ),
        ),
        if(!isMobile) sizedBoxWidth15(context),
        if(!isMobile) Expanded(
          child: SizedBox(
            height: Constants.buttonHeight,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: Colors.transparent,
                side: BorderSide(
                  width: 2, // the thickness
                  color: AppColors
                      .primaryColor, // the color of the border
                ),
              ),
              child: Text(
                "Cancel",
                style: TextStyle(
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
