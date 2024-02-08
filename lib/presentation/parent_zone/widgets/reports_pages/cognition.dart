import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:size_config/size_config.dart';

import '../../../../core/util/styles.dart';

class CognitionPage extends StatelessWidget {
  const CognitionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      padding: EdgeInsets.symmetric(horizontal: 5.wp),
      child: Column(
        children: [
          10.verticalSpacer,

          Text(
            'Cognition',
            style: AppTextStyles.nunito100w700black.copyWith(fontSize: 26),
          ),
          25.verticalSpacer,
          SizedBox(
            height: 200,
            child: CircularPercentIndicator(
              radius: 100,
              lineWidth: 35,
              percent: 0.77,
              center: const Text(
                "77%",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w700,
                ),
              ),
              progressColor: const Color(0XFFFF8371),
              circularStrokeCap: CircularStrokeCap.round,
              backgroundColor: Colors.white,
            ),
          ),
          // Image.asset(
          //   'assets/images/PNG Icons/Frame 84.png',
          //   height: 200,
          // ),
          25.verticalSpacer,
          ...List.generate(3, (index) {
            var data = [
              {
                'color': '0XFF4DCDF8',
                'percentage': '67',
                'title': 'Procedural Knowledge',
                'subtitle':
                    'The ability to do a task or follow instructions after learning a concept.'
              },
              {
                'color': '0XFF45C375',
                'percentage': '79',
                'title': 'Reasoning Ability',
                'subtitle':
                    'The ability to justify a conclusion or an answer to a solved question.'
              },
              {
                'color': '0XFFFDDC27',
                'percentage': '84',
                'title': 'Recall',
                'subtitle': 'The ability remember gained knowledge.'
              },
            ];

            return Container(
              margin: EdgeInsets.only(bottom: 30.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: CircularPercentIndicator(
                          radius: 50,
                          lineWidth: 15,
                          percent: 0.77,
                          center: Text(
                            "${data[index]['percentage']}%",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          progressColor:
                              Color(int.parse('${data[index]['color']}')),
                          circularStrokeCap: CircularStrokeCap.round,
                          backgroundColor: Colors.white,
                        ),
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
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4.wp)),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${data[index]['title']}',
                                  style: AppTextStyles.nunito100w700black,
                                ),
                                5.verticalSpacer,
                                Text(
                                  '${data[index]['subtitle']}',
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
          }),
          // const _buildProceduralKnowledge(),
          // 20.verticalSpacer,
          // const _buildProceduralKnowledge(),
          // 20.verticalSpacer,
          // const _buildProceduralKnowledge(),
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
                          'Procedural Knowledge',
                          style: AppTextStyles.nunito100w700black,
                        ),
                        5.verticalSpacer,
                        Text(
                          'The ability to do a task or follow instructions after learning a concept.',
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
