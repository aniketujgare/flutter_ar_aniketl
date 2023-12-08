import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_ar/data/models/ar_model.dart';

import '../../../../core/util/api/api.dart';

part 'models_state.dart';

class ModelsCubit extends Cubit<ModelsState> {
  ModelsCubit() : super(ModelsInitial());
  void loadModels(String category) async {
    emit(ModelsLoading());
    var ar_models = await API().getModel(category);
    print('categories loaded$category');
    emit(ModelsLoaded(arModels: ar_models!));
  }
}
