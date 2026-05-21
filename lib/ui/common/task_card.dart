import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:unitask/app/theme/preview.dart';

@AppThemePreview(group: 'Cards', name: 'TaskCard')
Widget preview() {
  return TaskCard(
    checked: false,
    title: '플러터 개발',
    date: DateTime.now(),
    category: Container(
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(5),
      ),
      child: const Text('카테고리'),
    ),
  );
}

class TaskCard extends StatelessWidget {
  final bool checked;
  final String title;
  final DateTime date;
  final Widget category;
  final VoidCallback? onSelected;
  final Function(bool? value)? onChecked;

  const TaskCard({
    super.key,
    required this.checked,
    required this.title,
    required this.date,
    required this.category,
    this.onSelected,
    this.onChecked,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: .stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              category,
              Checkbox(value: checked, onChanged: onChecked),
            ],
          ),
          Text(title),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 5,
            children: [
              Icon(LucideIcons.calendar),
              //TODO: 아이콘 색상 설정은 아래와 같다
              //<= D-3 빨간색
              //<= D-7 주황색
              //> D-7 검정색
              Text(
                '',
                //TODO: intl 라이브러리 사용해서 TimeFormat 설정하기
              ),
            ],
          ),
        ],
      ),
    );
  }
}
