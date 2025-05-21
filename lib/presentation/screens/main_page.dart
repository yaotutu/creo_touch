import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

enum MenuItem {
  dashboard('仪表盘', Icons.dashboard),
  analytics('分析', Icons.analytics),
  settings('设置', Icons.settings);

  const MenuItem(this.label, this.icon);
  final String label;
  final IconData icon;
}

class MainPage extends HookWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedItem = useState(MenuItem.dashboard);

    return Scaffold(
      body: Row(
        children: [
          // 左侧菜单栏 - 占1/10宽度
          Container(
            width: MediaQuery.of(context).size.width / 10,
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            child: ListView(
              children: MenuItem.values.map((item) {
                return ListTile(
                  leading: Icon(item.icon, size: 32),
                  title: Text(item.label,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  selected: selectedItem.value == item,
                  selectedTileColor:
                      Theme.of(context).primaryColor.withOpacity(0.2),
                  onTap: () => selectedItem.value = item,
                  dense: false,
                  minVerticalPadding: 24,
                );
              }).toList(),
            ),
          ),

          // 右侧内容区域 - 占4/5宽度
          Expanded(
            child: Center(
              child: _buildContent(selectedItem.value),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(MenuItem item) {
    switch (item) {
      case MenuItem.dashboard:
        return const Text('仪表盘内容');
      case MenuItem.analytics:
        return const Text('分析内容');
      case MenuItem.settings:
        return const Text('设置内容');
    }
  }
}
