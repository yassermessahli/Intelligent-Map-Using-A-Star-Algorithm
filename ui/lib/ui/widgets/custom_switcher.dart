import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class CustomSwitcher extends StatelessWidget {
  const CustomSwitcher({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return PageTransitionSwitcher(
      layoutBuilder: (List<Widget> entries) {
        return AnimatedSize(
          duration: 500.ms,
          alignment: Alignment.topCenter,
          clipBehavior: Clip.none,
          curve: Curves.easeInOut,
          child: Stack(
            alignment: Alignment.topCenter,
            children: entries,
          ),
        );
      },
      transitionBuilder: (
        Widget child,
        Animation<double> primaryAnimation,
        Animation<double> secondaryAnimation,
      ) {
        return SharedAxisTransition(
          animation: primaryAnimation,
          secondaryAnimation: secondaryAnimation,
          transitionType: SharedAxisTransitionType.vertical,
          child: child,
        );
      },
      child: child,
    );
  }
}
