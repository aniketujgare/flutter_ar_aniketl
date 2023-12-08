import 'package:flutter/material.dart';
import 'package:flutter_ar/presentation/category/bloc/category_cubit/category_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/util/api/api.dart';
import 'category_page_view.dart';

class CategoryList extends StatelessWidget {
  const CategoryList({
    super.key,
    required this.isMobile,
  });

  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryCubit, CategoryState>(builder: (context, state) {
      if (state is CategoryLoaded) {
        return CategoryPageView(
            isMobile: isMobile, arCategoryies: state.arCategory);
      }
      return const Center(child: CircularProgressIndicator());
    });
  }
}
