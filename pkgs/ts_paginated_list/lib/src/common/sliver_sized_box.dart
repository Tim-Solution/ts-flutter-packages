import 'package:flutter/material.dart';

/// A sliver that has a fixed size.
class SliverSizedBox extends StatelessWidget {
  final double? height, width;
  final Widget? child;

  const SliverSizedBox({
    super.key,
    this.height,
    this.width,
    this.child,
  });

  const SliverSizedBox.height(
    this.height, {
    super.key,
    this.width,
    this.child,
  });

  const SliverSizedBox.width(
    this.width, {
    super.key,
    this.height,
    this.child,
  });

  const SliverSizedBox.shrink({
    super.key,
  })  : height = 0,
        width = 0,
        child = null;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: height,
        width: width,
        child: child,
      ),
    );
  }
}
