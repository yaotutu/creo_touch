import 'package:creo_touch/core/websocket/websocket_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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

  PrintStatusNotifier(this._manager)
      : super(const PrintStatusState(
          status: '离线',
          progress: 0,
          printDuration: 0,
        )) {
    _manager.registerHandler('print_status', _handleStatusUpdate);
  }

  /// 处理打印状态更新
  ///
  /// 接收来自WebSocket的打印状态数据，更新状态
  /// 数据格式: {
  ///   'state': String,
  ///   'print_duration': double,
  ///   'progress': double (0-100)
  /// }
  void _handleStatusUpdate(dynamic data) {
    try {
      final status = data['state'] as String? ?? state.status;
      final duration =
          (data['print_duration'] as num?)?.toDouble() ?? state.printDuration;
      final progress = (data['progress'] as num?)?.toDouble() ?? state.progress;

      // 仅当状态有变化时才更新
      if (status != state.status ||
          duration != state.printDuration ||
          progress != state.progress) {
        state = state.copyWith(
          status: status,
          printDuration: duration,
          progress: progress,
        );
        print('打印状态更新: $status, 时长=${duration}s, 进度=$progress%'); // 调试日志
      }
    } catch (e) {
      print('打印状态处理错误: $e');
    }
  }

  @override
  void dispose() {
    _manager.unregisterHandler('print_status');
    super.dispose();
  }
}
