import 'package:flutter/material.dart';

import '../utility/global_var.dart';

// ignore: camel_case_types
class Responsive_Layout extends StatelessWidget {
  final Widget mobileScreenLayout;
  final Widget webScreenLayout;
  const Responsive_Layout(
      {super.key,
      required this.mobileScreenLayout,
      required this.webScreenLayout});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxHeight > webScreenSize) {
          return webScreenLayout;
        } else {
          return mobileScreenLayout;
        }
      },
    );
  }
}
