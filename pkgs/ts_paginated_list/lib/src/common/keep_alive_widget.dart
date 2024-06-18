import 'package:flutter/material.dart';

/// A widget that keeps its state alive even when it's not visible.
class KeepAliveWidget extends StatefulWidget {
  final Widget child;
  final bool keepAlive;

  const KeepAliveWidget({
    super.key,
    required this.child,
    this.keepAlive = true,
  });

  @override
  State<KeepAliveWidget> createState() => _KeepAliveWidgetState();
}

class _KeepAliveWidgetState extends State<KeepAliveWidget>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    if (widget.keepAlive) super.build(context);
    return widget.child;
  }

  @override
  bool get wantKeepAlive => widget.keepAlive;
}
