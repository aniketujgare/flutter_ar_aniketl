import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ar/presentation/subject/widgets/camera_feature.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:size_config/size_config.dart';

import '../../../../core/util/device_type.dart';
import '../../../../core/util/styles.dart';
import '../../bloc/worksheet_solver_cubit/worksheet_solver_cubit.dart';
import '../../models/questions.dart';

class IdentifyImageQuestion extends StatelessWidget {
  final int questionIndex;
  final IdentifyImageQuestionType question;
  final String markedAnswer;
  const IdentifyImageQuestion(
      {super.key,
      required this.questionIndex,
      required this.question,
      required this.markedAnswer});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Dismiss the keyboard when tapped outside the TextField
        // print('tapped outside textfield');
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            DeviceType().isMobile ? 25.verticalSpacer : 90.verticalSpacer,
            Container(
              height: 45.wp,
              width: 45.wp,
              decoration: ShapeDecoration(
                color: AppColors.boxUnselectedolor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(17),
                ),
              ),
              child: CachedNetworkImage(
                imageUrl: question.question,
                fit: BoxFit.cover,
                imageBuilder: (context, imageProvider) => Container(
                  // width: 180.h,
                  // height: 180.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                placeholder: (context, url) => const Center(
                  child: CircularProgressIndicator.adaptive(
                      strokeCap: StrokeCap.round),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
            DeviceType().isMobile ? 25.verticalSpacer : 85.verticalSpacer,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 7.wp),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      SizedBox(
                        width: 70.wp,
                        height: 60,
                        child: Image.asset(
                          'assets/images/PNG Icons/Vector.png',
                          fit: BoxFit.fill,
                        ),
                      ),
                      Transform.translate(
                        offset: Offset(0, 5.h),
                        child: Container(
                          width: 70.wp,
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: TextFormField(
                            initialValue: markedAnswer,
                            decoration: const InputDecoration(
                              // labelText: 'Type your answer',
                              border: InputBorder.none,
                            ),
                            // initialValue: ans,
                            onChanged: (value) {
                              context
                                  .read<WorksheetSolverCubit>()
                                  .setAnswer(questionIndex, value);
                            },
                            onEditingComplete: () {
                              print('complete');
                              FocusScope.of(context).requestFocus(FocusNode());
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  5.horizontalSpacerPercent,
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => CameraFeature()));
                    },
                    child: SizedBox(
                        width: 55,
                        child:
                            Image.asset('assets/images/PNG Icons/Cam 1.png')),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
