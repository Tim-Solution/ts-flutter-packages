import 'package:flutter/material.dart';

/// Constants for the package.
abstract class PackageConstants {
  PackageConstants._();

  static SliverGridDelegate defaultGridDelegate(BuildContext context) {
    return SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisSpacing: 20,
      mainAxisSpacing: 20,
      crossAxisCount: MediaQuery.sizeOf(context).width > 1000 ? 3 : 2,
    );
  }
}
