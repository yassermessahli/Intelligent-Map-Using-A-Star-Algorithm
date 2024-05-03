import 'package:equatable/equatable.dart';
import 'package:latlong2/latlong.dart';

class CityModel extends Equatable {
  final String name;
  final LatLng location;
  final String imagePath;
  final String desciption;

  double get latitude => location.latitude;
  double get longitude => location.longitude;


  // 36.7864921,4.7781066 => 36° 47' 11.3716'' N, 4° 46' 41.1826'' E
  String get formattedCoordinates {
    final lat = location.latitude;
    final lon = location.longitude;
    final latDeg = lat.floor();
    final latMin = ((lat - latDeg) * 60).floor();
    final latSec = ((lat - latDeg - latMin / 60) * 3600).floor();
    final lonDeg = lon.floor();
    final lonMin = ((lon - lonDeg) * 60).floor();
    final lonSec = ((lon - lonDeg - lonMin / 60) * 3600).floor();
    return '$latDeg° $latMin\' $latSec\'\' N, $lonDeg° $lonMin\' $lonSec\'\' E';
  }

  const CityModel({
    required this.name,
    required this.location,
    required this.imagePath,
    required this.desciption,
  });

  @override
  List<Object?> get props => [
        name,
        location,
        imagePath,
        desciption,
      ];
}
