import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:shortest_route_map/data/data.dart';
import 'package:shortest_route_map/data/repository.dart';
import 'package:shortest_route_map/models/path_model.dart';

import '../models/city_model.dart';

final controllerProvider = StateNotifierProvider<Controller, State>((ref) {
  final repository = ref.watch(repositoryProvider);
  return Controller(repository);
});

class Controller extends StateNotifier<State> {
  Controller(this.repository) : super(const State());

  final Repository repository;

  Future<void> calculateShortestRoute() async {
    final startCity = state.startCity;
    final endCity = state.endCity;

    if (startCity == null || endCity == null) {
      return;
    }

    state = state.setPathLoading();
    final path = await repository.calculatePath(
      origin: startCity.name,
      destination: endCity.name,
    );
    state = state.setPathData(path);
  }

  void clearPath() {
    state = state.clearPath();
  }

  void clearSelectedCity() {
    state = state.clearSelectedCity();
  }

  void clearStartCity() {
    state = state.clearStartCity();
  }

  void clearEndCity() {
    state = state.clearEndCity();
  }

  void toggleSidePanel() {
    state = state.copyWith(isSidePanelOpen: !state.isSidePanelOpen);
  }

  void toggleBottomPanel() {
    if (state.isBottomPanelOpen) {
      state = state.clearSelectedCity();
    } else {
      state = state.copyWith(isBottomPanelOpen: true);
    }
  }

  void selectCity(String cityName) {
    state = state.copyWith(
      selectedCityName: cityName,
      isBottomPanelOpen: true,
    );
  }

  void setStartCity(String cityName) {
    state = state.copyWith(
      startCityName: cityName,
      isSidePanelOpen: true,
      path: const AsyncData(null),
    );

    if (state.endCityName == cityName) {
      clearEndCity();
    }
  }

  void setEndCity(String cityName) {
    state = state.copyWith(
      endCityName: cityName,
      isSidePanelOpen: true,
      path: const AsyncData(null),
    );

    if (state.startCityName == cityName) {
      clearStartCity();
    }
  }
}

class State extends Equatable {
  final String? selectedCityName;
  final String? startCityName;
  final String? endCityName;
  final bool isSidePanelOpen;
  final bool isBottomPanelOpen;
  final AsyncValue<PathModel?> path;

  const State({
    this.selectedCityName,
    this.startCityName,
    this.endCityName,
    this.isSidePanelOpen = false,
    this.isBottomPanelOpen = false,
    this.path = const AsyncData(null),
  });

  static final cities = Data.cities;

  bool isCityInPath(String cityName) {
    return pathCities.contains(cityName);
  }

  List<List<LatLng>> get selectedCityPaths {
    // if (pathData.cities.isNotEmpty) return List.empty();

    final selectedCity = this.selectedCity;
    if (selectedCity == null) {
      return [];
    }

    final routes = <List<LatLng>>[];
    for (final route in Data.listOfRoutes()) {
      if (route.contains(selectedCity.location)) {
        routes.add(route);
      }
    }
    return routes;
  }

  PathModel get pathData =>
      path.asData?.value ?? const PathModel(cities: [], distances: []);

  List<CityModel> get citiesInBetween {
    if (pathCitiesModels.length < 3) return List.empty();
    return pathCitiesModels.sublist(1, pathCitiesModels.length - 1);
  }

  List<String> get pathCities => pathData.cities;
  List<CityModel> get pathCitiesModels => pathCities
      .map((cityName) => cities.firstWhere((city) => city.name == cityName))
      .toList();
  List<int> get pathDistances => pathData.distances;

  int get getDistanceOfFirstCity {
    if (pathCities.isEmpty) return 0;
    return getDistanceOf(pathCities.first);
  }

  int getDistanceOf(String city) {
    if (pathCities.isEmpty) return 0;
    final index = pathCities.indexOf(city);
    if (index == -1) return 0;
    return pathDistances[index];
  }

  bool get isSelectedCitySelected => selectedCity != null;
  bool get isStartCitySelected => startCity != null;
  bool get isEndCitySelected => endCity != null;

  int? get totalDistance {
    if (pathDistances.isEmpty) return null;
    return pathData.totalDistance;
  }

  bool get canCalculateShortestRoute =>
      isStartCitySelected && isEndCitySelected && startCityName != endCityName;

  bool get canReset {
    return isStartCitySelected && isEndCitySelected;
  }

  CityModel? get selectedCity {
    return cities.firstWhereOrNull((city) => city.name == selectedCityName);
  }

  CityModel? get startCity {
    return cities.firstWhereOrNull((city) => city.name == startCityName);
  }

  CityModel? get endCity {
    return cities.firstWhereOrNull((city) => city.name == endCityName);
  }

  State copyWith({
    String? selectedCityName,
    String? startCityName,
    String? endCityName,
    bool? isSidePanelOpen,
    bool? isBottomPanelOpen,
    AsyncValue<PathModel?>? path,
  }) {
    return State(
      selectedCityName: selectedCityName ?? this.selectedCityName,
      startCityName: startCityName ?? this.startCityName,
      endCityName: endCityName ?? this.endCityName,
      isSidePanelOpen: isSidePanelOpen ?? this.isSidePanelOpen,
      isBottomPanelOpen: isBottomPanelOpen ?? this.isBottomPanelOpen,
      path: path ?? this.path,
    );
  }

  State setPathData(PathModel? path) {
    return copyWith(path: AsyncData(path));
  }

  State setPathError(Object e, StackTrace st) {
    return copyWith(path: AsyncError(e, st));
  }

  State setPathLoading() {
    return copyWith(path: const AsyncLoading());
  }

  State clearPath() {
    return State(
      selectedCityName: null,
      startCityName: null,
      endCityName: null,
      isSidePanelOpen: isSidePanelOpen,
      isBottomPanelOpen: false,
      path: const AsyncData(null),
    );
  }

  State clearSelectedCity() {
    return State(
      startCityName: startCityName,
      endCityName: endCityName,
      isSidePanelOpen: isSidePanelOpen,
      selectedCityName: null,
      isBottomPanelOpen: false,
      path: path,
    );
  }

  State clearStartCity() {
    return State(
      selectedCityName: selectedCityName,
      endCityName: endCityName,
      isSidePanelOpen: isSidePanelOpen,
      isBottomPanelOpen: isBottomPanelOpen,
      startCityName: null,
      path: path,
    );
  }

  State clearEndCity() {
    return State(
      selectedCityName: selectedCityName,
      startCityName: startCityName,
      isSidePanelOpen: isSidePanelOpen,
      isBottomPanelOpen: isBottomPanelOpen,
      endCityName: null,
      path: path,
    );
  }

  @override
  List<Object?> get props => [
        selectedCityName,
        startCityName,
        endCityName,
        isSidePanelOpen,
        isBottomPanelOpen,
        path,
      ];

  @override
  bool get stringify => true;
}
