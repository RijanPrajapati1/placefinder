import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:placefinder/auth/login/presentation/login_page.dart';
import 'package:placefinder/auth/signup/presentation/signup_page.dart';
import 'package:placefinder/bottom_navigation_bar/bottom_navigation_bar.dart';
import 'package:placefinder/features/account/presentation/account_page.dart';
import 'package:placefinder/features/details_page/presentation/place_details_page.dart';
import 'package:placefinder/features/home/presentation/home_page.dart';
import 'package:placefinder/features/search/presentation/search_page.dart';
import 'package:placefinder/features/splash_screen/splash_screen.dart';
import 'package:placefinder/routes/routes.dart';

class AppRoutes {
  static final GlobalKey<NavigatorState> rootNavigatorKey =
      GlobalKey<NavigatorState>();

  static final _rootNavigatorHomeKey = GlobalKey<NavigatorState>();
  static final _rootNavigatorSearchKey = GlobalKey<NavigatorState>();
  static final _rootNavigatorAccountKey = GlobalKey<NavigatorState>();

  static final GoRouter appRouter = GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: '/splashScreen',
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            MyBottomNavigationBar(navigationShell: navigationShell),
        branches: [
          StatefulShellBranch(
            navigatorKey: _rootNavigatorHomeKey,
            routes: [
              GoRoute(
                path: '/home',
                name: Routes.home,
                builder: (context, state) => const HomePage(),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _rootNavigatorSearchKey,
            routes: [
              GoRoute(
                path: '/search',
                builder: (context, state) => const SearchPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _rootNavigatorAccountKey,
            routes: [
              GoRoute(
                path: '/account',
                builder: (context, state) => const AccountPage(),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: '/login',
        name: Routes.login,
        builder: (context, state) => const LoginPage(),
      ),

      GoRoute(
        path: '/signup',
        name: Routes.signup,
        builder: (context, state) => const SignupPage(),
      ),
      GoRoute(
        path: '/splashScreen',
        name: Routes.splashScreen,
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        path: '/account',
        name: Routes.account,
        builder: (context, state) => const AccountPage(),
      ),
      GoRoute(
        path: '/placeDetailsPage',
        name: Routes.placeDetailsPage,
        builder: (context, state) {
          final place = state.extra as Map<String, dynamic>;
          return PlaceDetailsPage(place: place);
        },
      ),
    ],
  );
}
