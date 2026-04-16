import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class LabelTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String label;
  final String? hintText;
  final IconData? icon;
  final bool enableObscure;

  const LabelTextField({
    super.key,
    required this.label,
    this.controller,
    this.hintText,
    this.icon,
    this.enableObscure = false,
  });

  @override
  State<LabelTextField> createState() => _LabelTextFieldState();
}

class _LabelTextFieldState extends State<LabelTextField> {
  late bool _obscureText = widget.enableObscure;

  void _switchObscure() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 8,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        TextField(
          decoration: InputDecoration(
            hintText: widget.hintText,
            prefixIcon: Icon(widget.icon),
            suffixIcon: widget.enableObscure
                ? InkWell(
                    onTap: () {
                      _switchObscure();
                    },
                    child: Icon(
                      _obscureText ? LucideIcons.eyeClosed : LucideIcons.eye,
                    ),
                  )
                : null,
          ),
          controller: widget.controller,
          obscureText: _obscureText,
        ),
      ],
    );
  }
}
