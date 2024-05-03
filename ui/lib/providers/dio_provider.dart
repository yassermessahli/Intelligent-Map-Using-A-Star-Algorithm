import 'package:dio/dio.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

final dioProvider = Provider<Dio>(
  (ref) {
    final dio = Dio(
      BaseOptions(
        baseUrl: "http://localhost:8000/",
        receiveDataWhenStatusError: true,
        connectTimeout: 20.seconds,
        receiveTimeout: 20.seconds,
        sendTimeout: 20.seconds,
      ),
    );

    // Logger interceptor
    dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true, // true
        responseHeader: false,
        responseBody: true, // true
        error: true, // true
        compact: true,
        maxWidth: 100,
      ),
    );

    return dio;
  },
);
