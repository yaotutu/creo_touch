import 'dart:async';

import 'package:creo_touch/models/printer_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PrinterNotifier extends StateNotifier<PrinterState> {
  PrinterNotifier() : super(PrinterState.initial()) {
    _initTimer();
  }

  Timer? _timer;

  void _initTimer() {
    var counter = 0;
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      counter++;
      state = PrinterState(
        nozzleTemp: 200 + (counter % 30),
        bedTemp: 60 + (counter % 10),
        progress: (counter % 100).toDouble(),
        status: counter.isEven ? '打印中' : '待机',
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}

final printerProvider = StateNotifierProvider<PrinterNotifier, PrinterState>(
  (ref) => PrinterNotifier(),
);

// 创建选择器provider用于细粒度订阅
final nozzleTempProvider = Provider<double>(
  (ref) => ref.watch(printerProvider.select((state) => state.nozzleTemp)),
);

final bedTempProvider = Provider<double>(
  (ref) => ref.watch(printerProvider.select((state) => state.bedTemp)),
);

final progressProvider = Provider<double>(
  (ref) => ref.watch(printerProvider.select((state) => state.progress)),
);

final statusProvider = Provider<String>(
  (ref) => ref.watch(printerProvider.select((state) => state.status)),
);
