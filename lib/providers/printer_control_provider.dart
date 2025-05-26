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

  PrinterControlNotifier(this._manager)
      : super(const PrinterControlState(
          isPaused: false,
          isPrinting: false,
        )) {
    _manager.registerHandler('print_status', _handleControlUpdate);
  }

  void _handleControlUpdate(dynamic data) {
    final status = data['state'] as String?;

    state = state.copyWith(
      isPaused: status == 'paused',
      isPrinting: status == 'printing',
    );
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
    _manager.unregisterHandler('print_status');
    super.dispose();
  }
}
