import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_ar/data/models/ar_model.dart';

import '../../../../core/util/api/api.dart';

part 'models_state.dart';

class ModelsCubit extends Cubit<ModelsState> {
  ModelsCubit() : super(ModelsInitial());
  List<ArModel>? arModelsLocal;
  void loadModels(String category) async {
    if (arModelsLocal == null) {
      emit(ModelsLoading());
      var arModelsLocal = await API().getModel(category);
      print('categories loaded$category');
      emit(ModelsLoaded(arModels: arModelsLocal!));
    }
  }
}
