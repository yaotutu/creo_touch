import 'package:creo_touch/providers/time_providers.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class RightPanel extends HookConsumerWidget {
  const RightPanel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncTime = ref.watch(timeStreamProvider);

    return Card(
      shape: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(
          color: Theme.of(context).colorScheme.outline,
          width: 1,
        ),
      ),
      child: Center(
        child: asyncTime.when(
          data: (time) => Text('当前时间：$time'),
          loading: () => const CircularProgressIndicator(),
          error: (e, _) => Text('错误: $e'),
        ),
      ),
    );
  }
}
