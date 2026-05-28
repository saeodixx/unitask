import 'package:flutter/material.dart';

enum Priority { low, med, high }

extension PriorityExtension on Priority {
  Color get primary => switch (this) {
    Priority.low => Colors.green,
    Priority.med => Colors.amber,
    Priority.high => Colors.red,
  };
  Color get secondary => switch (this) {
    Priority.low => Color(0xFFDCFCE7),
    Priority.med => Color(0xFFFEF3C7),
    Priority.high => Color(0xFFFEE2E2),
  };

  String get title => switch (this) {
    Priority.low => '낮음',
    Priority.med => '보통',
    Priority.high => '높음',
  };
}
