import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:size_config/size_config.dart';

import '../../../../core/util/styles.dart';
import '../presentation/worksheet/bloc/worksheet_solver_cubit/worksheet_solver_cubit.dart';
import '../presentation/worksheet/models/questions.dart';
import '../presentation/worksheet/widgets/reusbaleTextField2.dart';

class ArithmeticQuestionUI extends StatefulWidget {
  const ArithmeticQuestionUI(
      {super.key,
      required this.screenSize,
      required this.question,
      this.markedAnswer,
      required this.questionIndex});
  final int questionIndex;
  final dynamic markedAnswer;
  final Size screenSize;
  final ArithmeticQuestion question;
  @override
  State<ArithmeticQuestionUI> createState() => _ArithmeticQuestionUIState();
}

class _ArithmeticQuestionUIState extends State<ArithmeticQuestionUI> {
  late String number1;
  late String number2;
  late String num2WithoutPad;
  late int num1Boxes;
  late int num2Boxes;
  List<TextEditingController> carryControllers = [];
  List<TextEditingController> ansControllers = [];
  late int noOfansFields;
  List<double> opcityOfButtons = List.filled(11, 1.0);
  late String operator;

  //? Multiplication Specific
  late List<TextEditingController> carrySumControlllers;
  //?
  String getOperator(String operator) {
    switch (operator) {
      case "Addition":
        return '+';
      case "Subtraction":
        return '-';
      case "Multiplication":
        return 'x';
      default:
        return 'NA';
    }
  }

  @override
  void initState() {
    super.initState();
    number1 = widget.question.num1;
    number2 = widget.question.num2;
    // number1 = '104';
    // number2 = '4';
    num2WithoutPad = number2;

    operator = getOperator(widget.question.operator);
    _prepareData();
    //?
    // //? Fill answers
    // debugPrint('markedAns: ${widget.markedAnswer}');
    // if (widget.markedAnswer != null) {
    //   String answerString = widget.markedAnswer['answer'];
    //   String carryString = widget.markedAnswer['carry'];
    //   if (answerString.isNotEmpty) {
    //     for (var i = 0; i < answerString.length; i++) {
    //       ansControllers[i].text = answerString[i];
    //     }
    //   }
    //   if (carryString.isNotEmpty) {
    //     for (var i = 0; i < carryString.length; i++) {
    //       carryControllers[i].text = carryString[i];
    //     }
    //   }
    // }
  }

  void _prepareData() {
    int maxLength = max(number1.length, number2.length);
    number1 = _padWithZeros(number1, maxLength);
    number2 = _padWithZeros(number2, maxLength);

    num1Boxes = number1.length;
    num2Boxes = number2.length;

    //Calculate No of answer fields required to solve the question
    if (operator == '+') {
      int resultAddition =
          int.parse(number1.trim()) + int.parse(number2.trim());
      noOfansFields = resultAddition.toString().length;
    } else if (operator == '-') {
      noOfansFields = num1Boxes;
    } else if (operator == 'x') {
      // For single digit multiplication

      String number3 = number2.trim();
      print('number2: ${num2WithoutPad}');
      int resultMulti = int.parse(number1.trim()) * int.parse(number2.trim());
      noOfansFields = resultMulti.toString().length;
    } else {
      noOfansFields = num1Boxes;
    }
    if (operator == 'x' && num2WithoutPad.length > 1) {
      //2 digit multiplication
      int carryLen =
          (number2.split('').map((e) => int.parse(e)).toList().reduce(max) *
                      int.parse(number1.trim()))
                  .toString()
                  .length -
              1;
      carryControllers = List.filled(carryLen, TextEditingController());
      int carrySumLen = carryLen + 1;
      carrySumControlllers = List.filled(carrySumLen, TextEditingController());
    } else {
      carryControllers =
          List.filled(noOfansFields - 1, TextEditingController());
    }
    ansControllers = List.filled(noOfansFields, TextEditingController());
    opcityOfButtons = List.filled(11, 1.0);
    print('answer controller length: ${ansControllers.length}');
  }

  String _padWithZeros(String value, int length) {
    while (value.length < length) {
      value = '0$value';
    }
    return value;
  }

  int numPressedint = -1;
  int focusedTextField = -1;
  int focusedCarryField = -1;

  @override
  Widget build(BuildContext context) {
    if (getOperator(widget.question.operator) == 'NA') {
      return Center(
        child: Text(
          'Functionality is not there for Divison',
          style: AppTextStyles.nunito120w700primary,
        ),
      );
    }
    if (operator == '+' || operator == '-') {
      return _buildAdditionAndSubtraction();
    } else if (operator == 'x') {
      if (num2WithoutPad.length == 1) {
        return _buildMultiPlication1Digit();
      } else {
        return _buildMultiPlication2Digit();
      }
    } else {
      return _buildMultiPlication1Digit();
    }
  }

  Row _buildAdditionAndSubtraction() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.zero,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //!Carry fields
                Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  ...List.generate(num1Boxes + 1 - ansControllers.length,
                      (index) => _buildEmptyBox()),
                  ...List.generate(
                    ansControllers.length - 1,
                    (index) {
                      return Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: SizedBox(
                            height: 70.h,
                            child: Row(
                              children: [
                                SizedBox(
                                    width: widget.screenSize.width * 0.06,
                                    child: index !=
                                                carryControllers.length - 1 &&
                                            ansControllers[index + 2]
                                                .text
                                                .isEmpty
                                        ? null
                                        : ReusableTextField2(
                                            controller: carryControllers[index],
                                            offset: Offset(3.w, -7.h),
                                            onChanged: (val) {
                                              debugPrint(val);
                                            },
                                            onTap: () {
                                              focusedTextField = -1;
                                              focusedCarryField = index;
                                              debugPrint(
                                                  'focusedCarryField idx: $index');
                                            },
                                            textFieldImage:
                                                'assets/images/PNG Icons/Textfiled_small.png',
                                          )),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  _buildEmptyBox()
                ]),
                //!num1
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    _buildEmptyBox(),
                    ...List.generate(
                      num1Boxes,
                      (index) => Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Container(
                            height: 75.h,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(22.h)),
                            child: Center(
                              child: Text(
                                number1[index],
                                style: AppTextStyles.unitedRounded270w700
                                    .copyWith(
                                        color: Colors.black, fontSize: 122.sp),
                              ),
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
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: SizedBox(
                          height: 70.h,
                          child: Center(
                            child: Text(
                              operator,
                              style: AppTextStyles.unitedRounded270w700
                                  .copyWith(
                                      color: Colors.black, fontSize: 122.sp),
                            ),
                          ),
                        ),
                      ),
                    ),
                    ...List.generate(
                      num2Boxes,
                      (index) => Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Container(
                            height: 70.h,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(22.h)),
                            child: Center(
                              child: Text(
                                number2[index],
                                style: AppTextStyles.unitedRounded270w700
                                    .copyWith(
                                        color: Colors.black, fontSize: 122.sp),
                              ),
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
                    Expanded(
                      child: Container(
                        height: 2,
                        color: AppColors.textFieldTextColor,
                      ),
                    ),
                  ],
                ),
                //! Ans TextFields
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ...List.generate(num1Boxes + 1 - ansControllers.length,
                        (index) => _buildEmptyBox()),
                    ...List.generate(ansControllers.length, (index) {
                      print(
                          'answer controller idx: $index && ans text: ${ansControllers[index].text}');
                      if (index < ansControllers.length - 1 &&
                          ansControllers[index + 1].text.isEmpty) {
                        return Expanded(
                          child: SizedBox(
                            height: 70.h,
                          ),
                        );
                      }
                      return Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: SizedBox(
                            height: 70.h,
                            child: ReusableTextField2(
                              readOnly: false,
                              showCursor: false,
                              controller: ansControllers[index],
                              onChanged: (val) {
                                debugPrint('controller idx: $index');
                              },
                              onTap: () {
                                focusedCarryField = -1;
                                focusedTextField = index;
                                debugPrint('controller idx: $index');
                              },
                              textFieldImage:
                                  'assets/images/PNG Icons/textfield_arithmetic_ans.png',
                            ),
                          ),
                        ),
                      );
                    })
                  ],
                ),
              ],
            ),
          ),
        ),
        //! numPad
        Expanded(
            flex: 2,
            child: Container(
              margin: EdgeInsets.all(30.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildNumPadRow(1, 3),
                  _buildNumPadRow(4, 6),
                  _buildNumPadRow(7, 9),
                  _buildNumPadZero(),
                ],
              ),
            ))
      ],
    );
  }

  Row _buildMultiPlication1Digit() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.zero,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //!Carry fields
                Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  ...List.generate(num1Boxes + 1 - ansControllers.length,
                      (index) => _buildEmptyBox()),
                  ...List.generate(
                    ansControllers.length - 1,
                    (index) {
                      return Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: SizedBox(
                            height: 70.h,
                            child: Row(
                              children: [
                                SizedBox(
                                    width: widget.screenSize.width * 0.06,
                                    child: index !=
                                                carryControllers.length - 1 &&
                                            ansControllers[index + 2]
                                                .text
                                                .isEmpty
                                        ? null
                                        : ReusableTextField2(
                                            controller: carryControllers[index],
                                            offset: Offset(3.w, -7.h),
                                            onChanged: (val) {
                                              debugPrint(val);
                                            },
                                            onTap: () {
                                              focusedTextField = -1;
                                              focusedCarryField = index;
                                              debugPrint(
                                                  'focusedCarryField idx: $index');
                                            },
                                            textFieldImage:
                                                'assets/images/PNG Icons/Textfiled_small.png',
                                          )),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  _buildEmptyBox()
                ]),
                //!num1
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    _buildEmptyBox(),
                    ...List.generate(
                      num1Boxes,
                      (index) => Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Container(
                            height: 75.h,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(22.h)),
                            child: Center(
                              child: Text(
                                number1[index],
                                style: AppTextStyles.unitedRounded270w700
                                    .copyWith(
                                        color: Colors.black, fontSize: 122.sp),
                              ),
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
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: SizedBox(
                          height: 70.h,
                          child: Center(
                            child: Text(
                              operator,
                              style: AppTextStyles.unitedRounded270w700
                                  .copyWith(
                                      color: Colors.black, fontSize: 122.sp),
                            ),
                          ),
                        ),
                      ),
                    ),
                    //!num2
                    ...List.generate(
                      num2Boxes,
                      (index) => Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: number2
                                  .substring(index + 1)
                                  .contains(RegExp(r'[1-9]'))
                              ? const SizedBox() // hide extra padded num2 digit box, keep it original num,length
                              : Container(
                                  height: 70.h,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                          BorderRadius.circular(22.h)),
                                  child: Center(
                                    child: Text(
                                      number2[index],
                                      style: AppTextStyles.unitedRounded270w700
                                          .copyWith(
                                              color: Colors.black,
                                              fontSize: 122.sp),
                                    ),
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
                    Expanded(
                      child: Container(
                        height: 2,
                        color: AppColors.textFieldTextColor,
                      ),
                    ),
                  ],
                ),
                //! Ans TextFields
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ...List.generate(num1Boxes + 1 - ansControllers.length,
                        (index) => _buildEmptyBox()),
                    ...List.generate(ansControllers.length, (index) {
                      if (index < ansControllers.length - 1 &&
                          ansControllers[index + 1].text.isEmpty) {
                        return Expanded(
                          child: SizedBox(
                            height: 70.h,
                          ),
                        );
                      }
                      return Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: SizedBox(
                            height: 70.h,
                            child: ReusableTextField2(
                              readOnly: false,
                              showCursor: false,
                              controller: ansControllers[index],
                              onChanged: (val) {
                                debugPrint('controller idx: $index');
                              },
                              onTap: () {
                                focusedCarryField = -1;
                                focusedTextField = index;
                                debugPrint('controller idx: $index');
                              },
                              textFieldImage:
                                  'assets/images/PNG Icons/textfield_arithmetic_ans.png',
                            ),
                          ),
                        ),
                      );
                    })
                  ],
                ),
              ],
            ),
          ),
        ),
        //! numPad
        Expanded(
            flex: 2,
            child: Container(
              margin: EdgeInsets.all(30.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildNumPadRow(1, 3),
                  _buildNumPadRow(4, 6),
                  _buildNumPadRow(7, 9),
                  _buildNumPadZero(),
                ],
              ),
            ))
      ],
    );
  }

  Row _buildMultiPlication2Digit() {
    // int gridRow  = 3+;
    int gridCol = (int.parse(number1.trim()) * int.parse(number2.trim()))
            .toString()
            .length +
        1;
    int carryTopLen =
        (number2.split('').map((e) => int.parse(e)).toList().reduce(max) *
                    int.parse(number1.trim()))
                .toString()
                .length -
            1;
    int carrySumLen = carryTopLen + 1;
    int sumAnsNum1Len =
        (int.parse(number1.trim()) * int.parse(number2[number2.length - 1]))
            .toString()
            .length;
    int sumAnsNum2Len =
        (int.parse(number1.trim()) * int.parse(number2[number2.length - 2]))
            .toString()
            .length;
    int sum1AnsLen =
        ((int.parse(number1.trim()) * int.parse(number2[number2.length - 1])) +
                ((int.parse(number1.trim()) *
                        int.parse(number2[number2.length - 2])) *
                    10))
            .toString()
            .length;
    print(
        'gridColLen: ${gridCol} || carryTopLen: ${carryTopLen} carrySumLen: $carrySumLen || sumAnsNum1Len: $sumAnsNum1Len || sumAnsNum2Len: $sumAnsNum2Len');
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 5,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.zero,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //!Carry fields Top
                  Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                    ...List.generate(
                        gridCol - carryTopLen - 1, (index) => _buildEmptyBox()),
                    ...List.generate(
                      carryTopLen,
                      (index) {
                        return Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: SizedBox(
                              height: 70.h,
                              child: Row(
                                children: [
                                  SizedBox(
                                      width: widget.screenSize.width * 0.06,
                                      child:
                                          // index !=
                                          //             carryControllers.length - 1 &&
                                          //         ansControllers[index + 2]
                                          //             .text
                                          //             .isEmpty
                                          //     ? null
                                          //     :
                                          ReusableTextField2(
                                        controller: carryControllers[index],
                                        offset: Offset(3.w, -7.h),
                                        onChanged: (val) {
                                          debugPrint(val);
                                        },
                                        onTap: () {
                                          focusedTextField = -1;
                                          focusedCarryField = index;
                                          debugPrint(
                                              'focusedCarryField idx: $index');
                                        },
                                        textFieldImage:
                                            'assets/images/PNG Icons/Textfiled_small.png',
                                      )),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    _buildEmptyBox()
                  ]),
                  //!num1
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ...List.generate(
                          gridCol - num1Boxes, (index) => _buildEmptyBox()),
                      ...List.generate(
                        num1Boxes,
                        (index) => Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Container(
                              height: 75.h,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(22.h)),
                              child: Center(
                                child: Text(
                                  number1[index],
                                  style: AppTextStyles.unitedRounded270w700
                                      .copyWith(
                                          color: Colors.black,
                                          fontSize: 122.sp),
                                ),
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
                      //! Operator
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: SizedBox(
                            height: 70.h,
                            child: Center(
                              child: Text(
                                operator,
                                style: AppTextStyles.unitedRounded270w700
                                    .copyWith(
                                        color: Colors.black, fontSize: 122.sp),
                              ),
                            ),
                          ),
                        ),
                      ),
                      ...List.generate(
                          gridCol - num2Boxes - 1, (index) => _buildEmptyBox()),
                      //!num2
                      ...List.generate(
                        num2Boxes,
                        (index) => Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Container(
                              height: 70.h,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(22.h)),
                              child: Center(
                                child: Text(
                                  number2[index],
                                  style: AppTextStyles.unitedRounded270w700
                                      .copyWith(
                                          color: Colors.black,
                                          fontSize: 122.sp),
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  //!Line Black
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Container(
                          height: 2,
                          color: AppColors.textFieldTextColor,
                        ),
                      ),
                    ],
                  ),
                  //! Ans TextFields
                  //! Repetative part for answer

                  //! 1: Carry Field for summition
                  Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                    ...List.generate(
                        gridCol - carrySumLen - 1, (index) => _buildEmptyBox()),
                    ...List.generate(
                      carrySumLen,
                      (index) {
                        return Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: SizedBox(
                              height: 70.h,
                              child: Row(
                                children: [
                                  SizedBox(
                                      width: widget.screenSize.width * 0.06,
                                      child:
                                          // index !=
                                          //             carryControllers.length - 1 &&
                                          //         ansControllers[index + 2]
                                          //             .text
                                          //             .isEmpty
                                          //     ? null
                                          //     :
                                          ReusableTextField2(
                                        controller: carrySumControlllers[index],
                                        offset: Offset(3.w, -7.h),
                                        onChanged: (val) {
                                          debugPrint(val);
                                        },
                                        onTap: () {
                                          focusedTextField = -1;
                                          focusedCarryField = index;
                                          debugPrint(
                                              'focusedCarryField idx: $index');
                                        },
                                        textFieldImage:
                                            'assets/images/PNG Icons/Textfiled_small.png',
                                      )),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    _buildEmptyBox()
                  ]),
                  //! 2: Sum Ans num1
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ...List.generate(
                          gridCol - sumAnsNum1Len, (index) => _buildEmptyBox()),
                      ...List.generate(sumAnsNum1Len, (index) {
                        // if (index < ansControllers.length - 1 &&
                        //     ansControllers[index + 1].text.isEmpty) {
                        //   return Expanded(
                        //     child: SizedBox(
                        //       height: 70.h,
                        //     ),
                        //   );
                        // }
                        return Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: SizedBox(
                              height: 70.h,
                              child: ReusableTextField2(
                                readOnly: false,
                                showCursor: false,
                                controller:
                                    TextEditingController(), //ansControllers[index],
                                onChanged: (val) {
                                  debugPrint('controller idx: $index');
                                },
                                onTap: () {
                                  focusedCarryField = -1;
                                  focusedTextField = index;
                                  debugPrint('controller idx: $index');
                                },
                                textFieldImage:
                                    'assets/images/PNG Icons/textfield_arithmetic_ans.png',
                              ),
                            ),
                          ),
                        );
                      })
                    ],
                  ),
                  //! 2: Sum Ans num2
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: SizedBox(
                            height: 70.h,
                            child: Center(
                              child: Text(
                                '+',
                                style: AppTextStyles.unitedRounded270w700
                                    .copyWith(
                                        color: Colors.black, fontSize: 122.sp),
                              ),
                            ),
                          ),
                        ),
                      ),
                      ...List.generate(
                          gridCol -
                              sumAnsNum2Len -
                              1 -
                              1, //1 for x mark and -1 for + mark
                          (index) => _buildEmptyBox()),
                      ...List.generate(sumAnsNum2Len, (index) {
                        // if (index < ansControllers.length - 1 &&
                        //     ansControllers[index + 1].text.isEmpty) {
                        //   return Expanded(
                        //     child: SizedBox(
                        //       height: 70.h,
                        //     ),
                        //   );
                        // }
                        return Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: SizedBox(
                              height: 70.h,
                              child: ReusableTextField2(
                                readOnly: false,
                                showCursor: false,
                                controller:
                                    TextEditingController(), //ansControllers[index],
                                onChanged: (val) {
                                  debugPrint('controller idx: $index');
                                },
                                onTap: () {
                                  focusedCarryField = -1;
                                  focusedTextField = index;
                                  debugPrint('controller idx: $index');
                                },
                                textFieldImage:
                                    'assets/images/PNG Icons/textfield_arithmetic_ans.png',
                              ),
                            ),
                          ),
                        );
                      }),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Container(
                            height: 65.h,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(22.h)),
                            child: Center(
                              child: Text(
                                'x',
                                style: AppTextStyles.unitedRounded270w700
                                    .copyWith(
                                        color: Colors.black, fontSize: 122.sp),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  //!Line Black
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Container(
                          height: 2,
                          color: AppColors.textFieldTextColor,
                        ),
                      ),
                    ],
                  ),

                  //! Ans Sum1 TextFields
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ...List.generate(
                          gridCol - sum1AnsLen, (index) => _buildEmptyBox()),
                      ...List.generate(sum1AnsLen, (index) {
                        // if (index < ansControllers.length - 1 &&
                        //     ansControllers[index + 1].text.isEmpty) {
                        //   return Expanded(
                        //     child: SizedBox(
                        //       height: 70.h,
                        //     ),
                        //   );
                        // }
                        return Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: SizedBox(
                              height: 70.h,
                              child: ReusableTextField2(
                                readOnly: false,
                                showCursor: false,
                                controller: ansControllers[index],
                                onChanged: (val) {
                                  debugPrint('controller idx: $index');
                                },
                                onTap: () {
                                  focusedCarryField = -1;
                                  focusedTextField = index;
                                  debugPrint('controller idx: $index');
                                },
                                textFieldImage:
                                    'assets/images/PNG Icons/textfield_arithmetic_ans.png',
                              ),
                            ),
                          ),
                        );
                      })
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        //! numPad
        Expanded(
            flex: 2,
            child: Container(
              margin: EdgeInsets.all(30.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildNumPadRow(1, 3),
                  _buildNumPadRow(4, 6),
                  _buildNumPadRow(7, 9),
                  _buildNumPadZero(),
                ],
              ),
            ))
      ],
    );
  }

  Expanded _buildEmptyBox() {
    return Expanded(
      child: SizedBox(
        height: 70.h,
      ),
    );
  }

  Row _buildNumPadZero() {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTapDown: (TapDownDetails details) {
              // Handle the tap down event, you can change the appearance here
              setState(() {
                // Example: Change opacity to simulate a button press
                opcityOfButtons[10] = 0.5;
              });
            },
            onTapUp: (TapUpDetails details) {
              // Handle the tap up event, revert the appearance back to normal
              setState(() {
                // Example: Revert opacity to its original value
                opcityOfButtons[10] = 1.0;
              });
              // Perform the desired action here (e.g., update text field)
              numPressed(0);
              if (focusedTextField != -1) {
                ansControllers[focusedTextField].text =
                    numPressedint.toString();
                // focusedTextField = -1;
              }
              if (focusedCarryField != -1) {
                carryControllers[focusedCarryField].text =
                    numPressedint.toString();
              }
              saveAnswer();
            },
            onTapCancel: () {
              // Handle the tap cancel event, revert the appearance back to normal
              setState(() {
                // Example: Revert opacity to its original value
                opcityOfButtons[10] = 1.0;
              });
            },
            child: AnimatedOpacity(
              opacity: opcityOfButtons[10], // Variable to control opacity
              duration: const Duration(
                  milliseconds: 100), // Duration of the animation
              child: Image.asset(
                'assets/images/PNG Icons/arithmetic_keyboard/0.png',
              ),
            ),
          ),
        ),
        Expanded(
            child: GestureDetector(
          onTap: () {
            numPressed(0);
            if (focusedTextField != -1) {
              ansControllers[focusedTextField].clear();
              // focusedTextField = -1;
            }
            if (focusedCarryField != -1) {
              carryControllers[focusedCarryField].clear();
              // focusedCarryField == -1;
            }
            saveAnswer();
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.amber, width: 3)),
                child: const Center(child: Text('Back <-'))),
          ),
        ))
      ],
    );
  }

  void numPressed(int num) {
    setState(() {
      numPressedint = num;
    });
  }

  void saveAnswer() {
    //? Save Answer
    var ansTexts = [];
    var carryTexts = [];
    for (var element in ansControllers) {
      if (element.text.isNotEmpty) {
        ansTexts.add(element.text);
      }
    }
    for (var element in carryControllers) {
      if (element.text.isNotEmpty) {
        carryTexts.add(element.text);
      }
    }
    // debugPrint('answer fields:  ans-> ${ansTexts} carry-> $carryTexts');
    if (ansTexts.length == noOfansFields) {
      // Store answer {answer: <String> answer, carry: <String> carry}
      String answer = '';
      ansTexts.forEach((ans) => answer += ans);
      String carry = '';
      carryControllers.forEach((carrContr) => carry += carrContr.text);
      debugPrint('answer fields:  ans-> $answer carry-> $carry');
      context
          .read<WorksheetSolverCubit>()
          .setAnswer(widget.questionIndex, {'answer': answer, 'carry': carry});
    }
  }

  _buildNumPadRow(int start, int end) {
    return Row(
      children: List.generate(
        3,
        (index) => Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTapDown: (TapDownDetails details) {
                // Handle the tap down event, you can change the appearance here
                setState(() {
                  // Example: Change opacity to simulate a button press
                  opcityOfButtons[index + start] = 0.5;
                });
              },
              onTapUp: (TapUpDetails details) {
                // Handle the tap up event, revert the appearance back to normal
                setState(() {
                  // Example: Revert opacity to its original value
                  opcityOfButtons[index + start] = 1.0;
                });
                // Perform the desired action here (e.g., update text field)
                numPressed(index + start);
                if (focusedTextField != -1) {
                  ansControllers[focusedTextField].text =
                      numPressedint.toString();
                  // focusedTextField = -1;
                  var v = List.generate(ansControllers.length,
                      (index) => ansControllers[index].text);
                  print(
                      'focusedTextField: $focusedTextField || answer controller idx: $index && ans text: ${ansControllers[index].text} || ansContrller: ${v}');
                }
                if (focusedCarryField != -1) {
                  carryControllers[focusedCarryField].text =
                      numPressedint.toString();
                }
                saveAnswer();
              },
              onTapCancel: () {
                // Handle the tap cancel event, revert the appearance back to normal
                setState(() {
                  // Example: Revert opacity to its original value
                  opcityOfButtons[index + start] = 1.0;
                });
              },
              child: AnimatedOpacity(
                opacity: opcityOfButtons[
                    index + start], // Variable to control opacity
                duration: const Duration(
                    milliseconds: 100), // Duration of the animation
                child: Image.asset(
                  'assets/images/PNG Icons/arithmetic_keyboard/${index + start}.png',
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
