import 'package:flutter/material.dart';
import 'package:vlivemooc/core/network/network_handler.dart';
import 'package:vlivemooc/ui/components/buttons/boxed_text_field.dart';
import 'package:vlivemooc/ui/components/buttons/circular_loading_button.dart';

import '../../constants/constants.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  TextEditingController currentPassword = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  TextEditingController confirmNewPassword = TextEditingController();
  String currentPasswordError = "";
  bool isLoading = false;
  String updatePasswordError = "";

  updatePassword(callback) async {
    if (currentPassword.text.isEmpty) {
      setState(() {
        currentPasswordError = "Please enter your current password";
      });
      return;
    }
    if (newPassword.text.isEmpty) {
      setState(() {
        updatePasswordError = "Please enter your new password";
      });
      return;
    }
    if (newPassword.text != confirmNewPassword.text) {
      setState(() {
        updatePasswordError = "Passwords do not match";
      });
      return;
    }

    if (newPassword.text == currentPassword.text) {
      setState(() {
        updatePasswordError = "New password should be different from current password.";
      });
      return;
    }

    setState(() {
      isLoading = true;
      updatePasswordError="";
    });

    try {
      await NetworkHandler.saveProfile(payload: {
        "password": newPassword.text,
        "oldpassword": currentPassword.text
      });
      currentPassword.text = "";
      newPassword.text = "";
      confirmNewPassword.text = "";

      callback("");
    } catch (err) {
      callback("Your current password is incorrect");
    }
  }

  @override
  void initState() {
    super.initState();
    currentPassword.addListener(() {
      if (currentPasswordError.isNotEmpty) {
        setState(() {
          currentPasswordError = "";
        });
      }
    });
    newPassword.addListener(() {
      if (currentPasswordError.isNotEmpty) {
        setState(() {
          updatePasswordError = "";
        });
      }
    });
    confirmNewPassword.addListener(() {
      if (currentPasswordError.isNotEmpty) {
        setState(() {
          updatePasswordError = "";
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              constraints: const BoxConstraints(maxWidth: 300),
              child: BoxedTextField(
                controller: currentPassword,
                titleText: "Current Password",
                obscureText: true,
                errorText: currentPasswordError,
              )),
          const SizedBox(
            height: Constants.semanticsMarginExSmall,
          ),
          Container(
              constraints: const BoxConstraints(maxWidth: 300),
              child: BoxedTextField(
                controller: newPassword,
                titleText: "New Password",
                obscureText: true,
              )),
          const SizedBox(
            height: Constants.semanticsMarginExSmall,
          ),
          Container(
              constraints: const BoxConstraints(maxWidth: 300),
              child: BoxedTextField(
                controller: confirmNewPassword,
                titleText: "Confirm New Password",
                errorText: updatePasswordError,
                obscureText: true,
              )),
          const SizedBox(
            height: Constants.semanticMarginDefault,
          ),
          SizedBox(
            width: 150,
            child: CircularLoadingElevatedButton(
                buttonText: "Update Password",
                isLoading: isLoading,
                onTap: () {
                  updatePassword((String message) {
                    if (message.isNotEmpty) {
                      setState(() {
                        currentPasswordError = message;
                      });
                    }
                    setState(() {
                      isLoading = false;
                    });
                    if (message.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("Your password was updated")));
                    }
                  });
                }),
          ),
          const SizedBox(
            height: Constants.semanticMarginDefault,
          )
        ],
      ),
    );
  }
}
