import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/util/api/api.dart';
import '../../../../data/models/ar_category.dart';

part 'category_new_state.dart';
part 'category_new_cubit.freezed.dart';

class CategoryNewCubit extends Cubit<CategoryNewState> {
  CategoryNewCubit() : super(const CategoryNewState());

  void loadCategory() async {
    if (state.arCategory.isEmpty) {
      emit(state.copyWith(status: CategoryStatus.loading));
      List<ArCategory>? arCategoryLocal = await API().getCategories();
      emit(state.copyWith(
          status: CategoryStatus.loaded, arCategory: arCategoryLocal ?? []));
    }
  }
}
