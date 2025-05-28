import 'package:flutter/material.dart';

class PrinterControlScreen extends StatelessWidget {
  const PrinterControlScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('打印机控制'),
      ),
      body: const Center(
        child: Text('打印机控制页面'),
      ),
    );
  }
}
