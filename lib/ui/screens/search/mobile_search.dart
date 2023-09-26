import 'package:flutter/material.dart';
import 'package:vlivemooc/ui/components/search/search_text_field.dart';
import 'package:vlivemooc/ui/constants/constants.dart';

import '../bottomnav/search.dart';

class MobileSearch extends StatelessWidget {
  const MobileSearch({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
            padding: EdgeInsets.all(Constants.insetPadding),
            child: const SearchTextField()),
        const Expanded(child: Search())
      ],
    );
  }
}
