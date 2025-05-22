import 'package:creo_touch/presentation/pages/dashboard_page/widgets/bottom_panel.dart';
import 'package:creo_touch/presentation/pages/dashboard_page/widgets/left_panel.dart';
import 'package:creo_touch/presentation/pages/dashboard_page/widgets/right_panel.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // 上方区域 (7/10高度)
            Expanded(
              flex: 7,
              child: Row(
                children: [
                  // 左侧区域 (4/10宽度)
                  Expanded(
                    flex: 4,
                    child: const LeftPanel(),
                  ),
                  // 右侧区域 (6/10宽度)
                  Expanded(
                    flex: 6,
                    child: const RightPanel(),
                  ),
                ],
              ),
            ),
            // 下方区域 (3/10高度)
            Expanded(
              flex: 3,
              child: const BottomPanel(),
            ),
          ],
        ),
      ),
    );
  }
}
