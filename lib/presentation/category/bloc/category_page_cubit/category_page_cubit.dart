import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryPageCubit extends Cubit<int> {
  PageController pageController = PageController();
  get pageCont => pageController;

  void goToPage(int page) {
    pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  late int maxLen;
  CategoryPageCubit() : super(0);
  int curridx = 0;
  void setPage(int pageIndex) {
    print('pageIdx $pageIndex');
    curridx = pageIndex;
    // emit(curridx);
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

  void setmaxLength(int len) {
    maxLen = len - 1;
    print('maxLen $maxLen');
  }
}
