import 'package:flutter/material.dart';

import '../../presentation/worksheet/widgets/worksheet_submitted_box.dart';
import 'device_type.dart';

class Constants {
  static double appBarSizeWorksheet = DeviceType().isMobile ? 56 : 80;
  Future<void> showAlertDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return const Dialog(
          child: WorksheetSubmittedBox(),
        );
      },
    );
  }
}
