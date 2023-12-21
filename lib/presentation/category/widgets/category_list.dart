import 'package:flutter/material.dart';
import 'package:flutter_ar/core/util/device_type.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:size_config/size_config.dart';

import '../bloc/category_new_cubit/category_new_cubit.dart';
import 'category_page_view.dart';

class CategoryList extends StatelessWidget {
  const CategoryList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryNewCubit, CategoryNewState>(
        builder: (context, state) {
      if (state.status == CategoryStatus.loaded) {
        return CategoryPageView();
      }
      return Center(
          child: Lottie.asset('assets/Loading.json',
              height: DeviceType().resposnsiveLength(400.h, 400.h)));
    });
  }
}
