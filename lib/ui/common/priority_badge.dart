import 'package:flutter/material.dart';
import 'package:unitask/app/theme/preview.dart' show AppThemePreview;
import 'package:unitask/core/enum/priority.dart';

@AppThemePreview(group: 'Badges', name: '우선순위')
Widget priorityBadgePreview() => Wrap(
  spacing: 10,
  runSpacing: 10,
  children: [
    PriorityBadge(priority: Priority.low),
    PriorityBadge(priority: Priority.medium),
    PriorityBadge(priority: Priority.high),
  ],
);

class PriorityBadge extends StatelessWidget {
  final Priority priority;

  const PriorityBadge({super.key, required this.priority});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: priority.secondary,
        borderRadius: BorderRadius.circular(50),
      ),
      child: Row(
        spacing: 10,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: priority.primary,
              shape: BoxShape.circle,
            ),
          ),
          Text(
            priority.title,
            style: TextStyle(
              fontWeight: .w700,
              fontSize: 12,
              color: priority.primary,
            ),
          ),
        ],
      ),
    );
  }
}
