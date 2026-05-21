import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:unitask/app/theme/preview.dart';

@AppThemePreview(group: 'Buttons', name: 'HighlightButton')
Widget preview() {
  return HighlightButton(
    color: Colors.blue,
    leading: Icon(LucideIcons.plus, size: 14),
    child: const Text('새 과제 추가', style: TextStyle(color: Colors.blue)),
  );
}

class HighlightButton extends StatelessWidget {
  //What?
  final Color color;
  final double spacing;
  final Widget child;
  final Widget? leading;
  final Widget? trailing;
  final VoidCallback? onPressed;

  const HighlightButton({
    super.key,
    this.color = Colors.blue,
    this.spacing = 10.0,
    required this.child,
    this.leading,
    this.trailing,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const .symmetric(horizontal: 14, vertical: 5),
        decoration: BoxDecoration(
          border: Border.all(color: color, width: 2),
          borderRadius: BorderRadius.circular(10),
          color: color.withValues(alpha: 0.3),
        ),
        alignment: Alignment.center,
        child: Row(
          spacing: spacing,
          mainAxisSize: .min,
          children: [
            if (leading != null && leading is Icon)
              () {
                final leadingIcon = leading as Icon;
                return Icon(
                  leadingIcon.icon,
                  size: leadingIcon.size,
                  color: leadingIcon.color ?? color,
                );
              }()
            else
              ?leading,
            DefaultTextStyle(
              style: TextStyle(fontWeight: .bold, color: color),
              child: child,
            ),
            if (trailing != null && trailing is Icon)
              () {
                final trailingIcon = trailing as Icon;
                return Icon(
                  trailingIcon.icon,
                  size: trailingIcon.size,
                  color: trailingIcon.color ?? color,
                );
              }()
            else
              ?trailing,
          ],
        ),
      ),
    );
  }
}
