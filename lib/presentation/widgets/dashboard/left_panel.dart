import 'package:flutter/material.dart';

class LeftPanel extends StatelessWidget {
  const LeftPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(
          color: Theme.of(context).colorScheme.outline,
          width: 1,
        ),
      ),
      child: Column(
        children: [
          // 顶部 1/10
          Expanded(
            flex: 1,
            child: const ColoredBox(
              color: Colors.red,
              child: Center(child: Text("顶部区域")),
            ),
          ),
          // 中间区域
          Expanded(
            flex: 8,
            child: const ColoredBox(
              color: Colors.green,
              child: Center(child: Text("中间区域")),
            ),
          ),
          // 底部 1/10
          Expanded(
            flex: 1,
            child: const ColoredBox(
              color: Colors.blue,
              child: Center(child: Text("底部区域")),
            ),
          ),
        ],
      ),
    );
  }
}
