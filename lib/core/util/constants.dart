import 'package:flutter/material.dart';
import 'package:flutter_ar/core/util/styles.dart';

import '../../presentation/worksheet/widgets/worksheet_submitted_box.dart';
import 'device_type.dart';

class Constants {
  static double appBarSizeWorksheet = DeviceType().isMobile ? 56 : 80;
  Future<void> showAlertDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        Future.delayed(Duration(milliseconds: 300))
            .then((value) => Navigator.of(context).pop());
        return const Dialog(
          child: WorksheetSubmittedBox(),
        );
      },
    );
  }

  void showAppSnackbar(BuildContext context, String text) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: AppColors.primaryColor,
        content: Text(text),
      ),
    );
  }
}
