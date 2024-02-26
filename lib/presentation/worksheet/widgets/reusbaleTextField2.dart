import 'package:flutter/material.dart';
import 'package:flutter_ar/core/util/device_type.dart';
import 'package:flutter_ar/core/util/styles.dart';
import 'package:size_config/size_config.dart';

class ReusableTextField2 extends StatelessWidget {
  const ReusableTextField2(
      {super.key,
      required this.textFieldImage,
      this.showCursor,
      this.readOnly = false,
      required this.controller,
      this.onChanged,
      this.onTap,
      this.offset = const Offset(-1, -7)});
  final String textFieldImage;
  final bool? showCursor;
  final bool readOnly;
  final TextEditingController controller;
  final Function(String)? onChanged;
  final void Function()? onTap;
  final Offset offset;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: 70.wp,
          height: 70.h,
          child: Image.asset(
            textFieldImage,
            fit: BoxFit.fill,
          ),
        ),
        Transform.translate(
          offset: DeviceType().isMobile ? Offset(-1.h, -7.h) : offset,
          child: Container(
            width: 70.wp,
            padding: EdgeInsets.symmetric(
                horizontal: DeviceType().isMobile ? 15 : 0),
            child: TextFormField(
              cursorHeight: DeviceType().isMobile ? null : 35.h,
              textAlign: TextAlign.center,
              onTap: onTap,
              controller: controller,
              showCursor: true,
              readOnly: true,
              style: AppTextStyles.unitedRounded270w700
                  .copyWith(color: Colors.black, fontSize: 122.sp),
              decoration: const InputDecoration(
                // labelText: 'Type your answer',
                border: InputBorder.none,
              ),
              // initialValue: ans,
              onChanged: onChanged,
              onEditingComplete: () {
                print('complete');
                FocusScope.of(context).requestFocus(FocusNode());
              },
            ),
          ),
        ),
      ],
    );
  }
}
