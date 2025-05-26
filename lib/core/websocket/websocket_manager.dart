import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

/// WebSocket全局管理类
///
/// 负责维护单一WebSocket连接，将原始数据广播给所有订阅者
/// 各业务模块自行处理自己需要的数据
final websocketManagerProvider = Provider<WebSocketManager>((ref) {
  return WebSocketManager('ws://192.168.201.124:7125/websocket');
});

class WebSocketManager {
  final String _url;
  late WebSocketChannel _channel;
  final List<Function(dynamic)> _listeners = [];
  bool _isConnected = false;

  /// 获取当前连接状态
  bool get isConnected => _isConnected;

  WebSocketManager(this._url) {
    _initConnection();
  }

  /// 初始化WebSocket连接
  void _initConnection() {
    _channel = WebSocketChannel.connect(Uri.parse(_url));
    _channel.stream.listen(
      _handleMessage,
      onError: _handleError,
      onDone: _handleDone,
    );
    _isConnected = true;
    print('WebSocket连接已建立');
  }

  /// 发送消息到WebSocket服务器
  void sendMessage(dynamic message) {
    if (_isConnected) {
      try {
        final jsonStr = jsonEncode(message);
        _channel.sink.add(jsonStr);
      } catch (e) {
        print('WebSocket消息发送错误: $e');
      }
    }
  }

  /// 处理原始消息
  void _handleMessage(dynamic message) {
    try {
      final json = jsonDecode(message);
      print('收到WebSocket消息: ${json['method']}');
      _notifyListeners(json);
    } catch (e) {
      print('WebSocket消息解析错误: $e');
    }
  }

  /// 通知所有监听者
  void _notifyListeners(dynamic data) {
    if (_listeners.isEmpty) {
      print('警告: 没有注册的监听器');
      return;
    }

    for (final listener in _listeners) {
      try {
        listener(data);
      } catch (e) {
        print('监听者处理错误: $e');
      }
    }
  }

  /// 添加数据监听器
  void addListener(Function(dynamic) listener) {
    if (!_listeners.contains(listener)) {
      _listeners.add(listener);
      print('添加新的WebSocket监听器，当前总数: ${_listeners.length}');
    }
  }

  /// 移除数据监听器
  void removeListener(Function(dynamic) listener) {
    _listeners.remove(listener);
    print('移除WebSocket监听器，剩余: ${_listeners.length}');
  }

  /// 错误处理
  void _handleError(dynamic error) {
    print('WebSocket连接错误: $error');
    _isConnected = false;
  }

  /// 连接关闭处理
  void _handleDone() {
    print('WebSocket连接已关闭');
    _isConnected = false;
  }

  /// 关闭连接
  Future<void> close() async {
    await _channel.sink.close();
    _listeners.clear();
    _isConnected = false;
  }
}
