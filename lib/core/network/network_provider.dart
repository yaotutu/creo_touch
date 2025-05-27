import 'package:creo_touch/core/config.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'network_client.dart';

final networkClientProvider = Provider<NetworkClient>((ref) {
  return DioNetworkClient(AppConfig.baseUrl);
});
