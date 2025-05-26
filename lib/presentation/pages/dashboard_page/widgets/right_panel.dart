import 'package:creo_touch/providers/printer_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class RightPanel extends HookConsumerWidget {
  const RightPanel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncPrinter = ref.watch(printerProvider);

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
        child: asyncPrinter.when(
          data: (state) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildTempRow(context, '喷头温度', '${state.nozzleTemp}°C'),
              const SizedBox(height: 12),
              _buildTempRow(context, '热床温度', '${state.bedTemp}°C'),
              const SizedBox(height: 16),
              LinearProgressIndicator(
                value: state.progress / 100,
                backgroundColor:
                    Theme.of(context).colorScheme.surfaceContainerHighest,
                valueColor: AlwaysStoppedAnimation<Color>(
                  Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '进度: ${state.progress.toStringAsFixed(1)}%',
                style: Theme.of(context).textTheme.labelLarge,
              ),
              const SizedBox(height: 8),
              Chip(
                label: Text(state.status),
                backgroundColor: state.status == '打印中'
                    ? Theme.of(context).colorScheme.primaryContainer
                    : Theme.of(context).colorScheme.surfaceContainerHighest,
              ),
            ],
          ),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) =>
              Text('错误: $e', style: Theme.of(context).textTheme.bodyMedium),
        ),
      ),
    );
  }

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
