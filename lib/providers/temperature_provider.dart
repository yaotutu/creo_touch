import 'package:creo_touch/data/websocket/websocket_manager.dart';
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
  bool _isListening = false;

  TemperatureNotifier(this._manager)
      : super(const TemperatureState(
          nozzleTemp: 0,
          bedTemp: 0,
        )) {
    _startListening();
  }

  void _startListening() {
    if (!_isListening) {
      print('[温度Provider] 注册WebSocket监听');
      _manager.addListener(_handleData);
      _isListening = true;

      // 主动查询打印机温度初始状态
      if (_manager.isConnected) {
        print('[温度Provider] 请求初始温度数据');
        _manager.sendMessage({
          "jsonrpc": "2.0",
          "method": "printer.objects.query",
          "params": {
            "objects": {
              "extruder": ["temperature"],
              "heater_bed": ["temperature"]
            }
          },
          "id": 1
        });
      } else {
        print('[温度Provider] WebSocket未连接，暂缓请求');
      }
    }
  }

  void _handleData(dynamic data) {
    try {
      if (data['method'] == 'notify_status_update') {
        final params = data['params'] as List;
        if (params.isNotEmpty) {
          final statusData = params[0] as Map<String, dynamic>;
          _updateTemperature(statusData);
        }
      }
    } catch (e) {
      print('温度数据处理错误: $e');
    }
  }

  void _updateTemperature(Map<String, dynamic> data) {
    final nozzle = (data['extruder']?['temperature'] as num?)?.toDouble();
    final bed = (data['heater_bed']?['temperature'] as num?)?.toDouble();

    if (nozzle != null || bed != null) {
      state = state.copyWith(
        nozzleTemp: nozzle ?? state.nozzleTemp,
        bedTemp: bed ?? state.bedTemp,
      );
    }
  }

  @override
  void dispose() {
    _manager.removeListener(_handleData);
    _isListening = false;
    super.dispose();
  }
}
