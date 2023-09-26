import 'package:flutter/material.dart';
import 'package:vlivemooc/ui/constants/colors.dart';
import 'package:vlivemooc/ui/constants/constants.dart';

class BoxedTextField extends StatefulWidget {
  final TextEditingController controller;
  final String titleText;
  final String errorText;
  final bool autoFocus;
  final TextInputAction textInputAction;
  final Function(String value)? onSubmitted;
  final TextInputType keyboardType;
  final bool obscureText;
  final bool enabled;
  final Widget? icon;
  const BoxedTextField(
      {super.key,
      required this.controller,
      required this.titleText,
      this.errorText = "",
      this.textInputAction = TextInputAction.next,
      this.autoFocus = false,
      this.onSubmitted,
      this.keyboardType = TextInputType.text,
      this.obscureText = false,
      this.enabled = true,
      this.icon});

  @override
  State<BoxedTextField> createState() => _BoxedTextFieldState();
}

class _BoxedTextFieldState extends State<BoxedTextField> {
  bool obscureText = false;
  @override
  void initState() {
    super.initState();
    obscureText = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        widget.titleText,
        style: const TextStyle(
            color: Colors.black, fontSize: Constants.fontSizeSmall),
      ),
      const SizedBox(
        height: Constants.semanticsMarginExSmall,
      ),
      SizedBox(
        height: Constants.buttonHeight,
        child: TextField(
          enabled: widget.enabled,
          controller: widget.controller,
          cursorColor: AppColors.primaryColor,
          textInputAction: widget.textInputAction,
          autofocus: widget.autoFocus,
          onSubmitted: widget.onSubmitted,
          keyboardType: widget.keyboardType,
          obscureText: obscureText,
          maxLines: 1,
          decoration: InputDecoration(
            prefixIcon: widget.icon,
            isDense: true,
            prefixIconColor: MaterialStateColor.resolveWith((states) =>
                states.contains(MaterialState.focused)
                    ? AppColors.primaryColor
                    : Colors.grey),
            suffixIcon: widget.obscureText
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        obscureText = !obscureText;
                      });
                    },
                    icon: Icon(
                        obscureText ? Icons.visibility_off : Icons.visibility))
                : null,
            suffixIconColor: AppColors.primaryColor,
            border: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.black, width: 1.0),
              borderRadius:
                  BorderRadius.circular(Constants.textFieldCornerRadius),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.primaryColor, width: 1.0),
              borderRadius:
                  BorderRadius.circular(Constants.textFieldCornerRadius),
            ),
          ),
        ),
      ),
      const SizedBox(
        height: Constants.semanticsMarginExSmall,
      ),
      widget.errorText.isNotEmpty
          ? Text(
              widget.errorText,
              style: const TextStyle(
                  color: Colors.red, fontSize: Constants.fontSizeSmall),
            )
          : Container(),
    ]);
  }
}
