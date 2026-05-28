import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:unitask/app/theme/preview.dart';
import 'package:unitask/ui/common/subject_label.dart';

@AppThemePreview(group: 'Cards', name: 'TaskCard')
Widget preview() {
  return TaskCard(
    onSelected: () {},
    onChecked: (value) {},
    checked: false,
    title: 'Flutter  개발',
    date: DateTime.now().copyWith(month: 6, day: 5),
    category: SubjectLabel(text: 'Flutter'),
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
    //TODO: 아이콘 색상 설정은 아래와 같다
    //<= D-3 빨간색
    //<= D-7 주황색
    //> D-7 검정색
    final dDay = date.difference(DateTime.now()).inDays;
    final dDayColor = switch (dDay) {
      <= 3 => Colors.red,
      <= 7 => Colors.orange,
      _ => Colors.black,
    };

    return Card(
      child: SizedBox(
        height: 120,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              //과목 라벨/체크박스
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  category,
                  Checkbox(
                    value: checked,
                    onChanged: onChecked,
                    visualDensity: .compact,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    fillColor: .resolveWith(
                      (states) => states.contains(WidgetState.selected)
                          ? Colors.blue
                          : Color(0xFFE5E7EB),
                    ),
                    overlayColor: .all(Colors.transparent),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    side: BorderSide(color: Colors.transparent),
                  ),
                ],
              ),
              //제목
              Text(
                title,
                overflow: .ellipsis,
                maxLines: 1,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ), // 제목이 길어지는 경우 말줄임표로 처리하기
              //기한표시
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                spacing: 5,
                children: [
                  Icon(LucideIcons.calendarRange, size: 16, color: dDayColor),

                  Text(
                    DateFormat('yyyy.MM.dd').format(date),
                    style: TextStyle(fontSize: 12, color: dDayColor),
                    //TODO: intl 라이브러리 사용해서 TimeFormat 설정하기
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
