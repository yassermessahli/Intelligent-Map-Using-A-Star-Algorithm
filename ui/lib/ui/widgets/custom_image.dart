import 'package:flutter/material.dart';

import '../../extensions/screen_utils_extensions.dart';

class CustomImage extends StatelessWidget {
  const CustomImage(
    this.path, {
    super.key,
    this.borderRadius,
    this.width,
    this.height,
  });

  final String? path;
  final BorderRadius? borderRadius;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    if (path == null) {
      return const SizedBox.shrink();
    }

    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.zero,
      child: Image.asset(
        path!,
        width: width ?? 48.wm,
        height: height ?? 48.wm,
        fit: BoxFit.cover,
      ),
    );
  }
}
