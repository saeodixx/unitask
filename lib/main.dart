import 'package:flutter/material.dart';
import 'package:unitask/app/theme/app_theme.dart';

import 'app/router/app__router.dart';

void main() {
  runApp(const UniTaskApp());
}

class UniTaskApp extends StatelessWidget {
  const UniTaskApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      themeMode: ThemeMode.system,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      routerConfig: appRouter,
    );
  }
}
