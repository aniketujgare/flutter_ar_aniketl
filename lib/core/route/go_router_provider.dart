import 'package:flutter/material.dart';
import 'package:flutter_ar/demo/animation_playground.dart';
import 'package:flutter_ar/presentation/login/pages/login_screen.dart';
import 'package:flutter_ar/presentation/main_menu/main_menu_screen.dart';
import 'package:flutter_ar/presentation/parent_zone/pages/parent_zone_screen.dart';
import 'package:flutter_ar/presentation/parent_zone/widgets/message_view.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';

import '../../presentation/category/widgets/ar_view_ios.dart';
import '../../presentation/category/widgets/category_models_page_view.dart';
import '../../presentation/worksheet/pages/worksheet.dart';
import '../../temp_testing/asset_download.dart';
import '../../demo/constants.dart';
import '../../presentation/category/widgets/model_3d_view.dart';
import '../../presentation/category/pages/category_screen.dart';
import '../../presentation/splash_screen/splash_screen.dart';
import '../../temp_testing/draw_test.dart';
import 'route_name.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey(debugLabel: 'root');

class GoRouterProvider {
  GoRouter goRouter() {
    return GoRouter(
        navigatorKey: _rootNavigatorKey,
        // initialLocation: '/',
        // redirect: (context, state) async {
        //   var kidsAppBox = await Hive.openBox("kidsApp");
        //   var v = kidsAppBox.get('isLoggedIn');
        //   if (kidsAppBox.get('isLoggedIn') == null ||
        //       kidsAppBox.get('isLoggedIn') == false) {
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
            path: '/$categoryModelsRoute',
            name: categoryModelsRoute,
            pageBuilder: (context, state) {
              return MaterialPage(child: CategoryModelsPageView());
            },
          ),
          GoRoute(
            path: '/$modelViewRoute',
            name: modelViewRoute,
            pageBuilder: (context, state) {
              Map<String, String> args = state.extra as Map<String, String>;
              return MaterialPage(
                child: ModelView(
                  imageFileName: args['imageFileName']!,
                  modelUrl: args['modelUrl']!,
                  modelName: args['modelName']!,
                ),
              );
            },
          ),
          GoRoute(
            path: '/$arViewIOSRoute',
            name: arViewIOSRoute,
            pageBuilder: (context, state) {
              Map<String, String> args = state.extra as Map<String, String>;
              return MaterialPage(
                child: ARViewIOS(
                  modelUrl: args['modelUrl']!,
                  imageFileName: args['imageFileName']!,
                ),
              );
            },
          ),
          GoRoute(
            path: '/$parentZoneRoute',
            name: parentZoneRoute,
            pageBuilder: (context, state) {
              return const MaterialPage(child: ParentZoneScreen());
              // return MaterialPage(child: ModelsList3D());
            },
          ),
          GoRoute(
            path: '/$worksheetRoute',
            name: worksheetRoute,
            pageBuilder: (context, state) {
              return const MaterialPage(child: WorksheetView());
              // return MaterialPage(child: ModelsList3D());
            },
          ),
        ]);
  }
}
