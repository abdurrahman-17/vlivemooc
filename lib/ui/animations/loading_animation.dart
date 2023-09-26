import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoadingAnimation extends StatelessWidget {
  final double width;
  const LoadingAnimation({super.key, this.width = 100});

  @override
  Widget build(BuildContext context) {
    return Lottie.asset('assets/anim/loading.json', width: width);
  }
}
