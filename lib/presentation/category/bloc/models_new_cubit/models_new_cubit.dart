import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/util/api/api.dart';
import '../../../../data/models/ar_model.dart';

part 'models_new_state.dart';
part 'models_new_cubit.freezed.dart';

class ModelsNewCubit extends Cubit<ModelsNewState> {
  ModelsNewCubit() : super(const ModelsNewState());

  void loadModels(String category) async {
    if (state.arModelss.containsKey(category)) {
      emit(state.copyWith(
          status: ModelsStatus.loaded,
          arModels: state.arModelss[category] ?? []));
    } else {
      emit(state.copyWith(status: ModelsStatus.loading));
      var arModelsLocal = await API().getModel(category);
      // Create a new map with the updated entry for the given category
      Map<String, List<ArModel>> newArModelss = Map.from(state.arModelss);
      newArModelss[category] = arModelsLocal!;

      // Update the state with the new map
      emit(state.copyWith(
          status: ModelsStatus.loaded,
          arModelss: newArModelss,
          arModels: arModelsLocal));
    }
    // if (state.arModelss.containsKey(category)) {
    // emit(state.copyWith(status: ModelsStatus.loading));
    // var arModelsLocal = await API().getModel(category);
    // emit(state.copyWith(
    //     status: ModelsStatus.loaded, arModels: arModelsLocal ?? []));
    // }
  }
}
