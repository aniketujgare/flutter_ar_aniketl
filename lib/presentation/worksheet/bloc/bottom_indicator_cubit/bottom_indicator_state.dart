part of 'bottom_indicator_cubit.dart';

@freezed
class BottomIndicatorState with _$BottomIndicatorState {
  const factory BottomIndicatorState.initial() = _Initial;
  const factory BottomIndicatorState.animate() = _Animate;
  const factory BottomIndicatorState.shouldTransit({
    @Default(0.0) double animateOffse,
  }) = _Transit;
}
