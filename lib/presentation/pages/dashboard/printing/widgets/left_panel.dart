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
          // 顶部区域
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                children: [
                  // 录像状态图标
                  Icon(
                    Icons.videocam,
                    color: Theme.of(context).colorScheme.primary,
                    size: 32,
                  ),
                  // 打印图像标题
                  const Expanded(
                    child: Center(
                      child: Text(
                        '打印预览',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  // 文件按钮
                  IconButton(
                    icon: const Icon(Icons.folder, size: 32),
                    onPressed: () {
                      // TODO: 实现跳转到文件列表
                    },
                  ),
                ],
              ),
            ),
          ),
          // 中间区域 - 打印预览图像
          Expanded(
            flex: 8,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Theme.of(context).colorScheme.outlineVariant,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(
                  child: Icon(Icons.image, size: 100),
                ),
              ),
            ),
          ),
          // 底部区域 - 文件名
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Center(
                child: Text(
                  'current_print.gcode',
                  style: Theme.of(context).textTheme.bodyLarge,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
