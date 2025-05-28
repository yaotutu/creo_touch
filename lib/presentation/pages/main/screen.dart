import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';

enum MenuItem {
  dashboard('', Icons.dashboard),
  file('', Icons.insert_drive_file),
  control('', Icons.print),
  settings('', Icons.settings),
  monitor('', Icons.monitor);

  const MenuItem(this.label, this.icon);
  final String label;
  final IconData icon;
}

class SquareIconButton extends StatelessWidget {
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const SquareIconButton({
    super.key,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return InkWell(
      splashColor: Theme.of(context)
          .colorScheme
          .primary
          .withAlpha(51), // 0.2 opacity ≈ 51 alpha
      highlightColor: Theme.of(context)
          .colorScheme
          .primary
          .withAlpha(26), // 0.1 opacity ≈ 26 alpha
      borderRadius: BorderRadius.circular(8),
      onTap: onTap,
      child: Container(
        width: screenHeight / 5,
        height: screenHeight / 5,
        decoration: BoxDecoration(
          color: isSelected
              ? Theme.of(context).colorScheme.primaryContainer
              : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          icon,
          size: 48,
          color: Theme.of(context).colorScheme.onSurface,
        ),
      ),
    );
  }
}

class MainScreen extends HookWidget {
  final StatefulNavigationShell navigationShell;

  const MainScreen({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    // 直接使用 navigationShell 管理的当前索引
    final currentIndex = navigationShell.currentIndex;

    return Scaffold(
      body: Row(
        children: [
          // 自适应宽度菜单栏
          IntrinsicWidth(
            child: Container(
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              child: Column(
                children: [
                  for (var item in MenuItem.values)
                    SquareIconButton(
                      icon: item.icon,
                      isSelected: currentIndex == item.index,
                      onTap: () => navigationShell.goBranch(item.index),
                    ),
                ],
              ),
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
