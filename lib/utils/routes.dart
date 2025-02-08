import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:realtime_todo/screens/Add&EditEmployee/add_screen.dart';
import 'package:realtime_todo/screens/Home/home_screen.dart';

class AppRouter {
  final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return const HomeScreen();
        },
      ),
      GoRoute(
        path: '/addscreen',
        pageBuilder: (context, state) {
          final extra = state.extra as Map<String, dynamic>;
          bool isEdit = extra['isEdit'];
          String id = extra['id'];
          String name = extra['name'];
          return customSlideTransition(
              child: AddDataScren(isEdit: isEdit, id: id, name: name));
        },
      ),
    ],
  );
}

CustomTransitionPage<dynamic> customSlideTransition({
  required Widget child,
  Offset begin = const Offset(1, 0),
  Duration duration = const Duration(milliseconds: 300),
}) {
  return CustomTransitionPage(
    child: child,
    transitionDuration: duration,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return SlideTransition(
        position: Tween<Offset>(
          begin: begin,
          end: Offset.zero,
        ).animate(animation),
        child: child,
      );
    },
  );
}
