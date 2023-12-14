import 'package:flutter/material.dart';
import 'package:flutter_ar/demo/animation_playground.dart';
import 'package:flutter_ar/presentation/login/pages/login_screen.dart';
import 'package:go_router/go_router.dart';

import '../../demo/constants.dart';
import '../../presentation/category/pages/category_screen.dart';
import '../../presentation/splash_screen/splash_screen.dart';
import 'route_name.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey(debugLabel: 'root');

class GoRouterProvider {
  GoRouter goRouter() {
    return GoRouter(
        navigatorKey: _rootNavigatorKey,
        initialLocation: '/',
        routes: [
          GoRoute(
            path: '/a',
            name: categoryRoute,
            pageBuilder: (context, state) {
              return MaterialPage(
                  child: CategoryScreen(isMobile: isMobile(context)));
            },
          ),
          GoRoute(
            path: '/',
            name: loginRoute,
            pageBuilder: (context, state) {
              return const MaterialPage(child: LoginScreen());
              // return MaterialPage(child: ModelsList3D());
            },
          ),
        ]);
  }
}
