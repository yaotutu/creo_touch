import 'package:creo_touch/data/moonraker/moonraker_client.dart';
import 'package:creo_touch/data/network/network_client.dart';

/// Moonraker API 业务封装
class MoonrakerApi {
  final MoonrakerClient _client;

  MoonrakerApi(this._client);

  /// 获取服务器信息
  Future<Map<String, dynamic>> getServerInfo() async {
    return _client.sendRequest(
      path: '/server/info',
      method: 'server.info',
      httpMethod: HttpMethod.get,
    );
  }

  /// 获取打印机状态
  Future<Map<String, dynamic>> getPrinterStatus() async {
    return _client.sendRequest(
      path: '/printer/objects/query',
      method: 'printer.objects.query',
      httpMethod: HttpMethod.post,
      params: {
        'objects': {'print_stats': null, 'toolhead': null}
      },
    );
  }

  /// 发送GCode指令
  Future<Map<String, dynamic>> sendGCode(String gcode) async {
    return _client.sendRequest(
      path: '/printer/gcode/script',
      method: 'printer.gcode.script',
      httpMethod: HttpMethod.post,
      params: {'script': gcode},
    );
  }

  /// 获取温度数据
  Future<Map<String, dynamic>> getTemperature() async {
    return _client.sendRequest(
      path: '/printer/objects/query',
      method: 'printer.objects.query',
      httpMethod: HttpMethod.post,
      params: {
        'objects': {'heater_bed': null, 'extruder': null}
      },
    );
  }
}
