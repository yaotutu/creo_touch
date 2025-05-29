import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import './not_printing_screen.dart';
import './printing_screen.dart';

class DashboardScreen extends HookWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: 替换为实际的打印状态提供者
    final isPrinting = useState(false);

    return isPrinting.value
        ? const PrintingScreen()
        : const NotPrintingScreen();
  }
}
