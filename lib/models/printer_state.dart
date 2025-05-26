import 'package:freezed_annotation/freezed_annotation.dart';

part 'printer_state.freezed.dart';

@freezed
abstract class PrinterState with _$PrinterState {
  const factory PrinterState({
    required double nozzleTemp,
    required double bedTemp,
    required double progress,
    required String status,
  }) = _PrinterState;

  factory PrinterState.initial() => const PrinterState(
        nozzleTemp: 0,
        bedTemp: 0,
        progress: 0,
        status: '离线',
      );
}
