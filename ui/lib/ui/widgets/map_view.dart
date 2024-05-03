import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:shortest_route_map/data/data.dart';

import '../../extensions/context_extensions.dart';
import '../../utils/map_utils.dart';
import '../controller.dart';
import 'city_tile_layer.dart';

class MapView extends ConsumerWidget {
  const MapView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(controllerProvider);
    final notifier = ref.watch(controllerProvider.notifier);
    return GestureDetector(
      onTap: notifier.clearSelectedCity,
      child: FlutterMap(
        mapController: MapController(),
        options: const MapOptions(
          initialCenter: LatLng(36.6447806, 4.8552356),
          initialZoom: 13,
          maxZoom: 18,
          minZoom: 11,
          // cameraConstraint: CameraConstraint.contain(
          //   bounds: LatLngBounds(
          //     const LatLng(36.580313, 5.040307),
          //     const LatLng(36.823012, 4.741649),
          //   ),
          // ),
        ),
        children: [
          TileLayer(
            urlTemplate: MapsUtils.urlTemplate,
            userAgentPackageName: MapsUtils.packageName,
          ),
          PolylineLayer(
            polylines: [
              for (final route in Data.listOfRoutes())
                Polyline(
                  points: MapsUtils.randomizePath(path: route),
                  color: const Color.fromARGB(255, 118, 118, 118),
                  strokeWidth: 4,
                ),
              for (final route in controller.selectedCityPaths)
                Polyline(
                  points: MapsUtils.randomizePath(path: route),
                  color: const Color.fromARGB(255, 41, 31, 75),
                  strokeWidth: 4,
                ),
              Polyline(
                points: MapsUtils.randomizePath(
                    path: controller.pathData.coordinates),
                gradientColors: context.colors.gradient,
                strokeWidth: 12,
              ),
            ],
          ),
          MarkerLayer(
            markers: [
              for (final city in Data.cities) CityMarker(city),
            ],
          ),
        ],
      ),
    );
  }
}
