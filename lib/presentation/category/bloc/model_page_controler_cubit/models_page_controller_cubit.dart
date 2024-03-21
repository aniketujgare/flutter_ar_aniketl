import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ModelsPageControllerCubit extends Cubit<int> {
  ModelsPageControllerCubit() : super(0);
  bool isInTransit = false;
  PageController modelpageController = PageController();
  get pageCont => modelpageController;

  void goToPage(int page) {
    modelpageController
        .animateToPage(
      page,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    )
        .whenComplete(() {
      isInTransit = false;
      emit(curridx);
    });
  }

  int maxLen = 0;

  int curridx = 0;
  get activePageIdx => curridx;
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
    if (maxLen == len - 1) {
      emit(curridx);
      debugPrint('maxLen $maxLen');
      return;
    }
    maxLen = len - 1;
    debugPrint('maxLen $maxLen');
    emit(curridx);
  }
}
