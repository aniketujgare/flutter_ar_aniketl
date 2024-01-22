import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

// part 'reports_pagecontroller_state.dart';
// part 'reports_pagecontroller_cubit.freezed.dart';

class ReportsPagecontrollerCubit extends Cubit<int> {
  PageController pageController = PageController();
  get pageCont => pageController;

  void goToPage(int page) {
    pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    emit(curridx);
    // pageController.initialPage
  }

  int maxLen = 3;
  ReportsPagecontrollerCubit() : super(0);
  int curridx = 0;
  void setPage(int pageIndex) {
    print('pageIdx $pageIndex');
    curridx = pageIndex;
    emit(curridx);

    // if (pageIndex < maxLen && pageIndex > 0) {}
  }

  void setNextPage() {
    if (curridx < maxLen) {
      ++curridx;
      goToPage(curridx);
    }
  }

  void setPreviousPage() {
    if (curridx > 0) {
      --curridx;
      goToPage(curridx);
    }
  }
}
