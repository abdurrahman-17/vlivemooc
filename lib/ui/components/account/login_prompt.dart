import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import '../../constants/constants.dart';
import '../buttons/login_button.dart';

class LoginPrompt extends StatelessWidget {
  final String message;
  const LoginPrompt({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            message,
            style: const TextStyle(fontSize: Constants.fontSizeMedium),
          ),
          const SizedBox(
            height: Constants.semanticsMarginExSmall,
          ),
          LoginButton(
            foregroundColor: AppColors.primaryColor,
            borderColor: AppColors.primaryColor,
          )
        ],
      ),
    );
  }
}
