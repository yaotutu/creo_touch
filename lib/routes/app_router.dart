import 'package:creo_touch/presentation/pages/dashboard_page/screen.dart';
import 'package:creo_touch/presentation/pages/main_page/screen.dart';
import 'package:creo_touch/presentation/pages/settings_page/screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/print', // 默认选中打印控制页面
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return Main(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/dashboard',
              pageBuilder: (context, state) => NoTransitionPage(
                child: Dashboard(),
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
              path: '/print',
              pageBuilder: (context, state) => const NoTransitionPage(
                child: Placeholder(), // TODO: 替换为实际PrintPage
              ),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/settings',
              pageBuilder: (context, state) => NoTransitionPage(
                child: Settings(),
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
