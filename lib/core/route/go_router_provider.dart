import 'package:flutter/material.dart';
import 'package:flutter_ar/domain/repositories/authentication_repository.dart';
import 'package:go_router/go_router.dart';

import '../../data/models/student_profile_model.dart';
import '../../presentation/category/pages/category_screen.dart';
import '../../presentation/login/pages/login_screen.dart';
import '../../presentation/main_menu/main_menu_screen.dart';
import '../../presentation/parent_zone/pages/parent_zone_screen.dart';
import '../../presentation/splash_screen/splash_screen.dart';
// import '../../temp_testing/draw_test.dart';
import 'route_name.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey(debugLabel: 'root');

class GoRouterProvider {
  GoRouter goRouter() {
    return GoRouter(
        navigatorKey: _rootNavigatorKey,
        initialLocation: '/',
        // redirect: (context, state) async {
        //   StudentProfileModel? studentProfile =
        //       await AuthenticationRepository().getStudentProfile();

        //   if (studentProfile == null) {
        //     return '/login';
        //   } else {
        //     return '/';
        //   }
        // },
        routes: [
          GoRoute(
            path: '/',
            name: 'splashRoute',
            pageBuilder: (context, state) {
              return MaterialPage(child: SplashScreen());
              // return MaterialPage(child: ModelsList3D());
            },
          ),
          GoRoute(
            path: '/$loginRoute',
            name: 'loginRoute',
            pageBuilder: (context, state) {
              return const MaterialPage(child: LoginScreen());
              // return MaterialPage(child: ModelsList3D());
            },
          ),
          GoRoute(
            path: '/$mainMenuRoute',
            name: mainMenuRoute,
            pageBuilder: (context, state) {
              return MaterialPage(child: MainMenuScreen());
            },
          ),
          GoRoute(
            path: '/$categoryRoute',
            name: categoryRoute,
            pageBuilder: (context, state) {
              return MaterialPage(child: CategoryScreen());
            },
          ),
          GoRoute(
            path: '/parentZone',
            name: 'parentZoneRoute',
            pageBuilder: (context, state) {
              return const MaterialPage(child: ParentZoneScreen());
              // return MaterialPage(child: ModelsList3D());
            },
          ),
        ]);
  }
}
