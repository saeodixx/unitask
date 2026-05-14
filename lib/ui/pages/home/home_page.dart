import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    //뒤로가기 방지 / 감지
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        return;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('내 과제'),
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(LucideIcons.bell)),
          ],
        ),

        body: SafeArea(child: Placeholder()),
      ),
    );
  }
}
