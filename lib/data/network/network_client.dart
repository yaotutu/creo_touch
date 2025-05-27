import 'package:creo_touch/utils/logger.dart';
import 'package:dio/dio.dart';

/// 网络请求客户端抽象层
abstract class NetworkClient {
  Future<Map<String, dynamic>> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  });

  Future<Map<String, dynamic>> post(
    String path, {
    Map<String, dynamic>? data,
  });

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
  Future<Map<String, dynamic>> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio.get(
        path,
        queryParameters: queryParameters,
      );
      return response.data as Map<String, dynamic>;
    } on DioException catch (e) {
      _logger.error('GET请求失败: ${e.message}', error: e);
      throw Exception('请求失败: ${e.response?.statusCode}');
    }
  }

  @override
  Future<Map<String, dynamic>> post(
    String path, {
    Map<String, dynamic>? data,
  }) async {
    try {
      final response = await _dio.post(
        path,
        data: data,
      );
      return response.data as Map<String, dynamic>;
    } on DioException catch (e) {
      _logger.error('POST请求失败: ${e.message}', error: e);
      throw Exception('请求失败: ${e.response?.statusCode}');
    }
  }

  @override
  Future<void> close() async {
    _dio.close();
  }
}
