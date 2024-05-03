import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shortest_route_map/data/remote.dart';
import 'package:shortest_route_map/models/path_model.dart';

final repositoryProvider = Provider<Repository>(
  (ref) {
    final remoteDataSource = ref.watch(remoteDataSourceProvider);
    return Repository(remoteDataSource);
  },
);

class Repository {
  final RemoteDataSource remoteDataSource;

  const Repository(this.remoteDataSource);

  // returns a tuple of two lists of integers
  // first list is the path from origin to destination (ids of cities)
  // second list is cost(distance) of each edge in the path
  // from server response is:
  // {
  //   "Amizour": 0,
  //   "EL Kseur centre": 16,
  //   "Sidi Aich": 24,
  //   "Seddouk": 13
  // }
  Future<PathModel> calculatePath({
    required String origin,
    required String destination,
  }) async {
    final response = await remoteDataSource.calculatePath(
      origin: origin,
      destination: destination,
    );


    final path = response.data as Map<String, dynamic>;
    return PathModel.fromMap(path);
  }
}
