import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WorksheetHistoryPageCubit extends Cubit<int> {
  bool isInTransit = false;

  PageController pageController = PageController();
  get pageCont => pageController;

  void goToPage(int page) {
    pageController
        .animateToPage(
      page,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    )
        .whenComplete(() {
      isInTransit = false;
      emit(page);
    });
  }

  int maxLen = 0;
  WorksheetHistoryPageCubit() : super(0);
  int curridx = 0;
  void setPage(int pageIndex) {
    curridx = pageIndex;
    emit(curridx);
  }

  void setNextPage() {
    if (curridx < maxLen) {
      if (!isInTransit) {
        isInTransit = true;

        ++curridx;
        goToPage(curridx);
      }
    }
  }

  void setPreviousPage() {
    if (curridx > 0) {
      if (!isInTransit) {
        isInTransit = true;

        --curridx;
        goToPage(curridx);
      }
    }
  }

  void setmaxLength(int len) {
    if (maxLen == len - 1) return;
    maxLen = len - 1;
    debugPrint('maxLen $maxLen');
    emit(curridx);
  }
}
