part of 'category_new_cubit.dart';

enum CategoryStatus { initial, loading, loaded, error }

@freezed
class CategoryNewState with _$CategoryNewState {
  const factory CategoryNewState(
      {@Default(CategoryStatus.initial) CategoryStatus status,
      @Default([]) List<ArCategory> arCategory,
      @Default('Failed to load categories') String errorMsg}) = Initial;
}
