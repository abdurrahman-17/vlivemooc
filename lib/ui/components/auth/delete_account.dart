import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:vlivemooc/core/network/network_handler.dart';
import 'package:vlivemooc/ui/animations/loading_animation.dart';
import 'package:vlivemooc/ui/components/buttons/circular_loading_button.dart';
import 'package:vlivemooc/ui/constants/constants.dart';

import '../../../core/provider/user_provider.dart';
import '../../constants/colors.dart';
import '../../routes/Routes.dart';

class DeleteAccount extends StatefulWidget {
  const DeleteAccount({super.key});

  @override
  State<DeleteAccount> createState() => _DeleteAccountState();
}

class _DeleteAccountState extends State<DeleteAccount> {
  bool deleteCodeSent = false;
  bool isLoading = false;
  String errorText = "";
  TextEditingController otpController = TextEditingController();
  onSendCode(callback) async {
    setState(() {
      isLoading = true;
    });
    try {
      await NetworkHandler.sendDeleteAccountOtp();
      callback(true, "");
    } catch (error) {
      callback(false,
          "You have an active subscription, please cancel your subscription and try again.");
    }
  }

  @override
  void initState() {
    super.initState();
    otpController.addListener(() {
      setState(() {
        errorText = "";
      });
    });
  }

  onDeleteAccount(callback) async {
    setState(() {
      isLoading = true;
    });
    String otp = otpController.text;
    if (otp.isEmpty) {
      setState(() {
        errorText =
        "Please enter the OTP sent to your email ${Provider.of<UserProvider>(context, listen: false).subscriberModel!.email ?? ''}";
        isLoading = false;
      });

      return;
    } else if (otp.length != 6) {
      setState(() {
        errorText = "The otp must be of 6 digits";
        isLoading = false;
      });
      return;
    } else {
      try {
        await NetworkHandler.deleteAccount(otp);
        await NetworkHandler().logout();

        callback();
      } catch (error) {
        setState(() {
          errorText = "OTP is invalid or expired";
          isLoading = false;
        });
      }
    }
  }

  deleteAccountCallback() {
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Your account was deleted")));
    context.go(AppRouter.signup);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TextDescription(
              text:
              "NOTE: You must cancel any active enrolments prior to deleting your account, to avoid-any future changes."),
          const TextDescription(
              text:
              "Before deleting your account, please review the following:"),
          const TextDescription(
              text:
              "• If you delete your account, all of your personal information, including enrolments and certificates, will be deleted. You will immediately lose access to your account and beunable to log in."),
          const TextDescription(
              text:
              "• This action is irreversible - once your data has been deleted, we cannot recover it again."),
          const TextDescription(
              text:
              "• You will not be able to sign up again using the same email address for 30 days."),
          const TextDescription(
              text:
              "To prevent account deletion by accident, we have a 2-step verification process. Click below to get a delete code sent to your email. Use that code to verify your request and to continue withthe deletion process."),
          const SizedBox(
            height: Constants.semanticMarginDefault,
          ),
          deleteCodeSent
              ? Container()
              : OutlinedButton(
            style: OutlinedButton.styleFrom(
                foregroundColor: Colors.red,
                side: const BorderSide(color: Colors.red)),
            onPressed: () {
              onSendCode((bool canDelete, String message) {
                setState(() {
                  isLoading = false;
                });
                if (canDelete) {
                  setState(() {
                    deleteCodeSent = true;
                    errorText =
                    "An OTP has been sent on your email ${Provider.of<UserProvider>(context, listen: false).subscriberModel!.email ?? ''}";
                  });
                } else {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(message)));
                }
              });
            },
            child: const Text("Send Delete Code"),
          ),
          isLoading && !deleteCodeSent ? const LoadingAnimation() : Container(),
          const SizedBox(
            height: Constants.semanticsMarginExSmall,
          ),
          deleteCodeSent
              ? SizedBox(
            height: Constants.buttonHeight,
            width: 200,
            child: TextField(
              textInputAction: TextInputAction.done,
              controller: otpController,
              cursorColor: AppColors.primaryColor,
              maxLength: 6,
              onSubmitted: (value) {
                onDeleteAccount(deleteAccountCallback);
              },
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.message),
                counterText: "",
                prefixIconColor: MaterialStateColor.resolveWith(
                        (states) => states.contains(MaterialState.focused)
                        ? AppColors.primaryColor
                        : Colors.grey),
                border: OutlineInputBorder(
                  borderSide:
                  const BorderSide(color: Colors.black, width: 1.0),
                  borderRadius: BorderRadius.circular(
                      Constants.textFieldCornerRadius),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: AppColors.primaryColor, width: 1.0),
                  borderRadius: BorderRadius.circular(
                      Constants.textFieldCornerRadius),
                ),
              ),
            ),
          )
              : Container(),
          const SizedBox(
            height: Constants.semanticsMarginExSmall,
          ),
          errorText.isNotEmpty
              ? Text(
            errorText,
            style: const TextStyle(
                color: Colors.red, fontSize: Constants.fontSizeSmall),
          )
              : Container(),
          const SizedBox(
            height: Constants.semanticMarginDefault,
          ),
          deleteCodeSent
              ? SizedBox(
            width: 200,
            child: CircularLoadingElevatedButton(
                buttonText: "Permanently Delete",
                isLoading: isLoading,
                onTap: () {
                  onDeleteAccount(deleteAccountCallback);
                }),
          )
              : Container(),
        ],
      ),
    );
  }
}

class TextDescription extends StatelessWidget {
  final String text;
  const TextDescription({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: Constants.semanticsMarginExSmall),
      child: Text(
        text,
        style: const TextStyle(
            fontSize: Constants.fontSizeDefault, color: Colors.grey),
      ),
    );
  }
}
