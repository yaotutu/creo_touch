import 'package:creo_touch/core/websocket/websocket_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final temperatureProvider =
    StateNotifierProvider<TemperatureNotifier, TemperatureState>((ref) {
  final manager = ref.watch(websocketManagerProvider);
  return TemperatureNotifier(manager);
});

class TemperatureState {
  final double nozzleTemp;
  final double bedTemp;

  const TemperatureState({
    required this.nozzleTemp,
    required this.bedTemp,
  });

  TemperatureState copyWith({
    double? nozzleTemp,
    double? bedTemp,
  }) {
    return TemperatureState(
      nozzleTemp: nozzleTemp ?? this.nozzleTemp,
      bedTemp: bedTemp ?? this.bedTemp,
    );
  }
}

class TemperatureNotifier extends StateNotifier<TemperatureState> {
  final WebSocketManager _manager;

  TemperatureNotifier(this._manager)
      : super(const TemperatureState(
          nozzleTemp: 0,
          bedTemp: 0,
        )) {
    _manager.registerHandler('temperature', _handleTemperatureUpdate);
  }

  /// 处理温度数据更新
  ///
  /// 接收来自WebSocket的温度数据，更新状态
  /// 数据格式: {'nozzle': double, 'bed': double}
  void _handleTemperatureUpdate(dynamic data) {
    try {
      final nozzle = (data['nozzle'] as num?)?.toDouble() ?? state.nozzleTemp;
      final bed = (data['bed'] as num?)?.toDouble() ?? state.bedTemp;

      // 仅当温度有变化时才更新状态
      if (nozzle != state.nozzleTemp || bed != state.bedTemp) {
        state = state.copyWith(
          nozzleTemp: nozzle,
          bedTemp: bed,
        );
        print('温度更新: 喷嘴=$nozzle°C, 热床=$bed°C'); // 调试日志
      }
    } catch (e) {
      print('温度数据处理错误: $e');
    }
  }

  @override
  void dispose() {
    _manager.unregisterHandler('temperature');
    super.dispose();
  }
}
