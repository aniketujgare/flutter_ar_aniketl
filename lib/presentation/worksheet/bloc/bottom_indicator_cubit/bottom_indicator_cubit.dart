import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'bottom_indicator_state.dart';
part 'bottom_indicator_cubit.freezed.dart';

class BottomIndicatorCubit extends Cubit<BottomIndicatorState> {
  BottomIndicatorCubit() : super(const BottomIndicatorState.initial());

  void shouldScrollState() {
    emit(const BottomIndicatorState.initial());
    emit(const BottomIndicatorState.animate());
  }

  bool isScrolledToRight = false;
  void scrollBottomIndicatorPosition(
      int currentQ, int totalQ, ScrollController sc, double width) {
    emit(const BottomIndicatorState.initial());

    if (sc.offset > 5 && currentQ < totalQ ~/ 2) {
      emit(const BottomIndicatorState.shouldTransit(animateOffse: 0.0));
      return;
    } else if (sc.offset < 15 && currentQ > totalQ ~/ 2) {
      emit(BottomIndicatorState.shouldTransit(
          animateOffse: sc.position.maxScrollExtent));
      return;
    } else if (currentQ < totalQ ~/ 2) {
      isScrolledToRight = false;
      emit(const BottomIndicatorState.shouldTransit(animateOffse: 0.0));
    } else if (currentQ > totalQ ~/ 2 && !isScrolledToRight) {
      const double itemExtent = 10.0; // Adjust as needed based on your UI
      final double listItemWidth = itemExtent * totalQ;
      double scrollOffset = 0.0;
      isScrolledToRight = true;
      scrollOffset = listItemWidth;
      emit(BottomIndicatorState.shouldTransit(animateOffse: scrollOffset));
    }

    // Scroll to the calculated offset
  }
}
