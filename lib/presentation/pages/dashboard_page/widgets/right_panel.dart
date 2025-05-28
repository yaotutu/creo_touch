import 'package:creo_touch/data/moonraker/moonraker_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class RightPanel extends HookConsumerWidget {
  const RightPanel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final serverInfo = ref.watch(serverInfoProvider);

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
        child: serverInfo.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) => Center(
            child: Text(
              '加载失败: $error',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: Theme.of(context).colorScheme.error),
            ),
          ),
          data: (info) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildInfoRow(
                  context, '服务器版本', info['result']?['software_version']),
              const SizedBox(height: 12),
              _buildInfoRow(
                  context, 'API版本', info['result']?['api_version_string']),
              const SizedBox(height: 12),
              _buildInfoRow(context, '主机名', info['result']?['hostname']),
              const SizedBox(height: 12),
              _buildInfoRow(
                  context, 'CPU架构', info['result']?['cpu_info']?['cpu']),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(BuildContext context, String label, dynamic value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: Theme.of(context).textTheme.bodyMedium),
        Text(
          value?.toString() ?? '未知',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color:
                    value == null ? Theme.of(context).colorScheme.error : null,
              ),
        ),
      ],
    );
  }
}

final serverInfoProvider = FutureProvider<Map<String, dynamic>>((ref) {
  return ref.read(moonrakerApiProvider).getServerInfo();
});
