import 'dart:math';

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

  int _noOfPages = 1;
  CategoryPageCubit() : super(0);
  int curridx = 0;
  void setPage(int pageIndex) {
    curridx = pageIndex;
  }

  void setNextPage() {
    int idx = min(curridx + 1, _noOfPages);
    goToPage(idx);
  }

  void setPreviousPage() {
    int idx = max(curridx - 1, 0);
    goToPage(idx);
  }

  void setmaxLength(int len) {
    _noOfPages = len - 1;
  }
}
