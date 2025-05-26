import 'package:flutter/foundation.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

/// 日志级别枚举
enum LogLevel {
  debug, // 调试信息
  info, // 常规信息
  warning, // 警告
  error, // 错误
  fatal, // 致命错误
  none, // 不输出任何日志
}

/// 日志工具类 - 基于logger包封装
class AppLogger {
  static LogLevel _logLevel = kReleaseMode ? LogLevel.warning : LogLevel.debug;

  /// 设置全局日志级别
  static void setLogLevel(LogLevel level) {
    _logLevel = level;
  }

  /// 创建模块日志实例
  static LoggerModule module(String name) {
    return LoggerModule._(name);
  }

  /// 初始化日期格式化
  static Future<void> initialize() async {
    await initializeDateFormatting('zh_CN', null);
  }

  /// 获取当前中国时区时间
  static String _getChinaTime() {
    final now = DateTime.now().toUtc().add(const Duration(hours: 8));
    return DateFormat('yyyy-MM-dd HH:mm:ss', 'zh_CN').format(now);
  }

  /// 检查是否应该记录日志
  static bool _shouldLog(LogLevel level) {
    return level.index >= _logLevel.index;
  }
}

/// 模块日志类
class LoggerModule {
  final String name;
  final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 0,
      errorMethodCount: 3,
      lineLength: 120,
      colors: true,
      printEmojis: true,
      printTime: false,
      noBoxingByDefault: true,
    ),
    level: Level.verbose, // 最详细级别，由AppLogger._shouldLog控制实际输出
  );

  LoggerModule._(this.name);

  /// 调试日志
  void debug(String message) {
    if (AppLogger._shouldLog(LogLevel.debug)) {
      _logger.d('${AppLogger._getChinaTime()} [$name] [DEBUG] $message');
    }
  }

  /// 信息日志
  void info(String message) {
    if (AppLogger._shouldLog(LogLevel.info)) {
      _logger.i('${AppLogger._getChinaTime()} [$name] [INFO] $message');
    }
  }

  /// 警告日志
  void warning(String message) {
    if (AppLogger._shouldLog(LogLevel.warning)) {
      _logger.w('${AppLogger._getChinaTime()} [$name] [WARN] $message');
    }
  }

  /// 错误日志
  void error(String message, {dynamic error, StackTrace? stackTrace}) {
    if (AppLogger._shouldLog(LogLevel.error)) {
      final errorMsg = error != null ? '$message - $error' : message;
      _logger.e('${AppLogger._getChinaTime()} [$name] [ERROR] $errorMsg',
          error: error, stackTrace: stackTrace);
    }
  }

  /// 致命错误日志
  void fatal(String message, {dynamic error, StackTrace? stackTrace}) {
    if (AppLogger._shouldLog(LogLevel.fatal)) {
      final errorMsg = error != null ? '$message - $error' : message;
      _logger.f('${AppLogger._getChinaTime()} [$name] [FATAL] $errorMsg',
          error: error, stackTrace: stackTrace);
    }
  }
}
