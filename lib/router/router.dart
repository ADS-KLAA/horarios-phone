import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:horarios_phone/screens/screens.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _homeNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'home');
final GlobalKey<NavigatorState> _loginNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'login');
final GlobalKey<NavigatorState> _signupNavigatorKey =
GlobalKey<NavigatorState>(debugLabel: 'signup');
final GlobalKey<NavigatorState> _calendarNavigatorKey =
GlobalKey<NavigatorState>(debugLabel: 'calendar');
// final GlobalKey<NavigatorState> _userAnimeListScreen =
// GlobalKey<NavigatorState>(debugLabel: 'userAnimeList');
// final GlobalKey<NavigatorState> _userMangaListScreen =
// GlobalKey<NavigatorState>(debugLabel: 'userMangaList');
// final GlobalKey<NavigatorState> _calendarScreen =
// GlobalKey<NavigatorState>(debugLabel: 'calendarScreen');
// final GlobalKey<NavigatorState> _localExtensionsScreen =
// GlobalKey<NavigatorState>(debugLabel: 'localExtensinosScreen');

final GoRouter router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/login',
  routes: <RouteBase>[
    StatefulShellRoute.indexedStack(
      builder: (BuildContext context, GoRouterState state,
          StatefulNavigationShell navigationShell) {
        // Return the widget that implements the custom shell (in this case
        // using a BottomNavigationBar). The StatefulNavigationShell is passed
        // to be able access the state of the shell and to navigate to other
        // branches in a stateful way.
        return ScaffoldScreen(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          navigatorKey: _loginNavigatorKey,
          routes: <RouteBase>[
            GoRoute(
              path: '/login',
              builder: (BuildContext context, GoRouterState state) =>
                  const LoginScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _signupNavigatorKey,
          routes: <RouteBase>[
            GoRoute(
              path: '/signup',
              builder: (BuildContext context, GoRouterState state) =>
                  const SignupScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _calendarNavigatorKey,
          routes: <RouteBase>[
            GoRoute(
              path: '/home',
              builder: (BuildContext context, GoRouterState state) =>
              const CalendarScreen(),
            ),
          ],
        ),
        // StatefulShellBranch(
        //   navigatorKey: _loginNavigatorKey,
        //   routes: <RouteBase>[
        //     GoRoute(
        //       path: '/home',
        //       builder: (BuildContext context, GoRouterState state) =>
        //       const HomeScreen(),
        //     ),
        //   ],
        // ),
      ],
    ),
  ],
);
