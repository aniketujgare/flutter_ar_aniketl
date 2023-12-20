part of 'splash_animation_bloc.dart';

enum SplashStatus { initial, inProgress, completed }

@freezed
class SplashAnimationState with _$SplashAnimationState {
  const factory SplashAnimationState(
      {@Default(SplashStatus.initial) SplashStatus status}) = Initial;
}
