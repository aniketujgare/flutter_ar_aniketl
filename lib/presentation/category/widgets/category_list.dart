import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      return const Center(child: CircularProgressIndicator());
    });
  }
}
