import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

class ModelsPageControllerCubit extends Cubit<int> {
  ModelsPageControllerCubit() : super(0);

  PageController modelpageController = PageController();
  get pageCont => modelpageController;

  void goToPage(int page) {
    modelpageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  late int maxLen;

  int curridx = 0;
  get activePageIdx => curridx;
  void setPage(int pageIndex) {
    print('pageIdx $pageIndex');
    curridx = pageIndex;
    emit(curridx);
    // emit(curridx);
    // if (pageIndex < maxLen && pageIndex > 0) {}
  }

  void setNextPage() {
    if (curridx < maxLen) {
      ++curridx;
      goToPage(curridx);
      emit(curridx);
    }
  }

  void setPreviousPage() {
    if (curridx > 0) {
      --curridx;
      goToPage(curridx);
      emit(curridx);
    }
  }

  void setmaxLength(int len) {
    maxLen = len - 1;
    print('maxLen $maxLen');
    emit(curridx);
  }
}
