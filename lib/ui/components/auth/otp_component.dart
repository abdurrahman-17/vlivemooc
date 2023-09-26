import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:vlivemooc/core/helpers/app_screen_dimen.dart';
import 'package:vlivemooc/core/helpers/text_styles.dart';
import 'package:vlivemooc/ui/constants/colors.dart';
import 'package:vlivemooc/ui/constants/constants.dart';
import 'package:vlivemooc/ui/constants/string_constants.dart';

import '../../../core/network/network_handler.dart';
import '../../../core/provider/user_provider.dart';

class OtpComponent extends StatefulWidget {
  final Function onOtpEntered;
  final String invalidOtpMsg;
  final bool isVerifyOtp;

  const OtpComponent(
      {Key? key,
        required this.onOtpEntered,
        required this.invalidOtpMsg,
        required this.isVerifyOtp})
      : super(key: key);

  @override
  State<OtpComponent> createState() => _OtpComponentState();
}

class _OtpComponentState extends State<OtpComponent> {
  final pinController = TextEditingController();
  final focusNode = FocusNode();
  final formKey = GlobalKey<FormState>();
  bool _showResendButton = false;
  int _remainingSeconds = 45;
  late Timer _timer;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    showResendButton();
  }

  @override
  void dispose() {
    _timer.cancel();
    pinController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  bool isLoading = false;

  showResendButton(){
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingSeconds > 0) {
          _remainingSeconds--;
        } else {
          _showResendButton = true;
          _timer.cancel();
        }
      });
    });
  }

  onResendOtp({required callback}) async {
    if (isLoading) {
      return;
    }
    setState(() {
      isLoading = true;
    });

    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    String email = userProvider.signupPageForm;

    bool isEmail = userProvider.signupPageIsEmail;
    String emailID = "";
    String phone = "";
    if (isEmail) {
      emailID = email;
    } else {
      phone = userProvider.signupCountryCode + email;
    }

    try {
      if(widget.isVerifyOtp){
        Response<dynamic> response = await NetworkHandler.resendEmailOrPhoneVerification(
            email: isEmail ? emailID : "", phone: isEmail ? "" : phone);
        callback(response);

      }else{
        Response<dynamic> response =
        await NetworkHandler.forgotPassword(email: emailID, mobileno: phone);
        callback(response);

      }

    } catch (e) {
      //Do anything we wanna do
      /*ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text(StringConstants.otpSentSuccessfully)));*/
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    const focusedBorderColor = Color.fromRGBO(73, 10, 83, 0.7);
    const borderColor = Color.fromRGBO(73, 10, 83, 0.32);
    final defaultPinTheme = PinTheme(
      width: 45,
      height: 45,
      textStyle: const TextStyle(
        fontSize: 16,
        color: Color.fromRGBO(30, 60, 87, 1),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: borderColor),
      ),
    );

    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Enter OTP",
            style: poppinsLight(13, AppColors.textLight1),
          ),
          const SizedBox(
            height: Constants.semanticMarginTen,
          ),
          // Implement 6 input fields
          Pinput(
            length: 6,
            controller: pinController,
            focusNode: focusNode,
            androidSmsAutofillMethod:
            AndroidSmsAutofillMethod.smsUserConsentApi,
            listenForMultipleSmsOnAndroid: true,
            defaultPinTheme: defaultPinTheme,
            separatorBuilder: (index) => const SizedBox(width: 8),
            /* validator: (value) {
              return value == '2222' ? null : 'Pin is incorrect';
            },*/
            // onClipboardFound: (value) {
            //   debugPrint('onClipboardFound: $value');
            //   pinController.setText(value);
            // },
            hapticFeedbackType: HapticFeedbackType.lightImpact,
            onCompleted: (pin) {
              widget.onOtpEntered(pin);
            },
            onChanged: (value) {
              debugPrint('onChanged: $value');
            },
            cursor: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 9),
                  width: 22,
                  height: 1,
                  color: focusedBorderColor,
                ),
              ],
            ),
            focusedPinTheme: defaultPinTheme.copyWith(
              decoration: defaultPinTheme.decoration!.copyWith(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: focusedBorderColor),
              ),
            ),

            errorPinTheme: defaultPinTheme.copyBorderWith(
              border: Border.all(color: Colors.redAccent),
            ),
          ),
          const SizedBox(
            height: Constants.semanticsMarginExSmall,
          ),
          if (isLoading)
            SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  color: AppColors.primaryColor,
                )),

          Visibility(
              visible: widget.invalidOtpMsg.isNotEmpty,
              child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: Constants.semanticMarginTen),
                  child: Text(
                    widget.invalidOtpMsg,
                    style: poppinsMedium(12, AppColors.redcolor),
                  ))),
          if (!isLoading)
            Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: Constants.semanticMarginTen),
              child: Row(
                children: [
                  if(_showResendButton)
                      InkWell(
                      onTap:  () {
                        setState(() {
                          _showResendButton = false;
                          _remainingSeconds = 45;
                          showResendButton();
                        });
                        //Resend OTP API
                        onResendOtp(callback: onOtpSendSuccessful);
                      },
                      child: Text(
                        "RESEND OTP",
                        style: poppinsMedium(14, AppColors.primaryColor),
                      )),
                  if(_showResendButton) sizedBoxWidth10(context),
                  if (_showResendButton == false)
                    Text(
                      "$_remainingSeconds seconds",
                      style: poppinsLight(13, AppColors.textLight1),
                    ),
                ],
              ),
            ),
          const SizedBox(
            height: Constants.semanticsMarginExSmall,
          ),
          // Display the entered OTP code
        ],
      ),
    );
  }

  onOtpSendSuccessful(Response<dynamic> response) {

    UserProvider userProvider =
    Provider.of<UserProvider>(context, listen: false);

    bool isEmail = userProvider.signupPageIsEmail;

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(isEmail?StringConstants.otpSentSuccessfully:StringConstants.otpSentMobileSuccessfully)));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(response.statusMessage ?? "")));
    }
  }
}
