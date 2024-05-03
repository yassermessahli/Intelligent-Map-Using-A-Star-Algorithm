import 'package:latlong2/latlong.dart';
import 'package:shortest_route_map/models/city_model.dart';

abstract class Data {
  static const routesWithDistance = {
    "EL Kseur centre": [
      ("Amizour", 14),
      ("Ilmaten", 16),
      ("Adekkar", 27),
      ("Toudja", 21),
      ("Tifra", 26),
      ("Oued Ghir", 21),
      ("Sidi Aich", 24),
    ],
    "Amizour": [
      ("Barbacha", 17),
      ("EL Kseur centre", 16),
    ],
    "Ilmaten": [
      ("Tifra", 14),
      ("Amizour", 24),
      ("EL Kseur centre", 16),
      ("Adekkar", 20),
    ],
    "Tifra": [
      ("Ilmaten", 19),
      ("Adekkar", 12),
      ("Sidi Aich", 14),
      ("EL Kseur centre", 26),
    ],
    "Adekkar": [
      ("Tifra", 11),
      ("EL Kseur centre", 27),
      ("Ilmaten", 20),
    ],
    "Barbacha": [
      ("Amizour", 17),
    ],
    "Toudja": [
      ("Oued Ghir", 16),
      ("EL Kseur centre", 21),
    ],
    "Oued Ghir": [
      ("Toudja", 14),
      ("EL Kseur centre", 18),
    ],
    "Seddouk": [
      ("Sidi Aich", 13),
    ],
    "Sidi Aich": [
      ("Seddouk", 13),
      ("Tifra", 14),
      ("Ilmaten", 13),
      ("EL Kseur centre", 24),
    ]
  };

  static const citiesNames = [
    "EL Kseur centre",
    "Amizour",
    "Ilmaten",
    "Tifra",
    "Adekkar",
    "Barbacha",
    "Toudja",
    "Oued Ghir",
    "Seddouk",
    "Sidi Aich"
  ];

  static const Map<String, LatLng> citiesCoordinates = {
    'EL Kseur centre': LatLng(36.70701093389901, 4.838150095511627),
    'Amizour': LatLng(36.64395418014552, 4.903987122431135),
    'Ilmaten': LatLng(36.66813118824581, 4.768482859239159),
    'Tifra': LatLng(36.666400844419, 4.697174785132521),
    'Adekkar': LatLng(36.69175879902285, 4.669115025826935),
    'Barbacha': LatLng(36.572139466452185, 4.972872433941499),
    'Toudja': LatLng(36.75376512917291, 4.893119368422495),
    'Oued Ghir': LatLng(36.709294791133246, 4.989026063037125),
    'Seddouk': LatLng(36.54706087199331, 4.687499870021105),
    'Sidi Aich': LatLng(36.609625302606226, 4.691273224293743)
  };

  static List<CityModel> cities = [
    for (var i = 0; i < citiesNames.length; i++)
      CityModel(
        name: citiesNames[i],
        location: citiesCoordinates[citiesNames[i]]!,
        imagePath: "assets/images/${citiesNames[i]}.png",
        desciption: "Description of ${citiesNames[i]}",
      ),
  ];

  /// each route is a list of points between two cities
  /// this is constructed based on the [routesWithDistance]
  /// if a route is found between city1 and city2, do not add a route between city2 and city1
  static List<List<LatLng>> listOfRoutes() {
    final List<List<LatLng>> routes = [];
    for (var i = 0; i < citiesNames.length; i++) {
      for (var j = 0; j < citiesNames.length; j++) {
        if (i == j) continue;
        //  if a route is found between city1 and city2, do not add a route between city2 and city1
        final iCityCoordinates = citiesCoordinates[citiesNames[i]]!;
        final jCityCoordinates = citiesCoordinates[citiesNames[j]]!;
        final route = [iCityCoordinates, jCityCoordinates];

        if (routes.any((r) =>
            r.contains(iCityCoordinates) && r.contains(jCityCoordinates))) {
          continue;
        }

        if (routesWithDistance[citiesNames[i]]!
            .any((element) => element.$1 == citiesNames[j])) {
          routes.add(route);
        }
      }
    }
    return routes;
  }
}
