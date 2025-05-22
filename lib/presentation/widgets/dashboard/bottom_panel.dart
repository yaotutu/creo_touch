import 'package:flutter/material.dart';

class BottomPanel extends StatelessWidget {
  const BottomPanel({super.key});

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
      child: const Center(
          child: Text("下区", style: TextStyle(color: Colors.white))),
    );
  }
}
