import 'package:creo_touch/core/json_rpc/json_rpc_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'moonraker_api.dart';

final moonrakerApiProvider = Provider<MoonrakerApi>((ref) {
  return MoonrakerApi(ref.read(jsonRpcProvider));
});
