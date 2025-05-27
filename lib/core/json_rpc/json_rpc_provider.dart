import 'package:creo_touch/core/config.dart';
import 'package:creo_touch/core/network/network_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'json_rpc_client.dart';

final networkClientProvider = Provider<NetworkClient>((ref) {
  return DioNetworkClient(AppConfig.baseUrl);
});

final jsonRpcProvider = Provider<JsonRpcClient>((ref) {
  return JsonRpcClient(ref.read(networkClientProvider));
});
