import 'package:creo_touch/data/websocket/websocket_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final printStatusProvider =
    StateNotifierProvider<PrintStatusNotifier, PrintStatusState>((ref) {
  final manager = ref.watch(websocketManagerProvider);
  return PrintStatusNotifier(manager);
});

class PrintStatusState {
  final String status;
  final double progress;
  final double printDuration;

  const PrintStatusState({
    required this.status,
    required this.progress,
    required this.printDuration,
  });

  PrintStatusState copyWith({
    String? status,
    double? progress,
    double? printDuration,
  }) {
    return PrintStatusState(
      status: status ?? this.status,
      progress: progress ?? this.progress,
      printDuration: printDuration ?? this.printDuration,
    );
  }
}

class PrintStatusNotifier extends StateNotifier<PrintStatusState> {
  final WebSocketManager _manager;
  bool _isListening = false;

  PrintStatusNotifier(this._manager)
      : super(const PrintStatusState(
          status: '离线',
          progress: 0,
          printDuration: 0,
        )) {
    _startListening();
  }

  void _startListening() {
    if (!_isListening) {
      debugPrint('[打印状态Provider] 注册WebSocket监听');
      _manager.addListener(_handleData);
      _isListening = true;

      if (_manager.isConnected) {
        debugPrint('[打印状态Provider] 请求初始状态数据');
        _manager.sendMessage({
          "jsonrpc": "2.0",
          "method": "printer.objects.query",
          "params": {
            "objects": {
              "print_stats": ["state", "print_duration", "progress"]
            }
          },
          "id": 2
        });
      } else {
        debugPrint('[打印状态Provider] WebSocket未连接，暂缓请求');
      }
    }
  }

  void _handleData(dynamic data) {
    try {
      if (data['method'] == 'notify_status_update') {
        final params = data['params'] as List;
        if (params.isNotEmpty) {
          final statusData = params[0] as Map<String, dynamic>;
          _updateStatus(statusData);
        }
      }
    } catch (e) {
      debugPrint('打印状态处理错误: $e');
    }
  }

  void _updateStatus(Map<String, dynamic> data) {
    final stats = data['print_stats'];
    if (stats != null) {
      state = state.copyWith(
        status: stats['state'] ?? state.status,
        printDuration: (stats['print_duration'] as num?)?.toDouble() ??
            state.printDuration,
        progress: ((stats['progress'] as num?)?.toDouble() ?? 0) * 100,
      );
    }
  }

  @override
  void dispose() {
    if (_isListening) {
      _manager.removeListener(_handleData);
      _isListening = false;
    }
    super.dispose();
  }
}
