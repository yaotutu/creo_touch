import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

final websocketManagerProvider = Provider<WebSocketManager>((ref) {
  return WebSocketManager('ws://192.168.201.124:7125/websocket');
});

class WebSocketManager {
  final String _url;
  late WebSocketChannel _channel;
  final Map<String, Function(dynamic)> _handlers = {};

  WebSocketManager(this._url) {
    _initConnection();
  }

  void _initConnection() {
    _channel = WebSocketChannel.connect(Uri.parse(_url));
    _channel.stream.listen(_handleMessage, onError: _handleError);
  }

  /// 处理WebSocket接收到的消息
  ///
  /// 解析JSON格式的消息，根据method字段分发到不同处理器
  /// 目前主要处理notify_status_update类型的消息
  void _handleMessage(dynamic message) {
    try {
      final json = jsonDecode(message);
      final method = json['method'] as String?;

      if (method == 'notify_status_update') {
        final params = json['params'] as List;
        if (params.isNotEmpty) {
          final data = params[0] as Map<String, dynamic>;
          _dispatchData(data);
          // 打印处理后的数据
          print('Processed data: $data');
        }
      }
    } catch (e) {
      print('WebSocket message parse error: $e');
    }
  }

  /// 分发处理后的数据到各个处理器
  ///
  /// 根据数据字段判断数据类型，并调用对应的处理器
  /// 支持温度数据、打印状态和运动数据的处理
  void _dispatchData(Map<String, dynamic> data) {
    try {
      // 分发温度数据
      if (data.containsKey('extruder') || data.containsKey('heater_bed')) {
        final temperatureData = {
          'nozzle': data['extruder']?['temperature'] ?? 0.0,
          'bed': data['heater_bed']?['temperature'] ?? 0.0,
        };
        _callHandler('temperature', temperatureData);
      }

      // 分发打印状态数据
      if (data.containsKey('print_stats')) {
        final stats = data['print_stats'];
        _callHandler('print_status', {
          'state': stats['state'] ?? '离线',
          'print_duration': stats['print_duration'] ?? 0.0,
          'progress': (stats['progress'] ?? 0.0) * 100, // 转换为百分比
        });
      }

      // 分发运动数据
      if (data.containsKey('motion_report')) {
        _callHandler('motion', data['motion_report']);
      }
    } catch (e) {
      print('WebSocket data dispatch error: $e');
    }
  }

  void _callHandler(String type, dynamic data) {
    if (_handlers.containsKey(type)) {
      _handlers[type]!(data);
    }
  }

  void registerHandler(String type, Function(dynamic) handler) {
    _handlers[type] = handler;
  }

  void unregisterHandler(String type) {
    _handlers.remove(type);
  }

  void _handleError(dynamic error) {
    print('WebSocket error: $error');
  }

  Future<void> close() async {
    await _channel.sink.close();
  }
}
