import 'package:equatable/equatable.dart';
import 'package:latlong2/latlong.dart';
import 'package:shortest_route_map/data/data.dart';

class PathModel extends Equatable {
  // if this contains n items
  final List<String> cities;

  // this should contain n-1 items
  final List<int> distances;

  int get totalDistance => distances.fold(0, (a, b) => a + b);


  List<LatLng> get coordinates =>
      cities.map((e) => Data.citiesCoordinates[e]!).toList();

  const PathModel({
    required this.cities,
    required this.distances,
  });

  PathModel copyWith({
    List<String>? cities,
    List<int>? distances,
  }) {
    return PathModel(
      cities: cities ?? this.cities,
      distances: distances ?? this.distances,
    );
  }


  factory PathModel.fromMap(Map<String, dynamic> map) {
    final cities = map.keys.toList();
    // do not take the first item in distances
    final distances = map.values
        .map<int>((e) => int.tryParse(e.toString()) ?? 0)
        .skip(1)
        .toList();
    return PathModel(
      cities: cities,
      distances: distances,
    );
  }

  @override
  List<Object?> get props => [cities, distances];

  @override
  bool get stringify => true;
}
