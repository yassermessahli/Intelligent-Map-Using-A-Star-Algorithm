import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../extensions/context_extensions.dart';
import '../../extensions/screen_utils_extensions.dart';
import '../controller.dart';
import 'bottom_panel_content.dart';
import 'custom_switcher.dart';

class BottomPanel extends ConsumerWidget {
  const BottomPanel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final height = 180.hm;
    final controller = ref.watch(controllerProvider);
    // final notifier = ref.read(controllerProvider.notifier);

    return AnimatedContainer(
      padding: EdgeInsets.all(16.rm),
      duration: 600.ms,
      curve: Curves.easeOutCirc,
      width: double.infinity,
      height: controller.isBottomPanelOpen ? height : 0,
      decoration: BoxDecoration(
        color: controller.isBottomPanelOpen
            ? context.colors.white
            : context.colors.white.withOpacity(.5),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: controller.isBottomPanelOpen
                ? context.colors.black.withOpacity(0.1)
                : Colors.transparent,
            blurRadius: 2,
            spreadRadius: 2,
          ),
        ],
      ),
      child: AnimatedCrossFade(
        firstChild: SizedBox(
          height: height - 40.hm,
          child: CustomSwitcher(
            child: SizedBox(
              key: ValueKey(controller.selectedCity?.name),
              child: BottomPanelContent(city: controller.selectedCity),
            ),
          ),
        ),
        secondChild: const SizedBox.shrink(),
        alignment: Alignment.centerLeft,
        crossFadeState: controller.isBottomPanelOpen
            ? CrossFadeState.showFirst
            : CrossFadeState.showSecond,
        duration: 150.ms,
        layoutBuilder: (topChild, topChildKey, bottomChild, bottomChildKey) {
          return Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(
                key: bottomChildKey,
                left: 0,
                right: 0,
                top: 0,
                child: bottomChild,
              ),
              Positioned(
                key: topChildKey,
                left: 0,
                right: 0,
                bottom: 0,
                child: topChild,
              ),
            ],
          );
        },
      ),
    );
  }
}
