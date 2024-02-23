import 'package:flutter/material.dart';
import 'package:flutter_ar/core/util/reusable_widgets/reusable_textfield.dart';
import 'package:flutter_ar/core/util/styles.dart';
import 'package:flutter_ar/presentation/worksheet/models/questions.dart';
import 'package:size_config/size_config.dart';

import '../reusbaleTextField2.dart';

class ArithmeticQuestionUI extends StatefulWidget {
  const ArithmeticQuestionUI({super.key, required this.screenSize});
  final Size screenSize;
  @override
  State<ArithmeticQuestionUI> createState() => _ArithmeticQuestionUIState();
}

class _ArithmeticQuestionUIState extends State<ArithmeticQuestionUI> {
  var qu = ArithmeticQuestion(
      num1: '163',
      num2: '158',
      operator: '+',
      answer: 'answer',
      question: 'question');
  late int num1Boxes;
  late int num2Boxes;
  late double digitBoxSize;
  // late List<TextFormField> ansTextFields = [];
  late List<String> ansFieldsText = [];
  @override
  void initState() {
    super.initState();
    num1Boxes = qu.num1.length;
    num2Boxes = qu.num2.length;
    digitBoxSize = widget.screenSize.width * 0.15;
    // Addition
    //? To calculate no of ans box
    int resultAddition = int.parse(qu.num1) + int.parse(qu.num2);
    // Subtraction
    int resultSubtraction = int.parse(qu.num1) - int.parse(qu.num2);

    for (var i = 0; i < num1Boxes + 1; i++) {
      ansFieldsText.add('');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.only(top: 15, right: 10),
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.end,
              // mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: List.generate(
                    num1Boxes + 1,
                    (index) => Padding(
                      padding: const EdgeInsets.all(8),
                      child: Container(
                        height: 50,
                        width: digitBoxSize,
                        // color: index == num1Boxes
                        //     ? Colors.transparent
                        //     : AppColors.parentZoneScaffoldColor,
                        child: index == num1Boxes
                            ? null
                            : Row(
                                children: [
                                  SizedBox(
                                      width: widget.screenSize.width * 0.05,
                                      child: const ReusableTextField2(
                                        textFieldImage:
                                            'assets/images/PNG Icons/Textfiled_small.png',
                                      )),
                                ],
                              ),
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Container(
                        height: 50,
                        width: digitBoxSize,

                        // color: AppColors.parentZoneScaffoldColor,
                      ),
                    ),
                    ...List.generate(
                      num1Boxes,
                      (index) => Padding(
                        padding: const EdgeInsets.all(8),
                        child: Container(
                          height: 75.h,
                          width: digitBoxSize,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(22.h)),
                          child: Center(
                            child: Text(
                              qu.num1[index],
                              style: AppTextStyles.unitedRounded270w700
                                  .copyWith(
                                      color: Colors.black, fontSize: 122.sp),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Container(
                        height: 50,
                        width: digitBoxSize,
                        // color: AppColors.parentZoneScaffoldColor,
                        child: Center(
                          child: Text(
                            qu.operator,
                            style: AppTextStyles.unitedRounded270w700.copyWith(
                                color: Colors.black, fontSize: 122.sp),
                          ),
                        ),
                      ),
                    ),
                    ...List.generate(
                      num2Boxes,
                      (index) => Padding(
                        padding: const EdgeInsets.all(8),
                        child: Container(
                          height: 75.h,
                          width: digitBoxSize,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(22.h)),
                          child: Center(
                            child: Text(
                              qu.num2[index],
                              style: AppTextStyles.unitedRounded270w700
                                  .copyWith(
                                      color: Colors.black, fontSize: 122.sp),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      height: 2,
                      width:
                          (digitBoxSize + 16) * (num1Boxes + 1), //box+padding
                      color: AppColors.textFieldTextColor,
                    ),
                  ],
                ),
                //! Ans TextFields
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: List.generate(
                      num1Boxes + 1,
                      (index) => Padding(
                            padding: const EdgeInsets.all(8),
                            child: Container(
                              height: 50,
                              width: digitBoxSize,
                              // color: index == num1Boxes
                              //     ? Colors.transparent
                              //     : AppColors.parentZoneScaffoldColor,
                              child: const ReusableTextField2(
                                textFieldImage:
                                    'assets/images/PNG Icons/textfield_arithmetic_ans.png',
                              ),
                            ),
                          )),
                ),
              ],
            ),
          ),
        ),
        Expanded(
            flex: 2,
            child: Container(
              margin: EdgeInsets.all(30.h),
              child: Column(
                children: [
                  Row(
                    children: List.generate(
                        3,
                        (index) => Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.asset(
                                    'assets/images/PNG Icons/arithmetic_keyboard/${index + 1}.png'),
                              ),
                            )),
                  ),
                  Row(
                    children: List.generate(
                        3,
                        (index) => Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.asset(
                                    'assets/images/PNG Icons/arithmetic_keyboard/${index + 4}.png'),
                              ),
                            )),
                  ),
                  Row(
                    children: List.generate(
                        3,
                        (index) => Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.asset(
                                    'assets/images/PNG Icons/arithmetic_keyboard/${index + 7}.png'),
                              ),
                            )),
                  ),
                  Row(
                    children: List.generate(
                        1,
                        (index) => Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Image.asset(
                                    'assets/images/PNG Icons/arithmetic_keyboard/0.png'),
                              ),
                            )),
                  ),
                  // Expanded(
                  //   child: Image.asset(
                  //       'assets/images/PNG Icons/arithmetic_keyboard/0.png'),
                  // )
                ],
              ),
            ))
      ],
    );
  }
}
