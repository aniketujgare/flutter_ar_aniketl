part of 'models_new_cubit.dart';

enum ModelsStatus { initial, loading, loaded, error }

@freezed
class ModelsNewState with _$ModelsNewState {
  const factory ModelsNewState({
    @Default(ModelsStatus.initial) ModelsStatus status,
    @Default([]) List<ArModel> arModels,
    @Default('Failed to load categories') String errorMsg,
  }) = Initial;
}
