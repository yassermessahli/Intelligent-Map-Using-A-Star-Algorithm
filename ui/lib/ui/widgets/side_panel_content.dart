import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../extensions/context_extensions.dart';
import '../../extensions/screen_utils_extensions.dart';
import '../../models/city_model.dart';
import '../controller.dart';
import 'custom_image.dart';
import 'primary_button.dart';

class SidePanelContent extends ConsumerWidget {
  const SidePanelContent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(controllerProvider);
    final notifier = ref.read(controllerProvider.notifier);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Shortest Route',
                style: context.textTheme.titleMedium,
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: notifier.toggleSidePanel,
              ),
            ],
          ),
          10.gapH,
          _TotalDistance(controller.totalDistance ?? 0),
          20.gapH,
          const _LabelWithIcon(
            label: 'Start City',
            icon: Symbols.flag_rounded,
          ),
          6.gapH,
          _CityCard(
            city: controller.startCity,
            onClear: notifier.clearStartCity,
          ),
          10.gapH,
          _ArrowWithDistance(controller.getDistanceOfFirstCity),
          AnimatedSize(
            duration: 300.ms,
            curve: Curves.easeInOut,
            child: Column(
              children: [
                const SizedBox(width: double.infinity),
                for (final city in controller.citiesInBetween) ...[
                  8.gapH,
                  _InBetweenCityCard(city: city),
                  8.gapH,
                  _ArrowWithDistance(controller.getDistanceOf(city.name)),
                ],
              ],
            ),
          ),
          4.gapH,
          const _LabelWithIcon(
            label: 'End City',
            icon: Symbols.check_circle_rounded,
          ),
          6.gapH,
          _CityCard(
            city: controller.endCity,
            onClear: notifier.clearEndCity,
          ),
          Divider(
            color: context.colors.stroke,
            thickness: 1,
            height: 60.hm,
            indent: 10.wm,
          ),
          PrimaryButton(
            isLoading: controller.path.isLoading,
            onPressed: controller.canCalculateShortestRoute
                ? notifier.calculateShortestRoute
                : null,
            text: "Calculate Shortest Route",
            textStyle: context.textTheme.bodyMedium,
            icon: Symbols.directions_rounded,
            iconSize: 20.spMin,
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              horizontal: 10.wm,
              vertical: 24.hm,
            ),
          ),
          10.gapH,
          PrimaryButton.outlined(
            onPressed: notifier.clearPath,
            foregroundColor: context.colors.error,
            strokeColor: context.colors.error,
            text: "Reset",
            textStyle: context.textTheme.bodyMedium,
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              horizontal: 10.wm,
              vertical: 24.hm,
            ),
          ),
        ],
      ),
    );
  }
}

class _ArrowWithDistance extends StatelessWidget {
  const _ArrowWithDistance(this.distance);

  final int distance;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Symbols.arrow_downward_rounded,
          color: context.colors.textSecondary,
          size: 30.spMin,
          weight: 400,
        ),
        if (distance != 0) Text('$distance KM'),
      ],
    );
  }
}

class _TotalDistance extends StatelessWidget {
  const _TotalDistance(this.distance);

  final int distance;

  @override
  Widget build(BuildContext context) {
    return Animate(
      effects: [
        ScaleEffect(
          alignment: Alignment.center,
          begin: const Offset(0.5, 0.5),
          end: const Offset(1, 1),
          curve: Curves.easeOutCirc,
          duration: 300.ms,
        ),
        FadeEffect(
          begin: 0,
          end: 1,
          curve: Curves.easeOutCirc,
          duration: 300.ms,
        ),
      ],
      child: distance == 0
          ? const SizedBox.shrink()
          : Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 10.wm, vertical: 10.hm),
              decoration: BoxDecoration(
                color: context.colors.secondary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(4),
                border: Border.all(
                  color: context.colors.secondary.withOpacity(0.5),
                  width: 1,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total Distance',
                    style: context.textTheme.titleSmall,
                  ),
                  Text(
                    '$distance km',
                    style: context.textTheme.titleSmall,
                  ),
                ],
              ),
            ),
    );
  }
}

class _InBetweenCityCard extends StatelessWidget {
  const _InBetweenCityCard({
    required this.city,
  });

  final CityModel city;

  @override
  Widget build(BuildContext context) {
    return Animate(
      effects: [
        ScaleEffect(
          alignment: Alignment.center,
          begin: const Offset(0.5, 0.5),
          end: const Offset(1, 1),
          curve: Curves.easeOutCirc,
          duration: 300.ms,
        ),
        FadeEffect(
          begin: 0,
          end: 1,
          curve: Curves.easeOutCirc,
          duration: 300.ms,
        ),
      ],
      child: Container(
        width: double.infinity,
        height: 60.hm,
        padding: EdgeInsets.symmetric(horizontal: 10.wm),
        decoration: BoxDecoration(
          color: context.colors.primary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: context.colors.primary.withOpacity(0.5),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            CustomImage(
              city.imagePath,
              height: 30.hm,
              width: 30.wm,
              borderRadius: BorderRadius.circular(100),
            ),
            16.gapW,
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    city.name,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: context.textTheme.titleSmall,
                  ),
                  Text(
                    city.formattedCoordinates,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: context.textTheme.labelSmall?.copyWith(
                      fontSize: 14.spMin,
                    ),
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

class _LabelWithIcon extends StatelessWidget {
  const _LabelWithIcon({
    required this.label,
    required this.icon,
  });

  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: context.colors.textSecondary,
          size: 20.spMin,
          weight: 700,
        ),
        5.gapW,
        Text(
          label,
          style: context.textTheme.titleSmall?.copyWith(
            color: context.colors.textSecondary,
          ),
        ),
      ],
    );
  }
}

class _CityCard extends StatelessWidget {
  const _CityCard({
    required this.city,
    required this.onClear,
  });

  final CityModel? city;
  final VoidCallback? onClear;

  @override
  Widget build(BuildContext context) {
    final city = this.city;
    final isSelected = city != null;
    return AnimatedContainer(
      duration: 300.ms,
      curve: Curves.easeInOut,
      width: double.infinity,
      height: 80.hm,
      alignment: Alignment.center,
      padding: EdgeInsets.all(10.wm),
      decoration: BoxDecoration(
        color: isSelected ? context.colors.primary.withOpacity(0.1) : null,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: context.colors.strokeDarker, width: 1),
      ),
      child: city == null
          ? Text(
              'Select a city',
              style: context.textTheme.labelMedium,
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomImage(
                  city.imagePath,
                  height: 30.hm,
                  width: 30.wm,
                  borderRadius: BorderRadius.circular(100),
                ),
                16.gapW,
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        city.name,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: context.textTheme.titleSmall,
                      ),
                      Text(
                        city.formattedCoordinates,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: context.textTheme.labelSmall?.copyWith(
                          fontSize: 14.spMin,
                        ),
                      ),
                    ],
                  ),
                ),
                10.gapW,
                IconButton(
                  icon: Icon(
                    Symbols.delete_rounded,
                    size: 26.spMin,
                    color: context.colors.textSecondary,
                  ),
                  onPressed: onClear,
                ),
              ],
            ),
    );
  }
}
