import 'package:logger/logger.dart';

/// 日志工具类 - 基于logger包封装
/// 优化为单行输出格式
class AppLogger {
  static final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 0, // 不显示方法调用堆栈
      errorMethodCount: 3, // 错误时显示3层堆栈
      lineLength: 120, // 每行最大长度
      colors: true, // 启用颜色输出
      printEmojis: true, // 启用表情符号
      printTime: true, // 打印时间
      noBoxingByDefault: true, // 禁用默认的边框
    ),
  );

  /// 调试日志 - 单行格式
  static void debug(String message) {
    _logger.d('DEBUG: $message');
  }

  /// 信息日志 - 单行格式
  static void info(String message) {
    _logger.i('INFO: $message');
  }

  /// 警告日志 - 单行格式
  static void warning(String message) {
    _logger.w('WARN: $message');
  }

  /// 错误日志 - 单行格式
  static void error(String message, [dynamic error, StackTrace? stackTrace]) {
    final errorMsg = error != null ? '$message - $error' : message;
    _logger.e('ERROR: $errorMsg', error: error, stackTrace: stackTrace);
  }

  /// 致命错误日志 - 单行格式
  static void fatal(String message, [dynamic error, StackTrace? stackTrace]) {
    final errorMsg = error != null ? '$message - $error' : message;
    _logger.f('FATAL: $errorMsg', error: error, stackTrace: stackTrace);
  }
}
