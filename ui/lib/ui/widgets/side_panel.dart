import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../extensions/screen_utils_extensions.dart';
import '../controller.dart';

class SidePanel extends ConsumerWidget {
  const SidePanel({
    super.key,
    required this.content,
  });

  final Widget content;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = 340.wm;
    final controller = ref.watch(controllerProvider);
    // final notifier = ref.read(controllerProvider.notifier);

    return AnimatedContainer(
      padding: EdgeInsets.symmetric(horizontal: 8.wm, vertical: 8.hm),
      duration: 700.ms,
      curve: Curves.easeOutCirc,
      width: controller.isSidePanelOpen ? width : 0,
      height: double.infinity,
      child: AnimatedCrossFade(
        firstChild: SizedBox(
          width: width - 40.wm,
          child: content,
        ),
        secondChild: const SizedBox.shrink(),
        alignment: Alignment.centerLeft,
        crossFadeState: controller.isSidePanelOpen
            ? CrossFadeState.showFirst
            : CrossFadeState.showSecond,
        duration: 150.ms,
        layoutBuilder: (topChild, topChildKey, bottomChild, bottomChildKey) {
          return Stack(
            clipBehavior: Clip.none,
            fit: StackFit.expand,
            children: [
              Positioned(
                key: bottomChildKey,
                left: 0,
                bottom: 0,
                top: 0,
                child: bottomChild,
              ),
              Positioned(
                key: topChildKey,
                left: 0,
                bottom: 0,
                top: 0,
                child: topChild,
              ),
            ],
          );
        },
      ),
    );
  }
}
