import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shortest_route_map/app.dart';
import 'package:shortest_route_map/utils/map_utils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MapsUtils.initCache();
  runApp(
    ProviderScope(
      child: ScreenUtilInit(
        designSize: const Size(1920, 1080),
        builder: (_, __) => const MapApp(),
      ),
    ),
  );
}
