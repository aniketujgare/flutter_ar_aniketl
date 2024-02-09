import 'package:flutter/material.dart';
import '../../../../core/util/device_type.dart';
import '../../../../core/util/styles.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:size_config/size_config.dart';

class AscendingDecendingTese extends StatelessWidget {
  const AscendingDecendingTese({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            // Draggable Widget
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ...List.generate(
                    4,
                    (index) => Draggable<String>(
                          data: '$index',
                          feedback: Container(
                            width: 30.wp,
                            padding: EdgeInsets.symmetric(vertical: 2.5.wp),
                            decoration: ShapeDecoration(
                              color: const Color(0xFFF4F2FE),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(17),
                              ),
                            ),
                            child: Text(
                              '$index',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Color(0xFF4F3A9C),
                                fontSize: 20,
                                fontFamily: 'Nunito',
                                fontWeight: FontWeight.w700,
                                height: 0,
                              ),
                            ),
                          ),
                          childWhenDragging: Container(
                            width: 30.wp,
                            padding: EdgeInsets.symmetric(vertical: 2.5.wp),
                            decoration: ShapeDecoration(
                              color: AppColors.hintTextColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(17),
                              ),
                            ),
                            child: Text(
                              '$index',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Color(0xFF4F3A9C),
                                fontSize: 20,
                                fontFamily: 'Nunito',
                                fontWeight: FontWeight.w700,
                                height: 0,
                              ),
                            ),
                          ),
                          child: Container(
                            width: 30.wp,
                            padding: EdgeInsets.symmetric(vertical: 2.wp),
                            decoration: ShapeDecoration(
                              color: const Color(0xFFF4F2FE),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(17),
                              ),
                            ),
                            child: Text(
                              '$index',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Color(0xFF4F3A9C),
                                fontSize: 20,
                                fontFamily: 'Nunito',
                                fontWeight: FontWeight.w700,
                                height: 0,
                              ),
                            ),
                          ),
                        ))
              ],
            ),

            // building Drag Target Widget
            // 50.verticalSpacer,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ...List.generate(
                  4,
                  (index) => DragTarget<String>(
                    onWillAccept: (data) {
                      print('accepted data:$data');
                      return data == 'red';
                    },
                    onAccept: (data) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Dropped successfully!')));
                    },
                    builder: (
                      BuildContext context,
                      List<dynamic> accepted,
                      List<dynamic> rejected,
                    ) {
                      return Container(
                        width: 30.wp,
                        padding: EdgeInsets.symmetric(vertical: 2.wp),
                        decoration: ShapeDecoration(
                          color: const Color(0xFFF4F2FE),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(17),
                          ),
                        ),
                        child: Text(
                          '$index',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Color(0xFFF4F2FE),
                            fontSize: 22,
                            fontFamily: 'Nunito',
                            fontWeight: FontWeight.w700,
                            height: 0,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      //  Column(
      //   mainAxisSize: MainAxisSize.max,
      //   mainAxisAlignment: MainAxisAlignment.center,
      //   crossAxisAlignment: CrossAxisAlignment.center,
      //   children: [
      //     QuestionText(question: question.question),
      //     DeviceType().isMobile ? 55.verticalSpacer : 85.verticalSpacer,
      //     Padding(
      //       padding: EdgeInsets.symmetric(horizontal: 4.wp),
      //       child: Row(
      //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //         children: [
      //           ...List.generate(
      //               question.numbers.length,
      //               (index) => Draggable<String>(
      //                     data: question.numbers[index],
      //                     feedback: Container(
      //                       width: 30.wp,
      //                       padding: EdgeInsets.symmetric(vertical: 2.5.wp),
      //                       decoration: ShapeDecoration(
      //                         color: const Color(0xFFF4F2FE),
      //                         shape: RoundedRectangleBorder(
      //                           borderRadius: BorderRadius.circular(17),
      //                         ),
      //                       ),
      //                       child: Text(
      //                         question.numbers[index],
      //                         textAlign: TextAlign.center,
      //                         style: const TextStyle(
      //                           color: Color(0xFF4F3A9C),
      //                           fontSize: 20,
      //                           fontFamily: 'Nunito',
      //                           fontWeight: FontWeight.w700,
      //                           height: 0,
      //                         ),
      //                       ),
      //                     ),
      //                     childWhenDragging: Container(
      //                       width: 30.wp,
      //                       padding: EdgeInsets.symmetric(vertical: 2.5.wp),
      //                       decoration: ShapeDecoration(
      //                         color: AppColors.hintTextColor,
      //                         shape: RoundedRectangleBorder(
      //                           borderRadius: BorderRadius.circular(17),
      //                         ),
      //                       ),
      //                       child: Text(
      //                         question.numbers[index],
      //                         textAlign: TextAlign.center,
      //                         style: const TextStyle(
      //                           color: Color(0xFF4F3A9C),
      //                           fontSize: 20,
      //                           fontFamily: 'Nunito',
      //                           fontWeight: FontWeight.w700,
      //                           height: 0,
      //                         ),
      //                       ),
      //                     ),
      //                     child: Container(
      //                       width: 30.wp,
      //                       padding: EdgeInsets.symmetric(vertical: 2.wp),
      //                       decoration: ShapeDecoration(
      //                         color: const Color(0xFFF4F2FE),
      //                         shape: RoundedRectangleBorder(
      //                           borderRadius: BorderRadius.circular(17),
      //                         ),
      //                       ),
      //                       child: Text(
      //                         question.numbers[index],
      //                         textAlign: TextAlign.center,
      //                         style: const TextStyle(
      //                           color: Color(0xFF4F3A9C),
      //                           fontSize: 20,
      //                           fontFamily: 'Nunito',
      //                           fontWeight: FontWeight.w700,
      //                           height: 0,
      //                         ),
      //                       ),
      //                     ),
      //                   ))
      //         ],
      //       ),
      //     ),
      //     50.verticalSpacer,
      //     Row(
      //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //       children: [
      //         ...List.generate(
      //           question.numbers.length,
      //           (index) => DragTarget<String>(
      //             onWillAccept: (data) {
      //               return data == 'red';
      //             },
      //             onAccept: (data) {
      //               ScaffoldMessenger.of(context).showSnackBar(
      //                   const SnackBar(content: Text('Dropped successfully!')));
      //             },
      //             builder: (
      //               BuildContext context,
      //               List<dynamic> accepted,
      //               List<dynamic> rejected,
      //             ) {
      //               return Container(
      //                 width: 30.wp,
      //                 padding: EdgeInsets.symmetric(vertical: 2.wp),
      //                 decoration: ShapeDecoration(
      //                   color: const Color(0xFFF4F2FE),
      //                   shape: RoundedRectangleBorder(
      //                     borderRadius: BorderRadius.circular(17),
      //                   ),
      //                 ),
      //                 child: Text(
      //                   question.numbers[index],
      //                   textAlign: TextAlign.center,
      //                   style: const TextStyle(
      //                     color: Color(0xFFF4F2FE),
      //                     fontSize: 22,
      //                     fontFamily: 'Nunito',
      //                     fontWeight: FontWeight.w700,
      //                     height: 0,
      //                   ),
      //                 ),
      //               );
      //             },
      //           ),
      //         ),
      //       ],
      //     ),
      //   ],
      // ),
    );
  }
}
