import 'package:flutter/material.dart';
import 'package:flutter_ar/constants.dart';
import 'package:flutter_ar/core/route/route_name.dart';
import 'package:flutter_ar/presentation/category/pages/category_screen.dart';
import 'package:flutter_ar/presentation/login/login_page.dart';
import 'package:flutter_ar/presentation/login/pages/login_screen.dart';
import 'package:flutter_ar/presentation/splash_screen/splash_screen_animation.dart';
import 'package:go_router/go_router.dart';

import '../../presentation/login/pages/login_animation.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey(debugLabel: 'root');
final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey(debugLabel: 'shell');

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
              routes: [
                // GoRoute(
                //     path: 'category_models',
                //     name: categoryModelsRoute,
                //     pageBuilder: (context, state) {
                //       return MaterialPage(
                //           child: CategoryModelsScreen(
                //               isMobile: isMobile(context)));
                //     })
              ]),
          GoRoute(
            path: '/',
            name: loginRoute,
            pageBuilder: (context, state) {
              return MaterialPage(child: LoginScreen());
            },
          ),
        ]);
  }
}
