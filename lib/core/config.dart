import 'package:creo_touch/utils/logger.dart';
import 'package:flutter/foundation.dart';

/// 全局应用配置
class AppConfig {
  static String _baseUrl = 'ws://192.168.201.124:7125/websocket';
  static LogLevel _logLevel = kReleaseMode ? LogLevel.warning : LogLevel.debug;

  /// 获取基础URL
  static String get baseUrl => _baseUrl;

  /// 设置基础URL
  static void setBaseUrl(String url) {
    _baseUrl = url;
  }

  /// 获取当前日志级别
  static LogLevel get logLevel => _logLevel;

  /// 设置日志级别
  static void setLogLevel(LogLevel level) {
    _logLevel = level;
    AppLogger.setLogLevel(level);
  }

  /// 初始化配置 (可异步加载配置)
  static Future<void> initialize() async {
    // TODO: 可从本地存储或网络加载配置
    AppLogger.setLogLevel(_logLevel);
  }
}
