import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vlivemooc/core/network/network_handler.dart';
import 'package:vlivemooc/core/provider/user_provider.dart';
import 'package:vlivemooc/ui/components/buttons/boxed_text_field.dart';
import 'package:vlivemooc/ui/components/buttons/circular_loading_button.dart';
import 'package:vlivemooc/ui/components/buttons/signup_disabled_text_field.dart';
import 'package:vlivemooc/ui/constants/constants.dart';
import 'package:provider/provider.dart';
import 'package:vlivemooc/ui/routes/Routes.dart';

import '../buttons/social_login.dart';

class CreateAccountComponent extends StatefulWidget {
  const CreateAccountComponent({super.key});

  @override
  State<CreateAccountComponent> createState() => _CreateAccountComponentState();
}

class _CreateAccountComponentState extends State<CreateAccountComponent> {
  bool isLoading = false;
  TextEditingController passwordController = TextEditingController();
  late TextEditingController nameController;
  String error = "";
  String nameerror = "";

  @override
  initState() {
    super.initState();

    nameController = TextEditingController(
        text: Provider.of<UserProvider>(context, listen: false).displayName);

    passwordController.addListener(() {
      if (error.isNotEmpty) {
        setState(() {
          error = "";
        });
      }
    });
    nameController.addListener(() {
      if (nameerror.isNotEmpty) {
        setState(() {
          nameerror = "";
        });
      }
    });
  }

  onSubmit({required callback}) async {
    if (isLoading) {
      return;
    }

    String password = passwordController.text;
    if (password.isEmpty) {
      setState(() {
        error = "Password is required";
      });
      return;
    }

    String name = nameController.text;
    if (name.isEmpty) {
      setState(() {
        nameerror = "Name is required";
      });
      return;
    }

    setState(() {
      isLoading = true;
    });

    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    String value = userProvider.signupPageForm;
    bool isEmail = userProvider.signupPageIsEmail;
    String email = "";
    String phone = "";
    if (isEmail) {
      email = value;
    } else {
      phone = userProvider.signupCountryCode+value;
    }

    await NetworkHandler.createAccount(
        name: name, email: email, phone: phone, password: password);
    setState(() {
      isLoading = false;
    });
    callback();
  }

  parseResponse(BuildContext context) {

    UserProvider userProvider =
    Provider.of<UserProvider>(context, listen: false);
    String value = userProvider.signupPageForm;
    bool isEmail = userProvider.signupPageIsEmail;

    if(isEmail){
      context.go(AppRouter.signup);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("A verification link has been sent to your email")));
    }else{
      NetworkHandler.resendEmailOrPhoneVerification(
          email: isEmail ? value : "", phone: isEmail ? "" : userProvider.signupCountryCode+value);
      context.go(AppRouter.verifyAccount);

    }

  }

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          const SignupDisabledTextField(),
          const SizedBox(
            height: Constants.semanticMarginDefault,
          ),
          BoxedTextField(
            controller: nameController,
            keyboardType: TextInputType.name,
            autoFocus: true,
            textInputAction: TextInputAction.next,
            titleText: "Name",
            errorText: nameerror,
          ),
          const SizedBox(
            height: Constants.semanticMarginDefault,
          ),
          BoxedTextField(
            controller: passwordController,
            keyboardType: TextInputType.visiblePassword,
            obscureText: true,
            autoFocus: true,
            textInputAction: TextInputAction.done,
            titleText: "Create Password",
            onSubmitted: (value) {
              onSubmit(callback: () {
                parseResponse(context);
              });
            },
            errorText: error,
          ),
          const SizedBox(
            height: Constants.semanticMarginDefault,
          ),
          CircularLoadingElevatedButton(
            buttonText: "SIGNUP",
            onTap: () {
              onSubmit(callback: () {
                parseResponse(context);
              });
            },
            isLoading: isLoading,
          ),
          const SizedBox(
            height: Constants.semanticMarginDefault,
          ),
          const Text(
            "or continue with",
            style: TextStyle(fontSize: Constants.fontSizeSmall),
          ),
          const SizedBox(
            height: Constants.semanticMarginDefault,
          ),
          const SocialLogin()
        ],
      ),
    );
  }
}
