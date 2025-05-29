import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class StatusCard extends HookWidget {
  final IconData icon;
  final String primaryText;
  final String secondaryText;
  final Color? iconColor;

  const StatusCard({
    super.key,
    required this.icon,
    required this.primaryText,
    required this.secondaryText,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Icon(
                icon,
                size: 32,
                color: iconColor ?? Theme.of(context).primaryColor,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      secondaryText,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: Theme.of(context)
                                .colorScheme
                                .onSurface
                                .withOpacity(0.7),
                          ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      primaryText,
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
