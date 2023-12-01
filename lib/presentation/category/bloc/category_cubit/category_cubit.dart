import 'package:flutter_ar/api/api.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../data/models/ar_category.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit() : super(CategoryInitial());

  void loadCategory() async {
    emit(CategoryLoading());
    var ar_category = await API().getCategories();
    emit(CategoryLoaded(arCategory: ar_category!));
  }
}
