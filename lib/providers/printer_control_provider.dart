import 'package:creo_touch/core/websocket/websocket_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final printerControlProvider =
    StateNotifierProvider<PrinterControlNotifier, PrinterControlState>((ref) {
  final manager = ref.watch(websocketManagerProvider);
  return PrinterControlNotifier(manager);
});

class PrinterControlState {
  final bool isPaused;
  final bool isPrinting;

  const PrinterControlState({
    required this.isPaused,
    required this.isPrinting,
  });

  PrinterControlState copyWith({
    bool? isPaused,
    bool? isPrinting,
  }) {
    return PrinterControlState(
      isPaused: isPaused ?? this.isPaused,
      isPrinting: isPrinting ?? this.isPrinting,
    );
  }
}

class PrinterControlNotifier extends StateNotifier<PrinterControlState> {
  final WebSocketManager _manager;
  bool _isListening = false;

  PrinterControlNotifier(this._manager)
      : super(const PrinterControlState(
          isPaused: false,
          isPrinting: false,
        )) {
    _startListening();
  }

  void _startListening() {
    if (!_isListening) {
      _manager.addListener(_handleData);
      _isListening = true;
    }
  }

  void _handleData(dynamic data) {
    try {
      if (data['method'] == 'notify_status_update') {
        final params = data['params'] as List;
        if (params.isNotEmpty) {
          final statusData = params[0] as Map<String, dynamic>;
          _updateControlStatus(statusData);
        }
      }
    } catch (e) {
      print('控制状态处理错误: $e');
    }
  }

  void _updateControlStatus(Map<String, dynamic> data) {
    final stats = data['print_stats'];
    if (stats != null) {
      final status = stats['state'] as String?;
      state = state.copyWith(
        isPaused: status == 'paused',
        isPrinting: status == 'printing',
      );
    }
  }

  Future<void> pausePrint() async {
    // TODO: 实现暂停打印逻辑
    state = state.copyWith(isPaused: true);
  }

  Future<void> resumePrint() async {
    // TODO: 实现恢复打印逻辑
    state = state.copyWith(isPaused: false);
  }

  Future<void> cancelPrint() async {
    // TODO: 实现取消打印逻辑
    state = state.copyWith(isPrinting: false, isPaused: false);
  }

  @override
  void dispose() {
    _manager.removeListener(_handleData);
    _isListening = false;
    super.dispose();
  }
}
