import 'package:go_router/go_router.dart';
import 'package:unitask/ui/pages/login/login_page.dart';
import 'package:unitask/ui/pages/login/signup/signup_page.dart';

import 'app_page.dart';

final appRouter = GoRouter(
  initialLocation: AppPage.login.path,
  routes: [
    GoRoute(
      name: AppPage.login.name,
      path: AppPage.login.path,
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      name: AppPage.signup.name,
      path: AppPage.signup.path,
      builder: (context, state) => const SignupPage(),
    ),
  ],
);
