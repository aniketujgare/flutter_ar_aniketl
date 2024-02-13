import 'package:flutter/material.dart';
import 'package:flutter_ar/core/util/device_type.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/reports_pagecontroller_cubit/reports_pagecontroller_cubit.dart';
import 'reports_pages/cognition.dart';
import 'reports_pages/comprehension.dart';
import 'reports_pages/everyday_skills.dart';

class ReportsView extends StatefulWidget {
  const ReportsView({super.key});
  static const List<Widget> _pages = [
    CognitionPage(),
    ComprehensionPage(),
    EverydaySkillsPage(),
  ];

  @override
  State<ReportsView> createState() => _ReportsViewState();
}

class _ReportsViewState extends State<ReportsView> {
  @override
  void initState() {
    super.initState();
    context.read<ReportsPagecontrollerCubit>().setPage(0);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BlocBuilder<ReportsPagecontrollerCubit, int>(
          builder: (context, state) {
            return PageView.builder(
                controller:
                    context.read<ReportsPagecontrollerCubit>().pageController,
                onPageChanged: (int page) =>
                    context.read<ReportsPagecontrollerCubit>().setPage(page),
                itemCount: ReportsView._pages.length,
                itemBuilder: (context, pageIndex) {
                  return ReportsView
                      ._pages[pageIndex % ReportsView._pages.length];
                });
          },
        ),
        BlocBuilder<ReportsPagecontrollerCubit, int>(
          builder: (context, state) {
            return Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              height: DeviceType().isMobile ? 90 : 105,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: List<Widget>.generate(
                    ReportsView._pages.length,
                    (index) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: CircleAvatar(
                            radius: 5,
                            backgroundColor: state == index
                                ? const Color(0Xff4D4D4D)
                                : const Color(0XffD9D9D9),
                          ),
                        )),
              ),
            );
          },
        ),
      ],
    );
  }
}
