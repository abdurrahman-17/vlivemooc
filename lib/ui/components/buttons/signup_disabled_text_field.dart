import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:vlivemooc/core/provider/user_provider.dart';
import 'package:vlivemooc/ui/constants/colors.dart';
import 'package:vlivemooc/ui/constants/constants.dart';
import 'package:vlivemooc/ui/routes/Routes.dart';

class SignupDisabledTextField extends StatelessWidget {
  const SignupDisabledTextField({super.key});

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    bool isEmail = userProvider.signupPageIsEmail;

    String value = isEmail
        ? userProvider.signupPageForm
        : (userProvider.signupCountryCode + userProvider.signupPageForm);

    return Container(
      height: Constants.buttonHeight,
      width: double.infinity,
      decoration: BoxDecoration(
          color: AppColors.primaryColor.withOpacity(0.1),
          borderRadius: const BorderRadius.all(
              Radius.circular(Constants.textFieldCornerRadius))),
      child: Row(
        children: [
          Expanded(
              child: Padding(
            padding:
                const EdgeInsets.only(left: Constants.semanticsMarginExSmall),
            child: Text(
              value,
              overflow: TextOverflow.ellipsis,
            ),
          )),
          const SizedBox(
            width: Constants.semanticsMarginExSmall,
          ),
          TextButton(
              onPressed: () {
                context.go(AppRouter.signup);
              },
              style:
                  TextButton.styleFrom(foregroundColor: AppColors.primaryColor),
              child: const Text("CHANGE"))
        ],
      ),
    );
  }
}
