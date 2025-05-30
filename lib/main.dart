import 'package:creo_touch/routes/app_router.dart';
import 'package:creo_touch/themes/app_theme.dart';
import 'package:creo_touch/utils/logger.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() async {
  // 初始化日志模块
  await AppLogger.initialize();

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key}); // 加上 key 参数

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      theme: AppTheme.getTheme(Color(0xFF0051A2)),
    );
  }
}
