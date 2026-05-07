import 'package:go_router/go_router.dart';

import 'app_page.dart';

final appRouter = GoRouter(
  initialLocation: AppPage.login.path,
  routes: AppPage.values.map((e) {
    return GoRoute(
      name: e.name,
      path: e.path,
      builder: (context, state) => e.page,
    );
  }).toList(),
);
