import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'widgets/status_card.dart';

class PrinterControlScreen extends HookWidget {
  const PrinterControlScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('打印机控制'),
      ),
      body: Row(
        children: [
          // 左侧面板 - 1/3宽度
          Expanded(
            flex: 1,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: const [
                  StatusCard(
                    icon: Icons.print,
                    primaryText: '准备就绪',
                    secondaryText: '打印机状态',
                  ),
                  StatusCard(
                    icon: Icons.thermostat,
                    primaryText: '25°C',
                    secondaryText: '环境温度',
                  ),
                ],
              ),
            ),
          ),
          // 中间面板 - 1/3宽度
          Expanded(
            flex: 1,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: const [
                  StatusCard(
                    icon: Icons.local_fire_department,
                    primaryText: '200°C',
                    secondaryText: '喷头温度',
                    iconColor: Colors.red,
                  ),
                  StatusCard(
                    icon: Icons.thermostat_outlined,
                    primaryText: '60°C',
                    secondaryText: '热床温度',
                    iconColor: Colors.orange,
                  ),
                ],
              ),
            ),
          ),
          // 右侧面板 - 1/3宽度
          Expanded(
            flex: 1,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: const [
                  StatusCard(
                    icon: Icons.speed,
                    primaryText: '100%',
                    secondaryText: '打印速度',
                  ),
                  StatusCard(
                    icon: Icons.timer,
                    primaryText: '2小时30分',
                    secondaryText: '剩余时间',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
