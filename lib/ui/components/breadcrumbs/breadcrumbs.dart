import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vlivemooc/ui/constants/constants.dart';

import '../../routes/Routes.dart';

class BreadCrumbs extends StatefulWidget {
  final String path;
  const BreadCrumbs({super.key, required this.path});

  @override
  State<BreadCrumbs> createState() => _BreadCrumbsState();
}

class _BreadCrumbsState extends State<BreadCrumbs> {
  late List<String> crumbs;
  @override
  void initState() {
    super.initState();
    crumbs = widget.path.split("/");
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(Constants.insetPadding),
      child: Padding(
        padding: const EdgeInsets.all(Constants.semanticsMarginExSmall),
        child: SizedBox(
            height: 35,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: crumbs.length,
                itemBuilder: (BuildContext context, int index) {
                  String crumb = crumbs[index];
                  return Crumb(
                    crumb: crumb,
                    index: index,
                  );
                })),
      ),
    );
  }
}

class Crumb extends StatelessWidget {
  final String crumb;
  final int index;
  const Crumb({super.key, required this.crumb, required this.index});

  onClick(BuildContext context) {
    if (crumb.toLowerCase() == "home") {
      context.go(AppRouter.home);
    } else {
      String lower = crumb.toLowerCase();
      context.go("/$lower");
    }
  }

  @override
  Widget build(BuildContext context) {
    return index == 0
        ? TextButton(
            style: TextButton.styleFrom(foregroundColor: Colors.black),
            onPressed: () {
              onClick(context);
            },
            child: Text(
              crumb,
              style: const TextStyle(fontSize: Constants.fontSizeSmall),
            ))
        : TextButton.icon(
            style: TextButton.styleFrom(foregroundColor: Colors.black),
            onPressed: () {
              onClick(context);
            },
            icon: const Icon(
              Icons.arrow_forward_ios,
              size: 20,
            ),
            label: Text(
              crumb,
              style: const TextStyle(fontSize: Constants.fontSizeSmall),
            ));
  }
}
