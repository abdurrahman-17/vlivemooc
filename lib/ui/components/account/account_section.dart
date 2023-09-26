import 'package:flutter/material.dart';
import 'package:vlivemooc/ui/constants/constants.dart';

class AccountSection extends StatelessWidget {
  final Widget child;
  final String title;
  const AccountSection({super.key, required this.child, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: EdgeInsets.all(Constants.insetPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
                fontSize: Constants.fontSizeMedium,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: Constants.semanticMarginDefault,
          ),
          Expanded(child: child),
        ],
      ),
    );
  }
}
