import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:vlivemooc/core/provider/user_provider.dart';
import 'package:vlivemooc/ui/constants/colors.dart';
import 'package:vlivemooc/ui/constants/constants.dart';
import 'package:vlivemooc/ui/routes/Routes.dart';

class EmailDisabledTextField extends StatelessWidget {
  final String titleText;
  const EmailDisabledTextField({super.key,required this. titleText});
  @override
  Widget build(BuildContext context) {
    String value =
        Provider.of<UserProvider>(context, listen: false).signupPageForm;
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        titleText,
        style: const TextStyle(
            color: Colors.black, fontSize: Constants.fontSizeSmall),
      ),
      const SizedBox(
        height: Constants.semanticsMarginExSmall,
      ),
      Container(
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
      )
    ]);


  }
}
