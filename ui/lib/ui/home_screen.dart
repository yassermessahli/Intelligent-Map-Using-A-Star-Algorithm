import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../extensions/context_extensions.dart';
import '../extensions/screen_utils_extensions.dart';
import 'controller.dart';
import 'widgets/bottom_panel.dart';
import 'widgets/map_view.dart';
import 'widgets/side_panel.dart';
import 'widgets/side_panel_content.dart';

class HomeScreen extends HookConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(controllerProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Shortest Route Map'),
        backgroundColor: context.colors.primary,
        foregroundColor: context.colors.white,
        titleTextStyle: context.textTheme.titleLarge?.copyWith(
          color: context.colors.white,
          fontWeight: FontWeight.w500,
        ),
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: notifier.toggleSidePanel,
          // onPressed: () => expandableController.toggle(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            const SidePanel(content: SidePanelContent()),
            Expanded(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Positioned.fill(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: const MapView(),
                    ),
                  ),
                  Positioned(
                    right: 20.rm,
                    left: 20.rm,
                    bottom: 20.rm,
                    child: const BottomPanel(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
