import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

/// 日志工具类 - 基于logger包封装
/// 使用中国时区时间(UTC+8)
class AppLogger {
  static final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 0,
      errorMethodCount: 3,
      lineLength: 120,
      colors: true,
      printEmojis: true,
      printTime: false, // 禁用默认的时间打印
      noBoxingByDefault: true, // 禁用边框
    ),
  );

  /// 初始化日期格式化
  static Future<void> initialize() async {
    await initializeDateFormatting('zh_CN', null);
  }

  /// 获取当前中国时区时间
  static String _getChinaTime() {
    final now = DateTime.now().toUtc().add(const Duration(hours: 8));
    return DateFormat('yyyy-MM-dd HH:mm:ss', 'zh_CN').format(now);
  }

  /// 调试日志
  static void debug(String message) {
    _logger.d('${_getChinaTime()} [DEBUG] $message');
  }

  /// 信息日志
  static void info(String message) {
    _logger.i('${_getChinaTime()} [INFO] $message');
  }

  /// 警告日志
  static void warning(String message) {
    _logger.w('${_getChinaTime()} [WARN] $message');
  }

  /// 错误日志
  static void error(String message, [dynamic error, StackTrace? stackTrace]) {
    final errorMsg = error != null ? '$message - $error' : message;
    _logger.e('${_getChinaTime()} [ERROR] $errorMsg',
        error: error, stackTrace: stackTrace);
  }

  /// 致命错误日志
  static void fatal(String message, [dynamic error, StackTrace? stackTrace]) {
    final errorMsg = error != null ? '$message - $error' : message;
    _logger.f('${_getChinaTime()} [FATAL] $errorMsg',
        error: error, stackTrace: stackTrace);
  }
}
