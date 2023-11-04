import 'package:go_router/go_router.dart';
import 'package:holo_tutor/features/home/home_page.dart';
import 'package:holo_tutor/features/tutor/tutor_page.dart';

final router = GoRouter(
  routes: <GoRoute>[
    GoRoute(
      path: HomePage.path,
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: TutorPage.path,
      builder: (context, state) => const TutorPage(),
    ),
  ],
  initialLocation: HomePage.path,
);
