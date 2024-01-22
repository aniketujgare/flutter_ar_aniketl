import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:size_config/size_config.dart';

import '../../../../core/util/styles.dart';

class ComprehensionPage extends StatelessWidget {
  const ComprehensionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      padding: EdgeInsets.symmetric(horizontal: 5.wp),
      child: Column(
        children: [
          10.verticalSpacer,
          Text(
            'Comprehension',
            style: AppTextStyles.nunito100w700black.copyWith(fontSize: 26),
          ),
          25.verticalSpacer,
          SizedBox(
            height: 200,
            child: CircularPercentIndicator(
              radius: 100,
              lineWidth: 35,
              percent: 0.72,
              center: const Text(
                "72%",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w700,
                ),
              ),
              progressColor: const Color(0XFF4DCDF8),
              circularStrokeCap: CircularStrokeCap.round,
              backgroundColor: Colors.white,
            ),
          ),
          20.verticalSpacer,
          const _buildProceduralKnowledge(),
          20.verticalSpacer,
          const _buildProceduralKnowledge(),
          20.verticalSpacer,
          const _buildProceduralKnowledge(),
        ],
      ),
    );
  }
}

class _buildProceduralKnowledge extends StatelessWidget {
  const _buildProceduralKnowledge({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Image.asset('assets/images/PNG Icons/Frame 84.png'),
              ),
              150.horizontalSpacer,
              Expanded(
                flex: 3,
                child: Container(
                    // width: double.maxFinite,
                    padding: EdgeInsets.all(3.wp),
                    decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4.wp)),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Listening',
                          style: AppTextStyles.nunito100w700black,
                        ),
                        5.verticalSpacer,
                        Text(
                          'The ability to process auditory information.',
                          style: AppTextStyles.nunito88w400Text,
                        ),
                      ],
                    )),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
