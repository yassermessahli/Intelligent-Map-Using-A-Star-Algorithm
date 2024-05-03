import 'package:dio_cache_interceptor_hive_store/dio_cache_interceptor_hive_store.dart';
import 'package:flutter_map_cache/flutter_map_cache.dart';
import 'package:latlong2/latlong.dart';
import 'package:path_provider/path_provider.dart';

abstract class MapsUtils {
  static const storeName = 'mapStore';
  static const urlTemplate = 'https://tile.openstreetmap.org/{z}/{x}/{y}.png';
  static late String hiveCachePath;
  static const packageName = 'dz.estin.shortest_path_map_app';

  static Future<void> initializeHiveCachePath() async {
    final cacheDir = await getApplicationCacheDirectory();
    hiveCachePath = cacheDir.path;
  }

  static Future<void> initCache() async {
    try {
      await initializeHiveCachePath();
    } catch (_) {
      // ignore
    }
  }

  static CachedTileProvider cacheTileProvider() {
    return CachedTileProvider(
      // maxStale keeps the tile cached for the given Duration and
      // tries to revalidate the next time it gets requested
      maxStale: const Duration(days: 30),
      store: HiveCacheStore(
        hiveCachePath,
        hiveBoxName: storeName,
      ),
    );
  }

  static List<LatLng> randomizePath({
    required List<LatLng> path,
    String seed = 'seed',
  }) {
    // if path contains more than 2 points, split it:
    if (path.length > 2) {
      final List<LatLng> randomizedPath = [];
      for (int i = 0; i < path.length - 1; i++) {
        final start = path[i];
        final end = path[i + 1];
        final wavyLinePoints = generateWavyLinePoints(
          start,
          end,
          20,
          seed,
        );
        randomizedPath.addAll(wavyLinePoints);
      }
      return randomizedPath;
    }

    final List<LatLng> randomizedPath = [];
    for (int i = 0; i < path.length - 1; i++) {
      final start = path[i];
      final end = path[i + 1];
      final wavyLinePoints = generateWavyLinePoints(
        start,
        end,
        20,
        seed,
        // randomness: 0.005,
      );
      randomizedPath.addAll(wavyLinePoints);
    }
    return randomizedPath;
  }

  static double interpolate(double start, double end, double weight) {
    return (end - start) * weight + start;
  }

  // static List<LatLng> generateWavyLinePoints({
  //   required LatLng start,
  //   required LatLng end,
  //   required int numPoints,
  //   required double randomness,
  // }) {
  //   List<LatLng> points = [];
  //   points.add(start);

  //   for (int i = 1; i <= numPoints; i++) {
  //     double weight = i / (numPoints + 1.0); // Weight for interpolation
  //     double lat = interpolate(start.latitude, end.latitude, weight) +
  //         randomness * (nextDouble() - 0.5); // Add randomness to latitude
  //     double lng = interpolate(start.longitude, end.longitude, weight) +
  //         randomness * (nextDouble() - 0.5); // Add randomness to longitude
  //     points.add(LatLng(lat, lng));
  //   }

  //   points.add(end);
  //   return points;
  // }

  static List<LatLng> generateWavyLinePoints(
      LatLng start, LatLng end, int numPoints, String seed) {
    List<LatLng> points = [];
    points.add(start);

    int hash = seed.hashCode; // Convert string seed to a hash code

    for (int i = 1; i <= numPoints; i++) {
      double weight = i / (numPoints + 1.0); // Weight for interpolation

      // Use bitwise operations and modulo for "controlled randomness"
      double offsetLat = ((hash >> (i * 2)) & 0x3F) / 35000;
      double offsetLng = ((hash >> (i * 2 + 1)) & 0x3F) / 35000;

      double lat =
          interpolate(start.latitude, end.latitude, weight) + offsetLat;
      double lng =
          interpolate(start.longitude, end.longitude, weight) + offsetLng;
      points.add(LatLng(lat, lng));
    }

    points.add(end);
    return points;
  }
}
