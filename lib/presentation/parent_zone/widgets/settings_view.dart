import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:size_config/size_config.dart';

import '../bloc/navbar_cubit/app_navigator_cubit.dart';
import '../pages/parent_zone_screen.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Placeholder(
      child: BlocBuilder<AppNavigatorCubit, AppNavigatorState>(
        builder: (context, state) {
          return Center(
            child: Text(
              appBarTitle[state.index],
              style: TextStyle(
                color: Color(0xFF4F3A9C),
                fontSize: 160.sp,
                fontFamily: 'Uniform Rounded',
                fontWeight: FontWeight.w700,
                height: 0,
              ),
            ),
          );
        },
      ),
    );
  }
}
