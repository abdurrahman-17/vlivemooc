import 'package:flutter/material.dart';

class KeepAliveMixin extends StatefulWidget {
  final Widget child;
  const KeepAliveMixin({super.key, required this.child});

  @override
  State<KeepAliveMixin> createState() => _KeepAliveMixinState();
}

class _KeepAliveMixinState extends State<KeepAliveMixin>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.child;
  }
}
