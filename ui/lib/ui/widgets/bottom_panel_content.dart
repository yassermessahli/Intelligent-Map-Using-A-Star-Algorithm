import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../extensions/context_extensions.dart';
import '../../extensions/screen_utils_extensions.dart';
import '../../models/city_model.dart';
import '../controller.dart';
import 'custom_image.dart';
import 'primary_button.dart';

class BottomPanelContent extends ConsumerWidget {
  const BottomPanelContent({super.key, required this.city});

  final CityModel? city;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(controllerProvider.notifier);
    final city = this.city;
    if (city == null) {
      return const SizedBox.shrink();
    }

    return Row(
      children: [
        CustomImage(
          city.imagePath,
          height: 200.hm,
          width: 200.wm,
          borderRadius: BorderRadius.circular(4),
        ),
        30.gapW,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                city.name,
                style: context.textTheme.titleLarge,
              ),
              Row(
                children: [
                  Icon(
                    Symbols.location_on_rounded,
                    color: context.colors.label,
                  ),
                  5.gapW,
                  Text(
                    city.formattedCoordinates,
                    style: context.textTheme.labelSmall,
                  ),
                ],
              ),
              10.gapH,
              Text(
                city.desciption,
                style: context.textTheme.labelSmall,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        30.gapW,
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Flexible(
              child: IconButton(
                icon: const Icon(Icons.close),
                onPressed: notifier.toggleBottomPanel,
                visualDensity: VisualDensity.compact,
              ),
            ),
            4.gapH,
            Flexible(
              child: PrimaryButton(
                onPressed: () => notifier.setStartCity(city.name),
                icon: Symbols.flag,
                text: "Select As Start",
                backgroundColor: context.colors.purple,
              ),
            ),
            8.gapH,
            Flexible(
              child: PrimaryButton(
                onPressed: () => notifier.setEndCity(city.name),
                icon: Symbols.check,
                text: "Select As End",
                backgroundColor: context.colors.secondary3,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
