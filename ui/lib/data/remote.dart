import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shortest_route_map/providers/dio_provider.dart';

final remoteDataSourceProvider = Provider<RemoteDataSource>(
  (ref) {
    final dio = ref.watch(dioProvider);
    return RemoteDataSource(dio);
  },
);

class RemoteDataSource {
  final Dio dio;

  const RemoteDataSource(this.dio);

  Future<Response> calculatePath({
    required String origin,
    required String destination,
  }) async {
    return dio.post(
      'calculate_path/',
      data: {
        'city1': origin,
        'city2': destination,
      },
    );
  }
}
