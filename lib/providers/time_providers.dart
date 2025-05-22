import 'package:hooks_riverpod/hooks_riverpod.dart';

final timeStreamProvider = StreamProvider<String>((ref) {
  return Stream.periodic(const Duration(seconds: 10), (_) {
    return DateTime.now().toIso8601String();
  });
});
