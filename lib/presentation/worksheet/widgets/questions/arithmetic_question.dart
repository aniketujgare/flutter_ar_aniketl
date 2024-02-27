import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_ar/core/util/reusable_widgets/reusable_textfield.dart';
import 'package:flutter_ar/core/util/styles.dart';
import 'package:flutter_ar/presentation/worksheet/models/questions.dart';
import 'package:size_config/size_config.dart';

import '../reusbaleTextField2.dart';

class ArithmeticQuestionUI extends StatefulWidget {
  const ArithmeticQuestionUI(
      {super.key, required this.screenSize, required this.question});
  final Size screenSize;
  final ArithmeticQuestion question;
  @override
  State<ArithmeticQuestionUI> createState() => _ArithmeticQuestionUIState();
}

class _ArithmeticQuestionUIState extends State<ArithmeticQuestionUI> {
  // var qu = ArithmeticQuestion(
  //     num1: widget.question.num1,
  //     num2: '158',
  //     operator: '+',
  //     answer: 'answer',
  //     question: 'question');
  late String number1;
  late String number2;
  late int num1Boxes;
  late int num2Boxes;
  late double digitBoxSize;
  List<TextEditingController> carryControllers = [];
  List<TextEditingController> ansControllers = [];
  // late List<TextFormField> ansTextFields = [];
  late List<String> ansFieldsText = [];
  late int noOfansFields;
  List<double> opcityOfButtons = [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1];
  late String operator;
  String getOperator(String operator) {
    switch (operator) {
      case "Addition":
        return '+';

      default:
    }
    return '-';
  }

  @override
  void initState() {
    super.initState();
    number1 = widget.question.num1;
    number2 = widget.question.num2;
    operator = getOperator(widget.question.operator);

    //?

    int maxLength =
        number1.length > number2.length ? number1.length : number2.length;

// Append zeros to the shorter string until both strings have the same length
    while (number1.length < maxLength) {
      number1 = '0$number1';
    }

    while (number2.length < maxLength) {
      number2 = '0$number2';
    }

    //?
    num1Boxes = number1.length;
    num2Boxes = number2.length;

    // Addition
    //? To calculate no of ans box
    int resultAddition = int.parse(number1.trim()) + int.parse(number2.trim());
    print('addditon res: ${widget.screenSize.width}');
    noOfansFields = resultAddition.toString().length;
    digitBoxSize = (widget.screenSize.width * 0.6) /
        (noOfansFields + (noOfansFields >= 4 ? 0 : 1));
    if (noOfansFields >= 4) {
      digitBoxSize = (widget.screenSize.width * 0.5) / noOfansFields;
    }
    print('addditon res 1: $digitBoxSize');
    noOfansFields = resultAddition.toString().length;
    // Subtraction
    int resultSubtraction =
        int.parse(number1.trim()) - int.parse(number2.trim());

    for (var i = 0; i < num1Boxes + 1; i++) {
      ansFieldsText.add('');
    }
    for (var i = 0; i < noOfansFields; i++) {
      ansControllers.add(TextEditingController());
      if (i < noOfansFields - 1) {
        carryControllers.add(TextEditingController());
      }
    }
  }

  int numPressedint = -1;
  int focusedTextField = -1;
  int focusedCarryField = -1;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.only(top: 15, right: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //!Carry fields
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: List.generate(
                    noOfansFields,
                    (index) {
                      // if (index == noOfansFields - 1) {
                      //   return Container(
                      //     height: 50,
                      //     width: digitBoxSize,
                      //   );
                      // }
                      if (index < carryControllers.length - 1 &&
                          ansControllers[index + 2].text.isEmpty) {
                        return Container(
                          height: 50,
                          width: digitBoxSize,
                        );
                      }
                      return Padding(
                        padding: const EdgeInsets.all(8),
                        child: Container(
                          height: 50,
                          width: digitBoxSize,
                          // color: index == num1Boxes
                          //     ? Colors.transparent
                          //     : AppColors.parentZoneScaffoldColor,
                          child: index == noOfansFields - 1
                              ? null
                              : Row(
                                  children: [
                                    SizedBox(
                                        width: widget.screenSize.width * 0.05,
                                        child: ReusableTextField2(
                                          controller: carryControllers[index],
                                          offset: const Offset(0, 0),
                                          onChanged: (val) {
                                            print(val);
                                          },
                                          onTap: () {
                                            focusedTextField = -1;
                                            focusedCarryField = index;
                                            print(
                                                'focusedCarryField idx: $index');
                                          },
                                          textFieldImage:
                                              'assets/images/PNG Icons/Textfiled_small.png',
                                        )),
                                  ],
                                ),
                        ),
                      );
                    },
                  ),
                ),
                //!num1
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
                              number1[index],
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
                            operator,
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
                              number2[index],
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
                  children: List.generate(noOfansFields, (index) {
                    // if (index == 0 && ansControllers[1].text.isEmpty) {
                    //   return Container(
                    //     height: 50,
                    //     width: digitBoxSize,
                    //   );
                    // }
                    if (index < ansControllers.length - 1 &&
                        ansControllers[index + 1].text.isEmpty) {
                      return Container(
                        height: 70.h,
                        width: digitBoxSize,
                      );
                    }
                    return Padding(
                      padding: const EdgeInsets.all(8),
                      child: Container(
                        height: 70.h,
                        width: digitBoxSize,
                        child: ReusableTextField2(
                          readOnly: false,
                          showCursor: false,
                          controller: ansControllers[index],
                          onChanged: (val) {
                            print('controller idx: $index');
                          },
                          onTap: () {
                            focusedCarryField = -1;
                            focusedTextField = index;
                            print('controller idx: $index');
                          },
                          textFieldImage:
                              'assets/images/PNG Icons/textfield_arithmetic_ans.png',
                        ),
                      ),
                    );
                  }),
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
                  Row(
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
                                opcityOfButtons[index] = 0.5;
                              });
                            },
                            onTapUp: (TapUpDetails details) {
                              // Handle the tap up event, revert the appearance back to normal
                              setState(() {
                                // Example: Revert opacity to its original value
                                opcityOfButtons[index] = 1.0;
                              });
                              // Perform the desired action here (e.g., update text field)
                              numPressed(index + 1);
                              if (focusedTextField != -1) {
                                ansControllers[focusedTextField].text =
                                    numPressedint.toString();
                                // focusedTextField = -1;
                              }
                              if (focusedCarryField != -1) {
                                carryControllers[focusedCarryField].text =
                                    numPressedint.toString();
                              }
                            },
                            onTapCancel: () {
                              // Handle the tap cancel event, revert the appearance back to normal
                              setState(() {
                                // Example: Revert opacity to its original value
                                opcityOfButtons[index] = 1.0;
                              });
                            },
                            child: AnimatedOpacity(
                              opacity: opcityOfButtons[
                                  index], // Variable to control opacity
                              duration: const Duration(
                                  milliseconds:
                                      100), // Duration of the animation
                              child: Image.asset(
                                'assets/images/PNG Icons/arithmetic_keyboard/${index + 1}.png',
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Row(
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
                                      opcityOfButtons[index + 4] = 0.5;
                                    });
                                  },
                                  onTapUp: (TapUpDetails details) {
                                    // Handle the tap up event, revert the appearance back to normal
                                    setState(() {
                                      // Example: Revert opacity to its original value
                                      opcityOfButtons[index + 4] = 1.0;
                                    });
                                    // Perform the desired action here (e.g., update text field)
                                    numPressed(index + 4);
                                    if (focusedTextField != -1) {
                                      ansControllers[focusedTextField].text =
                                          numPressedint.toString();
                                      // focusedTextField = -1;
                                    }
                                    if (focusedCarryField != -1) {
                                      carryControllers[focusedCarryField].text =
                                          numPressedint.toString();
                                    }
                                  },
                                  onTapCancel: () {
                                    // Handle the tap cancel event, revert the appearance back to normal
                                    setState(() {
                                      // Example: Revert opacity to its original value
                                      opcityOfButtons[index + 4] = 1.0;
                                    });
                                  },
                                  child: AnimatedOpacity(
                                    opacity: opcityOfButtons[index +
                                        4], // Variable to control opacity
                                    duration: const Duration(
                                        milliseconds:
                                            100), // Duration of the animation
                                    child: Image.asset(
                                      'assets/images/PNG Icons/arithmetic_keyboard/${index + 4}.png',
                                    ),
                                  ),
                                ),
                              ),
                            )),
                  ),
                  Row(
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
                                      opcityOfButtons[index + 7] = 0.5;
                                    });
                                  },
                                  onTapUp: (TapUpDetails details) {
                                    // Handle the tap up event, revert the appearance back to normal
                                    setState(() {
                                      // Example: Revert opacity to its original value
                                      opcityOfButtons[index + 7] = 1.0;
                                    });
                                    // Perform the desired action here (e.g., update text field)
                                    numPressed(index + 7);
                                    if (focusedTextField != -1) {
                                      ansControllers[focusedTextField].text =
                                          numPressedint.toString();
                                      // focusedTextField = -1;
                                    }
                                    if (focusedCarryField != -1) {
                                      carryControllers[focusedCarryField].text =
                                          numPressedint.toString();
                                    }
                                  },
                                  onTapCancel: () {
                                    // Handle the tap cancel event, revert the appearance back to normal
                                    setState(() {
                                      // Example: Revert opacity to its original value
                                      opcityOfButtons[index + 7] = 1.0;
                                    });
                                  },
                                  child: AnimatedOpacity(
                                    opacity: opcityOfButtons[index +
                                        7], // Variable to control opacity
                                    duration: const Duration(
                                        milliseconds:
                                            100), // Duration of the animation
                                    child: Image.asset(
                                      'assets/images/PNG Icons/arithmetic_keyboard/${index + 7}.png',
                                    ),
                                  ),
                                ),
                              ),
                            )),
                  ),
                  Row(
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
                          },
                          onTapCancel: () {
                            // Handle the tap cancel event, revert the appearance back to normal
                            setState(() {
                              // Example: Revert opacity to its original value
                              opcityOfButtons[10] = 1.0;
                            });
                          },
                          child: AnimatedOpacity(
                            opacity: opcityOfButtons[
                                10], // Variable to control opacity
                            duration: const Duration(
                                milliseconds: 100), // Duration of the animation
                            child: Image.asset(
                              'assets/images/PNG Icons/arithmetic_keyboard/0.png',
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                          child: Expanded(
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
                          },
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.amber, width: 3)),
                                child: const Center(child: Text('Back <-'))),
                          ),
                        ),
                      ))
                    ],
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

  void numPressed(int num) {
    numPressedint = num;
    setState(() {});
  }
}
