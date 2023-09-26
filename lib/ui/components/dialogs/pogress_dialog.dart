
import 'package:flutter/material.dart';
import '../../animations/loading_animation.dart';

 showProgressDialog(BuildContext context) {
  return showDialog<void>(
    context: context,
      barrierDismissible:false,
      builder: (BuildContext context) {
      return  const AlertDialog(
        content: SizedBox(height: 80,child: LoadingAnimation()),
      );
    },
  );
}