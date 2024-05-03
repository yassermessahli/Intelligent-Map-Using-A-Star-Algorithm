import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shortest_route_map/extensions/context_extensions.dart';
import 'package:shortest_route_map/ui/home_screen.dart';

class MapApp extends HookConsumerWidget {
  const MapApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: context.currentTheme,
      home: const HomeScreen(),
    );
  }
}
