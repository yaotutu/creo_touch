import 'package:creo_touch/presentation/screens/dashboard_page.dart';
import 'package:creo_touch/presentation/screens/main_page.dart';
import 'package:creo_touch/presentation/screens/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/dashboard',
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return MainPage(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/dashboard',
              pageBuilder: (context, state) => const NoTransitionPage(
                child: DashboardPage(),
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
              pageBuilder: (context, state) => const NoTransitionPage(
                child: SettingsPage(),
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
