import 'package:flutter/material.dart';

class SubjectLabel extends StatelessWidget {
  const SubjectLabel({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: Color(0xFFF3F4F6),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: .w700,
          fontSize: 12,
          color: Colors.black,
        ),
      ),
    );
  }
}
