import 'package:creo_touch/data/network/network_client.dart';
import 'package:creo_touch/utils/logger.dart';

/// Moonraker JSON-RPC 2.0 客户端
class MoonrakerClient {
  static final LoggerModule _logger = AppLogger.module('MoonrakerClient');
  final NetworkClient _client;
  int _requestId = 0;

  MoonrakerClient(this._client);

  /// 发送JSON-RPC请求
  Future<Map<String, dynamic>> sendRequest({
    required String path,
    required String method,
    required String httpMethod, // 'GET' or 'POST'
    Map<String, dynamic>? params,
    int? id,
  }) async {
    final requestId = id ?? _requestId++;
    final request = {
      'jsonrpc': '2.0',
      'method': method,
      'params': params ?? {},
      'id': requestId,
    };

    try {
      _logger.debug('发送请求: $request');
      final response = await _client.request(
        path,
        method: httpMethod,
        data: httpMethod == 'POST' ? request : null,
      );

      if (httpMethod == 'POST') {
        _validateResponse(response, requestId);
        return response['result'] as Map<String, dynamic>;
      }
      return response;
    } catch (e) {
      _logger.error('Moonraker请求失败', error: e);
      rethrow;
    }
  }

  /// 验证响应
  void _validateResponse(Map<String, dynamic> response, int requestId) {
    if (response['id'] != requestId) {
      throw Exception('响应ID不匹配');
    }

    if (response.containsKey('error')) {
      final error = response['error'] as Map<String, dynamic>;
      throw Exception('RPC错误: ${error['message']} (code: ${error['code']})');
    }

    if (!response.containsKey('result')) {
      throw Exception('无效的响应格式');
    }
  }
}
