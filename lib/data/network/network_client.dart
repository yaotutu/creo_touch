import 'package:creo_touch/utils/logger.dart';
import 'package:dio/dio.dart';

/// HTTP 请求方法枚举
enum HttpMethod {
  get('GET'),
  post('POST');

  final String value;
  const HttpMethod(this.value);
}

/// 网络请求客户端抽象层
abstract class NetworkClient {
  /// 通用请求方法
  Future<Map<String, dynamic>> request(
    String path, {
    HttpMethod method = HttpMethod.get,
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
  });

  /// GET请求快捷方式
  Future<Map<String, dynamic>> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) =>
      request(path, method: HttpMethod.get, queryParameters: queryParameters);

  /// POST请求快捷方式
  Future<Map<String, dynamic>> post(
    String path, {
    Map<String, dynamic>? data,
  }) =>
      request(path, method: HttpMethod.post, data: data);

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
    HttpMethod method = HttpMethod.get,
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio.request(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(method: method.value),
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
      request(path, method: HttpMethod.get, queryParameters: queryParameters);

  @override
  Future<Map<String, dynamic>> post(
    String path, {
    Map<String, dynamic>? data,
  }) =>
      request(path, method: HttpMethod.post, data: data);

  @override
  Future<void> close() async {
    _dio.close();
  }
}
