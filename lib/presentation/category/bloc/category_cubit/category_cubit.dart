import 'package:flutter_ar/core/util/api/api.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../data/models/ar_category.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit() : super(CategoryInitial());
  List<ArCategory>? arCategoryLocal;

  void loadCategory() async {
    if (arCategoryLocal == null) {
      emit(CategoryLoading());

      arCategoryLocal = await API().getCategories();
      emit(CategoryLoaded(arCategory: arCategoryLocal!));
    }
  }
}
