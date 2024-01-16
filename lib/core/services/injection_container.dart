import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';

import '../../domain/repositories/authentication_repository.dart';
import '../../presentation/category/bloc/category_new_cubit/category_new_cubit.dart';
import '../../presentation/category/bloc/category_page_cubit/category_page_cubit.dart';
import '../../presentation/category/bloc/model_asset_handler_bloc/model_asset_handler_bloc.dart';
import '../../presentation/category/bloc/model_page_controler_cubit/models_page_controller_cubit.dart';
import '../../presentation/category/bloc/models_new_cubit/models_new_cubit.dart';
import '../../presentation/login/bloc/guest_validation_bloc/guest_validation_bloc.dart';
import '../../presentation/login/bloc/login_bloc/login_bloc.dart';
import '../../presentation/login/bloc/login_validation_bloc/login_validation_bloc.dart';
import '../../presentation/parent_zone/bloc/navbar_cubit/app_navigator_cubit.dart';
import '../../presentation/parent_zone/bloc/teacher_list_bloc/teacher_list_bloc.dart';
import '../../presentation/parent_zone/bloc/teacher_message_cubit/teacher_message_cubit.dart';
import '../../presentation/splash_screen/bloc/splash_animation_bloc.dart';
import '../../presentation/worksheet/bloc/worksheet_cubit/worksheet_cubit.dart';
import '../../presentation/worksheet/bloc/worksheet_solver_cubit/worksheet_solver_cubit.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.instance;

Future<void> init() async {
  //! Features - Repo, usecase etc
  //Bloc
  sl.registerFactory(() => CategoryNewCubit());
  sl.registerFactory(() => CategoryPageCubit());
  sl.registerFactory(() => ModelsPageControllerCubit());
  sl.registerFactory(() => ModelsNewCubit());
  sl.registerFactory(() => LoginBloc(sl()));
  sl.registerFactory(() => LoginValidationBloc());
  sl.registerFactory(() => GuestValidationBloc());
  sl.registerFactory(() => SplashAnimationBloc());
  sl.registerFactory(() => AppNavigatorCubit());
  sl.registerFactory(() => TeacherListBloc());
  sl.registerFactory(() => TeacherMessageCubit());
  sl.registerFactory(() => ModelAssetHandlerBloc());
  sl.registerFactory(() => WorksheetCubit());
  sl.registerFactory(() => WorksheetSolverCubit());

  // Repository
  sl.registerLazySingleton(() => AuthenticationRepository(sl()));
  //! Core Stuff

  //! External

  sl.registerLazySingleton(() => http.Client());
}
