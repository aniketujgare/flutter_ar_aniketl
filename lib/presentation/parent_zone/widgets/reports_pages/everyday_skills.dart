import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:size_config/size_config.dart';

import '../../../../core/util/device_type.dart';
import '../../../../core/util/styles.dart';

class EverydaySkillsPage extends StatelessWidget {
  const EverydaySkillsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      padding: EdgeInsets.symmetric(
        horizontal: 5.wp,
      ),
      child: Column(
        children: [
          10.verticalSpacer,
          Text(
            'Everyday Skills',
            style: AppTextStyles.nunito100w700black
                .copyWith(fontSize: DeviceType().isMobile ? 180.sp : 120.sp),
          ),
          (DeviceType().isMobile ? 10.h : 45).verticalSpacer,
          SizedBox(
            height: 200,
            child: CircularPercentIndicator(
              radius: DeviceType().isMobile ? 620.w : 400.w,
              lineWidth: 45.h,
              percent: 0.70,
              center: const Text(
                "70%",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w700,
                ),
              ),
              progressColor: const Color(0XFF45C375),
              circularStrokeCap: CircularStrokeCap.round,
              backgroundColor: Colors.white,
            ),
          ),
          (DeviceType().isMobile ? 10.h : 45).verticalSpacer,
          ...List.generate(3, (index) {
            var data = [
              {
                'color': '0XFFFDDC27',
                'percentage': '77',
                'title': 'Ecology Consciousness',
                'subtitle': 'Awareness of the environment and its conservation.'
              },
              {
                'color': '0XFF4DCDF8',
                'percentage': '74',
                'title': 'Fine Motor Skills',
                'subtitle':
                    'The ability to intentionally and accurately use finger movements.'
              },
              {
                'color': '0XFF8C7DF0',
                'percentage': '60',
                'title': 'Creative Expression',
                'subtitle': 'The desire to express ideas creatively.'
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
                          radius: DeviceType().isMobile ? 310.w : 250.w,
                          lineWidth: DeviceType().isMobile ? 20.h : 30.h,
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
        ],
      ),
    );
  }
}
