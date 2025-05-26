import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/printer_state.dart';

final printerProvider = StreamProvider.autoDispose<PrinterState>((ref) {
  final controller = StreamController<PrinterState>();
  var counter = 0;

  Timer? timer;
  timer = Timer.periodic(const Duration(seconds: 1), (_) {
    counter++;
    final state = PrinterState(
      nozzleTemp: 200 + (counter % 30),
      bedTemp: 60 + (counter % 10),
      progress: (counter % 100).toDouble(),
      status: counter.isEven ? '打印中' : '待机',
    );
    controller.add(state);
  });

  ref.onDispose(() {
    controller.close();
    timer?.cancel();
  });

  return controller.stream;
});
