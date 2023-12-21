part of 'category_new_cubit.dart';

enum CategoryStatus { initial, loading, loaded, error }

@freezed
class CategoryNewState with _$CategoryNewState {
  const factory CategoryNewState(
      {@Default(CategoryStatus.initial) CategoryStatus status,
      @Default([]) List<ArCategory> arCategory,
      @Default(
        [
          'assets/images/PNG Icons/Animals.png',
          'assets/images/PNG Icons/birds.png',
          'assets/images/PNG Icons/sea life.png',
          'assets/images/PNG Icons/dinosaurs.png',
          'assets/images/PNG Icons/plants.png',
          'assets/images/PNG Icons/trees.png',
          'assets/images/PNG Icons/Fruits & Vegetables.png',
          'assets/images/PNG Icons/my body.png',
          'assets/images/PNG Icons/monuments.png',
          'assets/images/PNG Icons/vehicles.png',
          'assets/images/PNG Icons/vehicles.png',
        ],
      )
      List<String> categoryImgList,
      @Default('Failed to load categories') String errorMsg}) = Initial;
}
