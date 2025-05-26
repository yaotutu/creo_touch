import 'package:creo_touch/providers/print_status_provider.dart';
import 'package:creo_touch/providers/temperature_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class RightPanel extends HookConsumerWidget {
  const RightPanel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 获取温度状态
    final temperature = ref.watch(temperatureProvider);
    // 获取打印状态
    final printStatus = ref.watch(printStatusProvider);

    return Card(
      shape: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(
          color: Theme.of(context).colorScheme.outline,
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 显示喷头温度
            _buildTempRow(context, '喷头温度',
                '${temperature.nozzleTemp.toStringAsFixed(1)}°C'),
            const SizedBox(height: 12),
            // 显示热床温度
            _buildTempRow(
                context, '热床温度', '${temperature.bedTemp.toStringAsFixed(1)}°C'),
            const SizedBox(height: 16),
            // 打印进度条
            LinearProgressIndicator(
              value: printStatus.progress / 100,
              backgroundColor:
                  Theme.of(context).colorScheme.surfaceContainerHighest,
              valueColor: AlwaysStoppedAnimation<Color>(
                Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(height: 8),
            // 打印进度百分比
            Text(
              '进度: ${printStatus.progress.toStringAsFixed(1)}%',
              style: Theme.of(context).textTheme.labelLarge,
            ),
            const SizedBox(height: 8),
            // 打印机状态标签
            Chip(
              label: Text(printStatus.status),
              backgroundColor: printStatus.status == '打印中'
                  ? Theme.of(context).colorScheme.primaryContainer
                  : Theme.of(context).colorScheme.surfaceContainerHighest,
            ),
            const SizedBox(height: 8),
            // 打印持续时间
            Text(
              '已打印: ${printStatus.printDuration.toStringAsFixed(0)}秒',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }

  /// 构建温度显示行
  Widget _buildTempRow(BuildContext context, String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: Theme.of(context).textTheme.bodyMedium),
        Text(value, style: Theme.of(context).textTheme.bodyLarge),
      ],
    );
  }
}
