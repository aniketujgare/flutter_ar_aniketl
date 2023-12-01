import 'package:flutter/material.dart';
import 'package:flutter_ar/constants.dart';
import 'package:flutter_ar/core/route/route_name.dart';
import 'package:flutter_ar/presentation/category/pages/category_models_screen.dart';
import 'package:flutter_ar/presentation/category/pages/category_screen.dart';
import 'package:go_router/go_router.dart';

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
              path: '/',
              name: categoryRoute,
              pageBuilder: (context, state) {
                return MaterialPage(
                    child: CategoryScreen(isMobile: isMobile(context)));
              },
              routes: [
                GoRoute(
                    path: 'category_models',
                    name: categoryModelsRoute,
                    pageBuilder: (context, state) {
                      return MaterialPage(
                          child: CategoryModelsScreen(
                              isMobile: isMobile(context)));
                    })
              ]),
        ]);
  }
}
