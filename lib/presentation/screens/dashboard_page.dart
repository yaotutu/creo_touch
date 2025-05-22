import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

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
                    child: Card(
                      shape: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.outline,
                          width: 1,
                        ),
                      ),
                      child: Center(
                          child: Text(
                        "左区",
                        style: Theme.of(context).textTheme.displayLarge,
                      )),
                    ),
                  ),
                  // 右侧区域 (6/10宽度)
                  Expanded(
                    flex: 6,
                    child: Card(
                      shape: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.outline,
                          width: 1,
                        ),
                      ),
                      child: const Center(
                          child: Text("右区",
                              style: TextStyle(color: Colors.white))),
                    ),
                  ),
                ],
              ),
            ),
            // 下方区域 (3/10高度)
            Expanded(
              flex: 3,
              child: Card(
                shape: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.outline,
                    width: 1,
                  ),
                ),
                child: const Center(
                    child: Text("下区", style: TextStyle(color: Colors.white))),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
