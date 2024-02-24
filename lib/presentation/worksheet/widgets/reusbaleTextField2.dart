import 'package:flutter/material.dart';
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
      this.onTap});
  final String textFieldImage;
  final bool? showCursor;
  final bool readOnly;
  final TextEditingController controller;
  final Function(String)? onChanged;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: 70.wp,
          height: 60,
          child: Image.asset(
            textFieldImage,
            fit: BoxFit.fill,
          ),
        ),
        Transform.translate(
          offset: Offset(-1.h, -7.h),
          child: Container(
            width: 70.wp,
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: TextFormField(
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
