import 'package:creo_touch/utils/logger.dart';
import 'package:dio/dio.dart';

/// 网络请求客户端抽象层
abstract class NetworkClient {
  /// 通用请求方法
  Future<Map<String, dynamic>> request(
    String path, {
    String method = 'GET',
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
  });

  /// GET请求快捷方式
  Future<Map<String, dynamic>> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) =>
      request(path, method: 'GET', queryParameters: queryParameters);

  /// POST请求快捷方式
  Future<Map<String, dynamic>> post(
    String path, {
    Map<String, dynamic>? data,
  }) =>
      request(path, method: 'POST', data: data);

  Future<void> close();
}

/// Dio实现的网络客户端
class DioNetworkClient implements NetworkClient {
  static final LoggerModule _logger = AppLogger.module('DioNetworkClient');
  final Dio _dio;

  DioNetworkClient(String baseUrl) : _dio = Dio() {
    _dio.options.baseUrl = baseUrl;
    _dio.options.connectTimeout = const Duration(seconds: 5);
    _dio.options.receiveTimeout = const Duration(seconds: 10);
    _dio.options.headers = {'Content-Type': 'application/json'};
  }

  @override
  Future<Map<String, dynamic>> request(
    String path, {
    String method = 'GET',
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio.request(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(method: method),
      );
      return response.data as Map<String, dynamic>;
    } on DioException catch (e) {
      _logger.error('$method 请求失败: ${e.message}', error: e);
      throw Exception('请求失败: ${e.response?.statusCode}');
    }
  }

  @override
  Future<Map<String, dynamic>> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) =>
      request(path, method: 'GET', queryParameters: queryParameters);

  @override
  Future<Map<String, dynamic>> post(
    String path, {
    Map<String, dynamic>? data,
  }) =>
      request(path, method: 'POST', data: data);

  @override
  Future<void> close() async {
    _dio.close();
  }
}
