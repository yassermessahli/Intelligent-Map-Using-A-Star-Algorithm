import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shortest_route_map/extensions/color_extensions.dart';

import '../../extensions/context_extensions.dart';
import '../../extensions/screen_utils_extensions.dart';
import '../../models/city_model.dart';
import '../controller.dart';
import 'custom_image.dart';
import 'primary_button.dart';

class CityMarker extends Marker {
  CityMarker(
    CityModel city, {
    super.key,
    super.alignment = Alignment.center,
    super.rotate,
  }) : super(
          child: CityTileLayer(city: city),
          point: city.location,
          width: 154.wm,
          height: 60.wm,
        );
}

class CityTileLayer extends ConsumerWidget {
  const CityTileLayer({
    super.key,
    required this.city,
  });

  final CityModel city;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(controllerProvider);
    final notifier = ref.read(controllerProvider.notifier);

    final isCityInPath = controller.isCityInPath(city.name);
    final isCitySelected = controller.selectedCity?.name == city.name;

    return PrimaryButton(
      onPressed: () => notifier.selectCity(city.name),
      backgroundColor: isCityInPath
          ? context.colors.secondary.withOpacity(0.5).mergeWithWhite()
          : isCityInPath
              ? context.colors.primary.withOpacity(0.1).mergeWithWhite()
              : context.colors.white,
      foregroundColor: context.colors.primary,
      strokeColor: isCitySelected
          ? context.colors.textSecondary
          : isCityInPath
              ? context.colors.primary
              : context.colors.white,
      strokeWeight: isCityInPath ? 2 : 1,
      padding: EdgeInsets.all(3.rm),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomImage(
            city.imagePath,
            height: 56.rm,
            width: 50.rm,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(200),
              bottomLeft: Radius.circular(200),
              topRight: Radius.circular(20),
              bottomRight: Radius.circular(40),
            ),
          ),
          6.gapW,
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  city.name,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: context.textTheme.titleSmall?.copyWith(
                    fontSize: 18.spMin,
                  ),
                ),
                Text(
                  city.formattedCoordinates,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: context.textTheme.labelSmall?.copyWith(
                    fontSize: 12.spMin,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
