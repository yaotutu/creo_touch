import 'package:creo_touch/core/network/network_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'json_rpc_client.dart';

final jsonRpcProvider = Provider<JsonRpcClient>((ref) {
  return JsonRpcClient(ref.read(networkClientProvider));
});
