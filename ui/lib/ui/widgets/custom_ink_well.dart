import 'package:flutter/material.dart';

class CustomInkWell extends StatelessWidget {
  const CustomInkWell({
    super.key,
    this.onTap,
    this.borderRadius,
    required this.child,
    this.splashColor,
  });

  final VoidCallback? onTap;
  final BorderRadius? borderRadius;
  final Widget child;
  final Color? splashColor;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: borderRadius,
        splashColor: splashColor,
        child: child,
      ),
    );
  }
}
