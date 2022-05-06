import 'package:dio/dio.dart';
import 'package:github_user_listing_demo/core/network/rest/api_service.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:riverpod/riverpod.dart';

final baseOptions = Provider((ref) {
  return BaseOptions(baseUrl: 'https://api.github.com');
});

final dioProvider = Provider((ref) {
  final dio = Dio(ref.read(baseOptions));
  // dio.interceptors.add(PrettyDioLogger(
  //     requestHeader: true,
  //     requestBody: true,
  //     responseBody: true,
  //     responseHeader: false,
  //     error: true,
  //     compact: true,
  //     maxWidth: 90));
  return dio;
});

final apiServiceProvider = Provider((ref) {
  return ApiService(ref.read(dioProvider));
});
