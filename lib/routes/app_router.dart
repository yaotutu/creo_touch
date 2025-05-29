import 'package:creo_touch/presentation/pages/control/screen.dart';
import 'package:creo_touch/presentation/pages/dashboard/screen.dart';
import 'package:creo_touch/presentation/pages/main/screen.dart';
import 'package:creo_touch/presentation/pages/settings/screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/dashboard', // 默认选中打印机控制页面
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return MainScreen(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/dashboard',
              pageBuilder: (context, state) => NoTransitionPage(
                child: DashboardScreen(),
              ),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/file',
              pageBuilder: (context, state) => const NoTransitionPage(
                child: Placeholder(), // TODO: 替换为实际FilePage
              ),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/control',
              pageBuilder: (context, state) => const NoTransitionPage(
                child: PrinterControlScreen(),
              ),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/settings',
              pageBuilder: (context, state) => NoTransitionPage(
                child: SettingsScreen(),
              ),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/monitor',
              pageBuilder: (context, state) => const NoTransitionPage(
                child: Placeholder(), // TODO: 替换为实际MonitorPage
              ),
            ),
          ],
        ),
      ],
    ),
  ],
);
