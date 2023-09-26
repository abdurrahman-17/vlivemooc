import 'package:flutter/material.dart';

import '../../../core/models/content/content_model/datum.dart';
import '../../constants/colors.dart';

class Download extends StatelessWidget {
  final Datum content;
  final double size;
  const Download({super.key, required this.content, this.size = 30});

  @override
  Widget build(BuildContext context) {
    return IconButton(
        padding: EdgeInsets.zero,
        onPressed: () {},
        icon: Icon(
          Icons.download_rounded,
          color: AppColors.primaryColor,
          size: size,
        ));
  }
}
