import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'splash_animation_event.dart';
part 'splash_animation_state.dart';
part 'splash_animation_bloc.freezed.dart';

class SplashAnimationBloc
    extends Bloc<SplashAnimationEvent, SplashAnimationState> {
  SplashAnimationBloc() : super(const SplashAnimationState()) {
    on<SplashAnimationEvent>((events, emit) async {
      await events.map(completed: (_) async => await _animationCompleted(emit));
    });
  }

  _animationCompleted(Emitter<SplashAnimationState> emit) {
    emit(state.copyWith(status: SplashStatus.completed));
  }
}
