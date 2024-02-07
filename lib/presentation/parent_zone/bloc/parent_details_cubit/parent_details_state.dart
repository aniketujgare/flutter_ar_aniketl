part of 'parent_details_cubit.dart';

enum ParentDetailsStatus { initial, loading, loaded, error }

@freezed
class ParentDetailsState with _$ParentDetailsState {
  const factory ParentDetailsState.initial({
    @Default([]) List<ParentDetails> parentDetails,
    @Default(ParentDetailsStatus.initial) ParentDetailsStatus status,
  }) = Initial;
}
