import 'package:flutter/material.dart';
import 'package:unitask/app/theme/preview.dart';

@AppThemePreview(group: 'Buttons', name: 'SelectableChip')
Widget preview() {
  return Wrap(
    spacing: 10,
    runSpacing: 10,
    children: [
      SelectableChip(onTap: () {}, name: '전체', selected: true),
      SelectableChip(onTap: () {}, name: '진행중'),
      SelectableChip(onTap: () {}, name: '완료'),
    ],
  );
}

@AppThemePreview(group: 'Buttons', name: 'test')
Widget test() {
  int index = 1;
  return Wrap(
    spacing: 10,
    runSpacing: 10,
    children: [
      SelectableChip(onTap: () {}, name: '전체', selected: true),
      SelectableChip(onTap: () {}, name: '진행중'),
      SelectableChip(onTap: () {}, name: '완료'),
    ],
  );
}

class SelectableChip extends StatelessWidget {
  final String name;
  final bool selected;
  final VoidCallback? onTap;
  const SelectableChip({
    super.key,
    required this.name,
    this.selected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
        decoration: BoxDecoration(
          color: selected ? Colors.blue : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Text(
          name,
          style: TextStyle(
            fontSize: 16,
            color: selected ? Colors.white : Colors.black,
            fontWeight: selected ? .bold : null,
          ),
        ),
      ),
    );
  }
}
