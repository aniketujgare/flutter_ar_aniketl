import 'package:flutter/material.dart';
import 'package:flutter_ar/core/util/styles.dart';

import '../../presentation/worksheet/widgets/worksheet_submitted_box.dart';
import 'device_type.dart';

class Constants {
  static double appBarSizeWorksheet = DeviceType().isMobile ? 56 : 80;
  Future<void> showAlertDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const PopScope(
          canPop: false,
          child: Dialog(
            child: WorksheetSubmittedBox(),
          ),
        );
      },
    );
  }

  void showAppSnackbar(BuildContext context, String text, {Color? color}) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: color ?? AppColors.primaryColor,
        content: Text(text),
      ),
    );
  }
}
