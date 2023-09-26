import 'package:flutter/material.dart';
import 'package:vlivemooc/core/helpers/app_screen_dimen.dart';
import 'package:vlivemooc/ui/components/app_version/app_version.dart';
import 'package:vlivemooc/ui/constants/colors.dart';

import '../../constants/constants.dart';

class AccountNav extends StatefulWidget {
  final Function onTap;
  final List<String> navItems;
  final int selectedItem;
  const AccountNav(
      {super.key,
        required this.onTap,
        required this.navItems,
        required this.selectedItem});

  @override
  State<AccountNav> createState() => _AccountNavState();
}

class _AccountNavState extends State<AccountNav> {

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.accentColor,
      child: Padding(
        padding: EdgeInsets.all(Constants.insetPadding),
        child: Column(
          children: [
            isMobile(context)?Container():const Text(
              "My Account",
              style: TextStyle(
                  fontSize: Constants.fontSizeMedium,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: Constants.semanticMarginDefault,
            ),
            Expanded(
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: widget.navItems.length,
                  itemBuilder: (context, index) {
                    String item = widget.navItems[index];
                    return Padding(
                      padding: const EdgeInsets.only(
                          bottom: Constants.semanticsMarginExSmall),
                      child: AccountNavItem(
                        item: item,
                        index: index,
                        selectedItem: widget.selectedItem,
                        onTap: widget.onTap,
                      ),
                    );
                  }),
            ),
            const AppVersion(),
          ],
        ),
      ),
    );
  }
}

class AccountNavItem extends StatefulWidget {
  final String item;
  final int index;
  final int selectedItem;
  final Function onTap;
  const AccountNavItem(
      {super.key,
        required this.item,
        required this.index,
        required this.selectedItem,
        required this.onTap});

  @override
  State<AccountNavItem> createState() => _AccountNavItemState();
}

class _AccountNavItemState extends State<AccountNavItem> {

  bool isFocus = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          widget.onTap(widget.index);
        },
        onFocusChange: (value) {
          setState(() {
            if(value == false){
              isFocus = value;
            }else{
              isFocus = value;
            }
          });
        },
        child: Container(
          color: isFocus ? ThemeData().focusColor : null,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            padding: const EdgeInsets.all(Constants.buttonHeight / 4),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(2)),
              color: widget.selectedItem == widget.index
                  ? AppColors.primaryColor
                  : null,
            ),
            child: Text(
              widget.item,
              style: TextStyle(
                  fontSize: Constants.fontSizeDefault,
                  color: widget.selectedItem == widget.index ? Colors.white : Colors.black),
            ),
          ),
        ));
  }
}
