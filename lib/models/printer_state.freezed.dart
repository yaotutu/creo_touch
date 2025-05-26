// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'printer_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PrinterState {
  double get nozzleTemp;
  double get bedTemp;
  double get progress;
  String get status;

  /// Create a copy of PrinterState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $PrinterStateCopyWith<PrinterState> get copyWith =>
      _$PrinterStateCopyWithImpl<PrinterState>(
          this as PrinterState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is PrinterState &&
            (identical(other.nozzleTemp, nozzleTemp) ||
                other.nozzleTemp == nozzleTemp) &&
            (identical(other.bedTemp, bedTemp) || other.bedTemp == bedTemp) &&
            (identical(other.progress, progress) ||
                other.progress == progress) &&
            (identical(other.status, status) || other.status == status));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, nozzleTemp, bedTemp, progress, status);

  @override
  String toString() {
    return 'PrinterState(nozzleTemp: $nozzleTemp, bedTemp: $bedTemp, progress: $progress, status: $status)';
  }
}

/// @nodoc
abstract mixin class $PrinterStateCopyWith<$Res> {
  factory $PrinterStateCopyWith(
          PrinterState value, $Res Function(PrinterState) _then) =
      _$PrinterStateCopyWithImpl;
  @useResult
  $Res call(
      {double nozzleTemp, double bedTemp, double progress, String status});
}

/// @nodoc
class _$PrinterStateCopyWithImpl<$Res> implements $PrinterStateCopyWith<$Res> {
  _$PrinterStateCopyWithImpl(this._self, this._then);

  final PrinterState _self;
  final $Res Function(PrinterState) _then;

  /// Create a copy of PrinterState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? nozzleTemp = null,
    Object? bedTemp = null,
    Object? progress = null,
    Object? status = null,
  }) {
    return _then(_self.copyWith(
      nozzleTemp: null == nozzleTemp
          ? _self.nozzleTemp
          : nozzleTemp // ignore: cast_nullable_to_non_nullable
              as double,
      bedTemp: null == bedTemp
          ? _self.bedTemp
          : bedTemp // ignore: cast_nullable_to_non_nullable
              as double,
      progress: null == progress
          ? _self.progress
          : progress // ignore: cast_nullable_to_non_nullable
              as double,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _PrinterState implements PrinterState {
  const _PrinterState(
      {required this.nozzleTemp,
      required this.bedTemp,
      required this.progress,
      required this.status});

  @override
  final double nozzleTemp;
  @override
  final double bedTemp;
  @override
  final double progress;
  @override
  final String status;

  /// Create a copy of PrinterState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$PrinterStateCopyWith<_PrinterState> get copyWith =>
      __$PrinterStateCopyWithImpl<_PrinterState>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _PrinterState &&
            (identical(other.nozzleTemp, nozzleTemp) ||
                other.nozzleTemp == nozzleTemp) &&
            (identical(other.bedTemp, bedTemp) || other.bedTemp == bedTemp) &&
            (identical(other.progress, progress) ||
                other.progress == progress) &&
            (identical(other.status, status) || other.status == status));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, nozzleTemp, bedTemp, progress, status);

  @override
  String toString() {
    return 'PrinterState(nozzleTemp: $nozzleTemp, bedTemp: $bedTemp, progress: $progress, status: $status)';
  }
}

/// @nodoc
abstract mixin class _$PrinterStateCopyWith<$Res>
    implements $PrinterStateCopyWith<$Res> {
  factory _$PrinterStateCopyWith(
          _PrinterState value, $Res Function(_PrinterState) _then) =
      __$PrinterStateCopyWithImpl;
  @override
  @useResult
  $Res call(
      {double nozzleTemp, double bedTemp, double progress, String status});
}

/// @nodoc
class __$PrinterStateCopyWithImpl<$Res>
    implements _$PrinterStateCopyWith<$Res> {
  __$PrinterStateCopyWithImpl(this._self, this._then);

  final _PrinterState _self;
  final $Res Function(_PrinterState) _then;

  /// Create a copy of PrinterState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? nozzleTemp = null,
    Object? bedTemp = null,
    Object? progress = null,
    Object? status = null,
  }) {
    return _then(_PrinterState(
      nozzleTemp: null == nozzleTemp
          ? _self.nozzleTemp
          : nozzleTemp // ignore: cast_nullable_to_non_nullable
              as double,
      bedTemp: null == bedTemp
          ? _self.bedTemp
          : bedTemp // ignore: cast_nullable_to_non_nullable
              as double,
      progress: null == progress
          ? _self.progress
          : progress // ignore: cast_nullable_to_non_nullable
              as double,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
