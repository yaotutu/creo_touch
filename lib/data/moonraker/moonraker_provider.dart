import 'package:creo_touch/data/moonraker/moonraker_client.dart';
import 'package:creo_touch/data/network/network_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'moonraker_api.dart';

final moonrakerApiProvider = Provider<MoonrakerApi>((ref) {
  return MoonrakerApi(ref.read(moonrakerClientProvider));
});

final moonrakerClientProvider = Provider<MoonrakerClient>((ref) {
  return MoonrakerClient(ref.read(networkClientProvider));
});
