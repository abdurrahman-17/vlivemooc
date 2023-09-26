import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import '../../constants/constants.dart';

class CircularLoadingElevatedButton extends StatelessWidget {
  final double? width;
  final double? height;
  final String buttonText;
  final bool disabled;
  final bool isLoading;
  final Function()? onTap;

  const CircularLoadingElevatedButton(
      {super.key,
      required this.buttonText,
      required this.isLoading,
      required this.onTap,
      this.width = double.infinity,
      this.disabled = false,
      this.height = Constants.buttonHeight});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: isLoading || disabled ? null : onTap,
        // style: ButtonStyle(elevation: MaterialStateProperty(12.0 )),
        style: ElevatedButton.styleFrom(
            elevation: 12.0,
            backgroundColor: AppColors.primaryColor,
            textStyle: const TextStyle(color: Colors.white)),
        child: isLoading
            ? Transform.scale(
                scale: 0.5,
                child: CircularProgressIndicator(
                  color: AppColors.darkGrey,
                ),
              )
            : Text(buttonText),
      ),
    );
  }
}
