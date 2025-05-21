import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';

enum MenuItem {
  dashboard('仪表盘', Icons.dashboard),
  analytics('分析', Icons.analytics),
  settings('设置', Icons.settings);

  const MenuItem(this.label, this.icon);
  final String label;
  final IconData icon;
}

class MainPage extends HookWidget {
  final StatefulNavigationShell navigationShell;

  const MainPage({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // 左侧菜单栏 - 占1/10宽度
          Container(
            width: MediaQuery.of(context).size.width / 10,
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            child: ListView(
              children: [
                ListTile(
                  leading: const Icon(Icons.dashboard, size: 32),
                  title: const Text('仪表盘',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  onTap: () => navigationShell.goBranch(0),
                ),
                ListTile(
                  leading: const Icon(Icons.analytics, size: 32),
                  title: const Text('分析',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  onTap: () => navigationShell.goBranch(1),
                ),
                ListTile(
                  leading: const Icon(Icons.settings, size: 32),
                  title: const Text('设置',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  onTap: () => navigationShell.goBranch(2),
                ),
              ],
            ),
          ),
          // 右侧内容区域
          Expanded(
            child: navigationShell,
          ),
        ],
      ),
    );
  }
}
